import '../views/integrationComponents/generics.dart';

String kVersionString = "0.0.4.0";
List<IntegrationUiDefinition> kDashboardConfig = [
  IntegrationUiDefinition(
    label: "Bedside Bulb",
    integrationId: "bed-bulb",
    type: IntegrationUiType.button,
    dataPath: "/power/toggle"
  ),
  IntegrationUiDefinition(
    label: "Bed Temperature",
    integrationId: "bed-bulb",
    type: IntegrationUiType.slider,
    dataPath: "/light/temperature"
  ),
  IntegrationUiDefinition(
    label: "Broom Closet Ending",
    integrationId: "broom-closet-ending",
    type: IntegrationUiType.button,
    dataPath: "/power/toggle"
  )
];