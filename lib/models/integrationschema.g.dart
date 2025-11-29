// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integrationschema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntegrationSchema _$IntegrationSchemaFromJson(Map<String, dynamic> json) =>
    _IntegrationSchema(
      path: json['path'] as String,
      type: json['type'] as String,
      fetchable: json['fetchable'] as bool,
    );

Map<String, dynamic> _$IntegrationSchemaToJson(_IntegrationSchema instance) =>
    <String, dynamic>{
      'path': instance.path,
      'type': instance.type,
      'fetchable': instance.fetchable,
    };
