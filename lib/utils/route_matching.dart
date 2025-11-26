typedef RouteHandler = Function(Map<String, String> params, String message);
Map<String, RouteHandler> _routes = {};

void registerRoutes(Map<String, RouteHandler> routes) {
  _routes.addAll(routes);
}

dynamic matchRoute(String path, String message, {bool caseSensitive = false}) {
  var normalizedPath = path.replaceAll(RegExp(r'^/+|/+$'), '');
  var requestPath = '/' + normalizedPath;
  print(path);
  
  for (var entry in _routes.entries) {
    final pattern = entry.key;
    final handler = entry.value;
    
    final normalizedPattern = pattern.replaceAll(RegExp(r'^/+|/+$'), '');
    if (!caseSensitive && !pattern.contains(':') && normalizedPattern == normalizedPath) {
      return handler({}, message);
    }
    
    try {
      final patternParts = normalizedPattern.split('/');
      final regexPattern = patternParts.map((part) {
        if (part.startsWith(':')) {
          return '([^/]+)';
        }
        return RegExp.escape(part);
      }).join('/');
      
      final regex = RegExp('^/$regexPattern\$');
      final match = regex.firstMatch(requestPath);
      
      if (match == null) continue;
      
      final params = <String, String>{};
      for (var i = 0; i < patternParts.length; i++) {
        final part = patternParts[i];
        if (part.startsWith(':')) {
          params[part.substring(1)] = match.group(i + 1)!;
        }
      }
      
      return handler(params, message);
    } catch (_) {
      continue;
    }
  }
  
  throw Exception('Route not found');
}