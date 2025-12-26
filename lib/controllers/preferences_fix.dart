String serializeDashboardConfig(List<dynamic> config) {
  List<dynamic> fig = List.filled(config.length, null);
  for (var x = 0; x < config.length; x++) {
    var item = config[x];
    if (item is IntegrationUiDefinition) {
      var uiDef = item.toJson();
      fig[x] = uiDef;
    } else if (item is List) {
      // Recursively serialize nested lists - don't double-encode
      fig[x] = jsonDecode(serializeDashboardConfig(item));
    } else {
      print("Unknown dashboard config item type: ${item.runtimeType}");
      fig[x] = item;
    }
  }
  return jsonEncode(fig);
}

List<dynamic> deserializeDashboardConfig(String jsonString) {
  List<dynamic> raw = jsonDecode(jsonString);
  List<dynamic> fig = List.filled(raw.length, null);
  for (var x = 0; x < raw.length; x++) {
    var item = raw[x];
    if (item is Map<String, dynamic> && 
        item.containsKey("type") && 
        item.containsKey("label") && 
        item.containsKey("integrationId") && 
        item.containsKey("evaluatorScript") && 
        item.containsKey("outputTransformer")) {
      fig[x] = IntegrationUiDefinition.fromJson(item);
    } else if (item is List) {
      // Recursively deserialize nested lists - item is already a List, not a string
      fig[x] = deserializeDashboardConfig(jsonEncode(item));
    } else if (item is String) {
      // Handle incorrectly double-encoded strings from old data
      try {
        fig[x] = deserializeDashboardConfig(item);
      } catch (e) {
        print("Could not deserialize string item: $e");
        fig[x] = item;
      }
    } else {
      print("Unknown dashboard config item type during deserialization: ${item.runtimeType}");
      fig[x] = item;
    }
  }
  return fig;
}
