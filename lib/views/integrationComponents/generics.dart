import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part 'generics.freezed.dart';
part 'generics.g.dart';

@freezed
abstract class IntegrationUiDefinition with _$IntegrationUiDefinition {
  const factory IntegrationUiDefinition({
    required String label,
    required String integrationId,
    required IntegrationUiType type,
    required String path,
    String? evaluatorScript,
    String? outputTransformer,

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