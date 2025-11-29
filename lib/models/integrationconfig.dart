
import 'package:freezed_annotation/freezed_annotation.dart';

part 'integrationconfig.freezed.dart';
part 'integrationconfig.g.dart';

@freezed
abstract class IntegrationConfig with _$IntegrationConfig {
  factory IntegrationConfig({
    required String id,
    required String name,
    required String integrationName,
    Map<String, dynamic>? config,
  }) = _IntegrationConfig;
	
  factory IntegrationConfig.fromJson(Map<String, dynamic> json) =>
			_$IntegrationConfigFromJson(json);
}
