import '../views/integrationComponents/generics.dart';

String kVersionString = "0.0.4.0";
List<dynamic> kDashboardConfig = [
  IntegrationUiDefinition(
    label: "Bedside Bulb",
    integrationId: "bed-bulb",
    type: IntegrationUiType.button,
    evaluatorScript: '''
      var lightState = props['/lightState'];
      var value = lightState['on_off'] == 1;
      return {
        "value": value,
      };
    ''',
    outputTransformer: '''
      return {
        "path": "/\${integrationId}/power/toggle",
        "data": "true",
      };
    ''',
    // dataPath: "/power/toggle"
  ),
  [IntegrationUiDefinition(
    label: "Bed Temperature",
    integrationId: "bed-bulb",
    type: IntegrationUiType.slider,
    evaluatorScript: '''
      var lightState = props['/lightState'];
      var temperatureRange = props['/temperatureRange'];
      return {
        "value": lightState['color_temp'],
        "min": temperatureRange['min'],
        "max": temperatureRange['max'],
      };
    ''',
    outputTransformer: '''
      return {
        "path": "/\${integrationId}/light/temperature",
        "data": props["value"].toString(),
      };
    ''',
  ),
  IntegrationUiDefinition(
    label: "Bed Brightness",
    integrationId: "bed-bulb",
    type: IntegrationUiType.slider,
    evaluatorScript: '''
      var lightState = props['/lightState'];
      return {
        "value": lightState['brightness'],
        "min": 0,
        "max": 100,
      };
    ''',
    outputTransformer: '''
      return {
        "path": "/\${integrationId}/light/brightness",
        "data": props["value"].toString(),
      };
    ''',
    // dataPath: "/light/temperature"
  ),],
  IntegrationUiDefinition(
    label: "Broom Closet Ending",
    integrationId: "broom-closet-ending",
    type: IntegrationUiType.button,
    // dataPath: "/power/toggle"
    evaluatorScript: '''
      var lightState = props['/lightState'];
      var value = lightState['on_off'] == 1;
      return {
        "value": value,
      };
    ''',
    outputTransformer: '''
      return {
        "path": "/\${integrationId}/power/toggle",
        "data": "true",
      };
    ''',
  ),
];
