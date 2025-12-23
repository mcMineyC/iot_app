import '../views/integrationComponents/generics.dart';

String kVersionString = "0.0.3.0";
List<IntegrationUiDefinition> kDashboardConfig = [
  IntegrationUiDefinition(
    label: "Bedside Bulb",
    integrationId: "desk-bulb",
    type: IntegrationUiType.button,
    path: "/power/toggle"
  ),
  IntegrationUiDefinition(
    label: "Bed Temperature",
    integrationId: "desk-bulb",
    type: IntegrationUiType.slider,
    path: "/light/temperature"
  ),
  IntegrationUiDefinition(
    label: "Broom Closet Ending",
    integrationId: "broom-closet-ending",
    type: IntegrationUiType.button,
    path: "/power/toggle"
  )
];