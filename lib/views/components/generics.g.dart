// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntegrationUiDefinition _$IntegrationUiDefinitionFromJson(
  Map<String, dynamic> json,
) => _IntegrationUiDefinition(
  label: json['label'] as String,
  integrationId: json['integrationId'] as String,
  type: $enumDecode(_$IntegrationUiTypeEnumMap, json['type']),
  evaluatorScript: json['evaluatorScript'] as String,
  outputTransformer: json['outputTransformer'] as String,
);

Map<String, dynamic> _$IntegrationUiDefinitionToJson(
  _IntegrationUiDefinition instance,
) => <String, dynamic>{
  'label': instance.label,
  'integrationId': instance.integrationId,
  'type': _$IntegrationUiTypeEnumMap[instance.type]!,
  'evaluatorScript': instance.evaluatorScript,
  'outputTransformer': instance.outputTransformer,
};

const _$IntegrationUiTypeEnumMap = {
  IntegrationUiType.button: 'button',
  IntegrationUiType.statelessButton: 'statelessButton',
  IntegrationUiType.slider: 'slider',
  IntegrationUiType.toggle: 'toggle',
};
