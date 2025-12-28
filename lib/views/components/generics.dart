import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "button.dart";
import "media_player.dart";
import "slider.dart";
import "stateless_button.dart";

part 'generics.freezed.dart';
part 'generics.g.dart';

@freezed
abstract class IntegrationUiDefinition with _$IntegrationUiDefinition {
  const factory IntegrationUiDefinition({
    required String label,
    required String integrationId,
    required IntegrationUiType type,
    // required String dataPath,
    required String evaluatorScript,
    required String outputTransformer,

  }) = _IntegrationUiDefinition;
  factory IntegrationUiDefinition.fromJson(Map<String, dynamic> json) => _$IntegrationUiDefinitionFromJson(json);
}
enum IntegrationUiType{
  button,
  statelessButton,
  slider,
  mediaPlayer,
  // toggle,
  // textInput,
  // dropdown,
  // colorPicker,
  // custom
}

class SplitWidget extends StatelessWidget {
  final List<dynamic> definitions;
  SplitWidget({required this.definitions, super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: definitions.map((def) => UiDefinitionToWidget(def)).toList(),
      ),
    );
  }
}

class GenericIntegrationComponent extends StatelessWidget {
  final String title;
  final Widget child;
  final bool online;
  final EdgeInsetsGeometry? padding;

  GenericIntegrationComponent({required this.title, required this.child, required this.online, this.padding, super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;

    return Card(
      elevation: 8,
      child: Stack(
        children: [
          if (!online) Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: padding ?? const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    online ? Icons.wifi : Icons.wifi_off_rounded,
                    color: colors.error,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Integration offline",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: colors.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (padding != EdgeInsets.all(0)) Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimaryContainer,
                  ),
                ),
                SizedBox(height: 8),
                child,
              ],
            ),
          ),
          if (padding == EdgeInsets.all(0)) child,
        ],
      ),
    );
  }
}

Widget UiDefinitionToWidget(dynamic definition) {
  if (definition is IntegrationUiDefinition) {
    switch (definition.type) {
      case IntegrationUiType.button:
        return IntegrationButton(
          label: definition.label,
            integrationId: definition.integrationId,
            evaluatorScript: definition.evaluatorScript,
            outputTransformer: definition.outputTransformer,
          );
      case IntegrationUiType.statelessButton:
        return IntegrationStatelessButton(
          label: definition.label,
            integrationId: definition.integrationId,
            evaluatorScript: definition.evaluatorScript,
            outputTransformer: definition.outputTransformer,
          );
        case IntegrationUiType.slider:
          return IntegrationSlider(
            label: definition.label,
            integrationId: definition.integrationId,
            evaluatorScript: definition.evaluatorScript,
            outputTransformer: definition.outputTransformer,
          );
        case IntegrationUiType.mediaPlayer:
          return IntegrationMediaPlayer(
            label: definition.label,
            integrationId: definition.integrationId
          );
        default:
          print("Unsupported IntegrationUiType: ${definition.type}");
          return SizedBox.shrink(); // Placeholder for unsupported types
    }
  }else if (definition is List) {
    return SplitWidget(definitions: definition); // It's a list instead of a single definition
  } else {
    print("Unknown definition type: ${definition.runtimeType}");
    print(definition);
    return SizedBox.shrink(); // Placeholder for unsupported types
  }
}