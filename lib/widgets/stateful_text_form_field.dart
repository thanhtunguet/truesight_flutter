import 'package:flutter/material.dart';
import 'package:truesight_flutter/json/json.dart';

typedef ValidatorFunction = String? Function(String? value);

class StatefulTextFormField extends StatelessWidget {
  final JsonField field;

  final TextEditingController controller;

  final String label;

  final String? placeholder;

  final bool obscureText;

  final ValidatorFunction? validator;

  final Widget? suffixIcon;

  const StatefulTextFormField({
    super.key,
    required this.field,
    required this.controller,
    required this.label,
    this.placeholder,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
  });

  String getHelperText(BuildContext context) {
    if (field.error?.isNotEmpty == true) {
      return field.error!;
    }
    if (field.warning?.isNotEmpty == true) {
      return field.warning!;
    }
    if (field.information?.isNotEmpty == true) {
      return field.information!;
    }
    return "";
  }

  TextStyle getHelperTextStyle(BuildContext context) {
    if (field.error?.isNotEmpty == true) {
      return TextStyle(
        color: Theme.of(context).colorScheme.error,
      );
    }
    if (field.warning?.isNotEmpty == true) {
      return TextStyle(
        color: Theme.of(context).colorScheme.surface,
      );
    }
    if (field.information?.isNotEmpty == true) {
      return TextStyle(
        color: Theme.of(context).primaryColor,
      );
    }
    return const TextStyle();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onChanged: (String value) {
        field.error = null;
        field.warning = null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        helperText: getHelperText(context),
        helperStyle: getHelperTextStyle(context),
        hintText: placeholder,
        errorText: field.error,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
