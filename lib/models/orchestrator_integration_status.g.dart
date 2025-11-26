// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orchestrator_integration_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntegrationStatus _$IntegrationStatusFromJson(Map<String, dynamic> json) =>
    _IntegrationStatus(
      id: json['id'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      error: (json['error'] as num).toInt(),
      errorDescription: json['errorDescription'] as String,
    );

Map<String, dynamic> _$IntegrationStatusToJson(_IntegrationStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'error': instance.error,
      'errorDescription': instance.errorDescription,
    };
