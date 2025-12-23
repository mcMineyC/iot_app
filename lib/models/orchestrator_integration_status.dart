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

enum IntegrationStatusEnum {
  running,
  starting,
  stopped,
}

extension IntegrationStatusEnumX on IntegrationStatusEnum {
  static IntegrationStatusEnum fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'running':
        return IntegrationStatusEnum.running;
      case 'starting':
        return IntegrationStatusEnum.starting;
      case 'stopped':
        return IntegrationStatusEnum.stopped;
      default:
        throw ArgumentError('Unknown IntegrationStatusEnum: $value');
    }
  }

  String toShortString() => toString().split('.').last;
}