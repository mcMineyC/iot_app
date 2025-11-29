// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integrationconfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntegrationConfig _$IntegrationConfigFromJson(Map<String, dynamic> json) =>
    _IntegrationConfig(
      id: json['id'] as String,
      name: json['name'] as String,
      integrationName: json['integrationName'] as String,
      config: json['config'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$IntegrationConfigToJson(_IntegrationConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'integrationName': instance.integrationName,
      'config': instance.config,
    };
