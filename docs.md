# Shared Preferences
- cachedConnectionString: string

# Dashboard Definition Structure

Standard linear list:
```
[
  IntegrationUiDefinition,
  IntegrationUiDefinition
]
```

Split Widgets:
```
[
  // For a two-way split
  [
    IntegrationUiDefinition,
    IntegrationUiDefinition,
  ],

  // But it can go as many as can fit onscreen
  [
    IntegrationUiDefinition,
    IntegrationUiDefinition,
    IntegrationUiDefinition,
    IntegrationUiDefinition,
  ]

  // Normal widgets can follow also
  IntegrationUiDefinition,
  IntegrationUiDefinition
]
```

## IntegrationUiDefinition class
Holds the state that is dynamically transformed into widgets

Properties:
- label: String
> Title at top left of card
- integrationId: String
> Dictates which integration this component should listen to updates from
- type: IntegrationUiType
> One of button, slider
> Determines type of component on the dashboard
- evaluatorScript: String
> DartScript (see below) to evaluate the integration state into component state
- outputTransformer: String
> DartScript (see below) to transform the component state into an MQTT message

# Writing DartScript
It's literally just Dart code.  The Wrapper wraps it with a basic function that provides integrationId and a props object

## Evaluators
Accepts the entire state of the integration, as deserialized as possible.
Stores the config for the components.
For example, button evaluators should have a "text" and "icon" entry; sliders ==**MUST**== have "min", "max", and "value" entries.

Valid variables: 
- integrationId: $String
- props: $Map\<String, dynamic>

Example:
```
var lightState = props['/lightState'];
var temperatureRange = props['/temperatureRange'];
return {
  "value": lightState['color_temp'],
  "min": temperatureRange['min'],
  "max": temperatureRange['max'],
};
```

## Transformers
Turns the component state into whatever the integration expects, also dictating the path
Props are defined in the component at will

Valid variables:
- integrationId: $String
- props: $Map\<String, dynamic>

Example:
```
return {
  "path": "/\${integrationId}/light/temperature",
  "data": props["value"].toString(),
};
```