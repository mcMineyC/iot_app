import 'package:freezed_annotation/freezed_annotation.dart';

part 'orchestrator_integration_status.freezed.dart';
part 'orchestrator_integration_status.g.dart';

@freezed
abstract class IntegrationStatus with _$IntegrationStatus {
  const factory IntegrationStatus({
    required String id,
    required String name,
    required String status,
    required int error,
    required String errorDescription,
  }) = _IntegrationStatus;

  const IntegrationStatus._();

  factory IntegrationStatus.fromJson(Map<String, dynamic> json) =>
      _$IntegrationStatusFromJson(json);
}