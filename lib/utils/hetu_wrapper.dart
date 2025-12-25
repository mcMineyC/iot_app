import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import 'package:iot_app/controllers/orchestrator.dart';

class HetuWrapper {
  final Hetu _hetu = Hetu();
  final Map<int, String> _modules = {};
  final OrchestratorController _orchestrator = Get.find<OrchestratorController>();
  String prependScript = "";
  Future<void> initialize() async {
    // Any initialization code if needed
    var externalFunction = {
      'map': (HTEntity entity, List<dynamic> positionalArgs, Map<String, dynamic> namedArgs) {
        return ((namedArgs["value"] - namedArgs["inMin"]) * (namedArgs["outMax"] - namedArgs["outMin"])) / (namedArgs["inMax"] - namedArgs["inMin"]) + namedArgs["outMin"];
      },
      'lerp': (HTEntity entity, List<dynamic> positionalArgs, Map<String, dynamic> namedArgs) {
        return lerpDouble(namedArgs["a"], namedArgs["b"], namedArgs["value"]);
      },
      'getIntegrationData': (HTEntity entity, List<dynamic> positionalArgs, Map<String, dynamic> namedArgs) {
        // This function can be implemented to fetch integration data
        var integrationId = namedArgs["integrationId"];
        var dataPath = namedArgs["path"];
        if(!_orchestrator.orchestratorState.containsKey(integrationId))
          return null;
        if(!_orchestrator.orchestratorState[integrationId]!.containsKey(dataPath))
          return null;
        
        try{
          return jsonDecode(_orchestrator.orchestratorState[integrationId]![dataPath]);
        }catch(e){
          return _orchestrator.orchestratorState[integrationId]![dataPath];
        }
      },
    };

    externalFunction.keys.forEach((key) {
      // prependScript += '''external fun $key;\n''';
    });

    return _hetu.init(
      // externalFunctions: externalFunction,
    );
  }
  Map<String, dynamic> executeEvaluator(
    String script,
    Map<String, dynamic> props,
  ) {
    final hash = script.hashCode;
    print("Executing evaluator script:\n${prependScript + script}");

    if (!_modules.containsKey(hash)) {
      final module = 'evaluator_$hash';
      _hetu.eval(prependScript + script, moduleName: module);
      print("Registered evaluator module: $module");
      _modules[hash] = module;
    }
    print("Props passed to evaluator: $props");
    var result = _hetu.invoke(
      'evaluate',
      moduleName: _modules["evaluator_$hash"],
      positionalArgs: [props],
    );
    if (result is HTStruct) {
      result = result.toJson();
    }
    print("Evaluator result: $result");

    return Map<String, dynamic>.from(result);
  }


  void executeTransformer(
    String script,
    Map<String, dynamic> props,
  ) {
    final hash = script.hashCode;
    print("Executing evaluator script:\n${prependScript + script}");

    if (!_modules.containsKey(hash)) {
      final module = 'transformer_$hash';
      _hetu.eval(prependScript + script, moduleName: module);
      print("Registered evaluator module: $module");
      _modules[hash] = module;
    }
    print("Props passed to evaluator: $props");
    var result = _hetu.invoke(
      'transform',
      moduleName: _modules["transformer_$hash"],
      positionalArgs: [props],
    );
    if (result is HTStruct) {
      result = result.toJson();
    }
    print("Evaluator result: $result");

    // return Map<String, dynamic>.from(result);
  }
}