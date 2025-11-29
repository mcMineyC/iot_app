
import 'package:freezed_annotation/freezed_annotation.dart';

part 'integrationschema.freezed.dart';
part 'integrationschema.g.dart';

@freezed
abstract class IntegrationSchema with _$IntegrationSchema {
  factory IntegrationSchema({
    required String path,
    required String type,
    required bool fetchable,
  }) = _IntegrationSchema;
	
  factory IntegrationSchema.fromJson(Map<String, dynamic> json) =>
			_$IntegrationSchemaFromJson(json);
}
