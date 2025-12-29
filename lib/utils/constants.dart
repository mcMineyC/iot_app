import '../views/components/generics.dart';

String kVersionString = "0.0.7.8";
String kDashboardConfig = '''[
  [
    {
      "label": "Bedside Bulb",
      "integrationId": "bed-bulb",
      "type": "button",
      "evaluatorScript": "      var lightState = props['/lightState'];\n      var value = lightState['on_off'] == 1;\n      return {\n        \"text\": value ? \"Turn Off\" : \"Turn On\",\n        \"icon\": value ? \"lightbulb\" : \"lightbulb_outlined\",\n        \"value\": value,\n      };\n    ",
      "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/power/toggle\",\n        \"data\": \"true\",\n      };\n    "
    },
    {
      "label": "Desk Bulb",
      "integrationId": "desk-bulb",
      "type": "button",
      "evaluatorScript": "      var lightState = props['/lightState'];\n      var value = lightState['on_off'] == 1;\n      return {\n        \"text\": value ? \"Turn Off\" : \"Turn On\",\n        \"icon\": value ? \"lightbulb\" : \"lightbulb_outlined\",\n        \"value\": value,\n      };\n    ",
      "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/power/toggle\",\n        \"data\": \"true\",\n      };\n    "
    }
  ],
  [
    {
      "label": "Bed Temperature",
      "integrationId": "bed-bulb",
      "type": "slider",
      "evaluatorScript": "      var lightState = props['/lightState'];\n      var temperatureRange = props['/temperatureRange'];\n      return {\n        \"value\": lightState['color_temp'],\n        \"min\": temperatureRange['min'],\n        \"max\": temperatureRange['max'],\n      };\n    ",
      "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/light/temperature\",\n        \"data\": props[\"value\"].toString(),\n      };\n    "
    },
    {
      "label": "Bed Brightness",
      "integrationId": "bed-bulb",
      "type": "slider",
      "evaluatorScript": "      var lightState = props['/lightState'];\n      return {\n        \"value\": lightState['brightness'],\n        \"min\": 0,\n        \"max\": 100,\n      };\n    ",
      "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/light/brightness\",\n        \"data\": props[\"value\"].toString(),\n      };\n    "
    }
  ],
  [
    {
      "label": "Desk Temperature",
      "integrationId": "desk-bulb",
      "type": "slider",
      "evaluatorScript": "      var lightState = props['/lightState'];\n      var temperatureRange = props['/temperatureRange'];\n      return {\n        \"value\": lightState['color_temp'],\n        \"min\": temperatureRange['min'],\n        \"max\": temperatureRange['max'],\n      };\n    ",
      "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/light/temperature\",\n        \"data\": props[\"value\"].toString(),\n      };\n    "
    },
    {
      "label": "Desk Brightness",
      "integrationId": "desk-bulb",
      "type": "slider",
      "evaluatorScript": "      var lightState = props['/lightState'];\n      return {\n        \"value\": lightState['brightness'],\n        \"min\": 0,\n        \"max\": 100,\n      };\n    ",
      "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/light/brightness\",\n        \"data\": props[\"value\"].toString(),\n      };\n    "
    }
  ],
  {
    "label": "Closet Lights",
    "integrationId": "broom-closet-ending",
    "type": "button",
    "evaluatorScript": "      var lightState = props['/lightState'];\n      var value = lightState['on_off'] == 1;\n      return {\n        \"text\": value ? \"Turn Off\" : \"Turn On\",\n        \"icon\": value ? \"lightbulb\" : \"lightbulb_outlined\",\n        \"value\": value,\n      };\n    ",
    "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/power/toggle\",\n        \"data\": \"true\",\n      };\n    "
  },
  {
    "label": "Poweroff",
    "integrationId": "poweroffer",
    "type": "statelessButton",
    "evaluatorScript": "     return {\n        \"text\": \"Shutdown\",\n        \"icon\": \"power_settings_new_rounded\",\n      };\n    ",
    "outputTransformer": "      return {\n        \"path\": \"/\${integrationId}/poweroff\",\n        \"data\": \"true\",\n      };\n    "
  }
]''';