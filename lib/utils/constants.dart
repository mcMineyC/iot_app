import '../views/integrationComponents/generics.dart';

String kVersionString = "0.0.3.0";
List<IntegrationUiDefinition> kDashboardConfig = [
  IntegrationUiDefinition(
    label: "Bedside Bulb",
    integrationId: "bed-bulb",
    type: IntegrationUiType.button,
    path: "/power/toggle"
  ),
  IntegrationUiDefinition(
    label: "Bed Temperature",
    integrationId: "bed-bulb",
    type: IntegrationUiType.slider,
    path: "/light/temperature"
  ),
];