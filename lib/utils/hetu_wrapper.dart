import 'package:dart_eval/stdlib/core.dart';
import 'package:get/get.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:iot_app/controllers/orchestrator.dart';

class HetuWrapper {
  final OrchestratorController _orchestrator =
      Get.find<OrchestratorController>();

  Future<void> initialize() async {
    // Initialization complete - dart_eval doesn't require pre-initialization
  }

  Runtime _createRuntime(String script) {
    final compiler = Compiler();

    // Add custom functions
    final customFunctions = '''
double map(double value, double inMin, double inMax, double outMin, double outMax) {
  return ((value - inMin) * (outMax - outMin)) / (inMax - inMin) + outMin;
}

double lerp(double a, double b, double value) {
  return a + (b - a) * value;
}
''';

    final fullScript = customFunctions + '\n' + script;

    try {
      final program = compiler.compile({
        'main': {'main.dart': fullScript},
      });

      return Runtime.ofProgram(program);
    } catch (e) {
      print('Compilation error: $e');
      rethrow;
    }
  }

  $Value _wrapForEval(dynamic value) {
    if (value is Map) {
      final wrapped = <Object, Object>{};
      value.forEach((k, v) {
        final wk = k is String ? $String(k) : _wrapForEval(k);
        wrapped[wk] = _wrapForEval(v);
      });
      return $Map.wrap(wrapped);
    } else if (value is List) {
      return $List.wrap(value.map(_wrapForEval).toList());
    } else if (value is String) {
      return $String(value);
    } else if (value is int) {
      return $int(value);
    } else if (value is double) {
      return $double(value);
    } else if (value is bool) {
      return $bool(value);
    } else if (value == null) {
      return $null();
    }

    // Fallback: wrap to string to avoid bridge type errors
    return $String(value.toString());
  }

  Map<String, dynamic> executeEvaluator(
    String script,
    String integrationId,
    Map<String, dynamic> props,
  ) {
    try {
      // Normalize props for use in Dart code
      // var normalizedProps = normalizeKeys(props);
      // print("Props passed to evaluator: $normalizedProps");

      // Convert props to a string representation for embedding in the script
      // final propsLiteral = _convertToLiteral(normalizedProps);

      // Build the complete evaluator script with props embedded as a literal
      //       final fullScript =
      //           '''
      // Map<String, dynamic> evaluate() {
      //   final props = $propsLiteral;
      // $script
      // }

      // dynamic main() {
      //   return evaluate();
      // }
      // ''';
      //       print(fullScript);
      //       final runtime = _createRuntime(fullScript, normalizedProps);
      //       final result = runtime.executeLib('package:main/main.dart', 'main', );

      //       print("Evaluator result: $result");
      //       print("Evaluator result type: ${result.runtimeType}");

      //       // Handle different return types from dart_eval
      //       if (result is $Value) {
      //         final unwrapped = result.$reified;
      //         print("Unwrapped value: $unwrapped (${unwrapped.runtimeType})");
      //         if (unwrapped is Map) {
      //           return Map<String, dynamic>.from(unwrapped);
      //         }
      //         return {'result': unwrapped};
      //       } else if (result is Map) {
      //         return Map<String, dynamic>.from(result);
      //       }

      //       return {'result': result};
      final fullScript =
          '''
Map<String, dynamic> evaluate(Map<String, dynamic> props, String integrationId) {
$script
}

dynamic main(Map<String, dynamic> props, String integrationId) {
  return evaluate(props, integrationId);
}
''';

      final runtime = _createRuntime(fullScript);
      final result = runtime.executeLib('package:main/main.dart', 'main', [
        _wrapForEval(props),
        _wrapForEval(integrationId)
      ]);

      print("Evaluator result: $result");
      print("Evaluator result type: ${result.runtimeType}");

      if (result is $Value) {
        final unwrapped = result.$reified;
        print("Unwrapped value: $unwrapped (${unwrapped.runtimeType})");
        if (unwrapped is Map) {
          return Map<String, dynamic>.from(unwrapped);
        }
        return {'result': unwrapped};
      } else if (result is Map) {
        return Map<String, dynamic>.from(result);
      }

      return {'result': result};
    } catch (e) {
      print('Error in executeEvaluator: $e');
      rethrow;
    }
  }

  void executeTransformer(String script, String integrationId, Map<String, dynamic> props) {
    try {
      print("Executing transformer script");
      print("Props passed to transformer: $props");

      final fullScript =
          '''
Map<String, dynamic> transform(Map<String, dynamic> props, String integrationId) {
$script
}

dynamic main(Map<String, dynamic> props, String integrationId) {
  return transform(props, integrationId);
}
''';

      final runtime = _createRuntime(fullScript);

      final result = runtime.executeLib('package:main/main.dart', 'main', [
        _wrapForEval(props),
        _wrapForEval(integrationId)
      ]);

      print("Transformer result: $result");
      print("Transformer result type: ${result.runtimeType}");

      Map<String, dynamic> resultMap;

      // Handle different return types from dart_eval
      if (result is $Value) {
        final unwrapped = result.$reified;
        print("Unwrapped value: $unwrapped (${unwrapped.runtimeType})");
        if (unwrapped is Map) {
          resultMap = Map<String, dynamic>.from(unwrapped);
        } else {
          print("Unexpected unwrapped type: ${unwrapped.runtimeType}");
          return;
        }
      } else if (result is Map) {
        resultMap = Map<String, dynamic>.from(result);
      } else {
        print("Unexpected result type: ${result.runtimeType}");
        return;
      }

      try {
        _orchestrator.sendMessage(
          resultMap["path"].toString(),
          resultMap["data"].toString(),
        );
      } catch (e) {
        print("Error sending message from transformer: $e");
      }
    } catch (e) {
      print('Error in executeTransformer: $e');
      rethrow;
    }
  }

  dynamic normalizeKeys(dynamic value) {
    if (value is Map) {
      return value.map((key, val) {
        final normalizedKey = _normalizeKey(key.toString());
        return MapEntry(normalizedKey, normalizeKeys(val));
      });
    } else if (value is List) {
      return value.map(normalizeKeys).toList();
    } else {
      return value;
    }
  }

  String _normalizeKey(String key) {
    // Remove leading slashes
    var k = key.replaceAll(RegExp(r'^/+'), '');

    // Replace invalid identifier characters with underscore
    k = k.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

    // Ensure it doesn’t start with a number
    if (RegExp(r'^[0-9]').hasMatch(k)) {
      k = '_$k';
    }

    return k;
  }
}
