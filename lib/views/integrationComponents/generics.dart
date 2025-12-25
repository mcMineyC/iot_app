import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../components/button.dart";
import "../components/slider.dart";

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
  slider,
  toggle,
  // textInput,
  // dropdown,
  // colorPicker,
  // custom
}

class SplitWidget extends StatelessWidget {
  final List<IntegrationUiDefinition> definitions;
  SplitWidget({required this.definitions, super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: definitions.map((def) => UiDefinitionToWidget(def)).toList(),
    );
  }
}

class GenericIntegrationComponent extends StatelessWidget {
  final String title;
  final Widget child;
  final bool online;

  GenericIntegrationComponent({required this.title, required this.child, required this.online, super.key});

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
              padding: const EdgeInsets.all(8.0),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
        case IntegrationUiType.slider:
          return IntegrationSlider(
            label: definition.label,
            integrationId: definition.integrationId,
            evaluatorScript: definition.evaluatorScript,
            outputTransformer: definition.outputTransformer,
          );
        default:
          return SizedBox.shrink(); // Placeholder for unsupported types
    }
  }else if (definition is List<IntegrationUiDefinition>) {
    return SplitWidget(definitions: definition); // It's a list instead of a single definition
  } else {
    return SizedBox.shrink(); // Placeholder for unsupported types
  }
}