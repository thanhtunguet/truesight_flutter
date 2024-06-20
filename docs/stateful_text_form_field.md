# StatefulTextFormField

A custom text form field widget for managing form input states with JSON field integration.

## Properties

- **field** (`JsonField`): The field that manages the state of the form input.
- **controller** (`TextEditingController`): The controller for the text form field.
- **label** (`String`): The label text for the text form field.
- **placeholder** (`String?`): The placeholder text for the text form field. Default is `null`.
- **obscureText** (`bool`): Whether the text form field should obscure the text (e.g., for passwords). Default is `false`.
- **validator** (`ValidatorFunction?`): A function for validating the input value. Default is `null`.
- **suffixIcon** (`Widget?`): An optional widget to display as a suffix icon. Default is `null`.

## Methods

### `getHelperText`

Returns the appropriate helper text based on the state of the `JsonField`.

- **Parameters**:
  - `context` (`BuildContext`): The build context.
- **Returns**: `String` - The helper text.

### `getHelperTextStyle`

Returns the appropriate text style for the helper text based on the state of the `JsonField`.

- **Parameters**:
  - `context` (`BuildContext`): The build context.
- **Returns**: `TextStyle` - The text style for the helper text.

## Example

Here's an example of how to use the `StatefulTextFormField` widget in a Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:truesight_flutter/json/json.dart';
import 'package:truesight_flutter/widgets/stateful_text_form_field.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('StatefulTextFormField Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ExampleForm(),
        ),
      ),
    );
  }
}

class ExampleForm extends StatefulWidget {
  @override
  _ExampleFormState createState() => _ExampleFormState();
}

class _ExampleFormState extends State<ExampleForm> {
  final TextEditingController _controller = TextEditingController();
  final JsonString _jsonField = JsonString('exampleField');

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          StatefulTextFormField(
            field: _jsonField,
            controller: _controller,
            label: 'Example Field',
            placeholder: 'Enter something...',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_jsonField.value != _controller.text) {
                setState(() {
                  _jsonField.value = _controller.text;
                });
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

In this example, `StatefulTextFormField` is used within a form. The `JsonString` class from the `truesight_flutter/json` package is used to manage the state of the input field. The helper text and style are dynamically updated based on the `JsonField` state.

## Additional Information

This widget is part of the `truesight_flutter` library, designed to help manage form input states seamlessly with JSON field integration.
