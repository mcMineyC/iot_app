import '../views/integrationComponents/generics.dart';

String kVersionString = "0.0.5.0";
List<dynamic> kDashboardConfig = [
  IntegrationUiDefinition(
    label: "Bedside Bulb",
    integrationId: "bed-bulb",
    type: IntegrationUiType.button,
    evaluatorScript: '''
      var lightState = props['/lightState'];
      var value = lightState['on_off'] == 1;
      return {
        "text": value ? "Turn Off" : "Turn On",
        "icon": value ? "lightbulb" : "lightbulb_outlined",
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
    evaluatorScript: '''
      var lightState = props['/lightState'];
      var value = lightState['on_off'] == 1;
      return {
        "text": value ? "Turn Off" : "Turn On",
        "icon": value ? "lightbulb" : "lightbulb_outlined",
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
