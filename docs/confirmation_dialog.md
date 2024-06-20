# ConfirmationDialog

A dialog widget for displaying a confirmation message with action buttons.

## Properties

- **title** (`String`): The title of the confirmation dialog.
- **content** (`String`): The content message of the confirmation dialog.
- **onConfirm** (`VoidCallback`): Callback function invoked when the user confirms the action.
- **onCancel** (`VoidCallback?`): Optional callback function invoked when the user cancels the action.

## Example

Here's an example of how to use the `ConfirmationDialog` widget in a Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:truesight_flutter/widgets/confirmation_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ConfirmationDialog Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmationDialog(
                    title: 'Confirmation',
                    content: 'Are you sure you want to delete this item?',
                    onConfirm: () {
                      // Handle confirm action
                      print('Confirmed');
                    },
                    onCancel: () {
                      // Handle cancel action
                      print('Cancelled');
                    },
                  );
                },
              );
            },
            child: Text('Show Confirmation Dialog'),
          ),
        ),
      ),
    );
  }
}
```

In this example, `ConfirmationDialog` is used to display a confirmation message with 'Xác nhận' (Confirm) and 'Không' (Cancel) buttons. The dialog uses `AlertDialog` and `CarbonButton` from the `truesight_flutter/widgets` package.

## Additional Information

This widget is part of the `truesight_flutter` library and provides a reusable confirmation dialog for user interactions.
