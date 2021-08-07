import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/colors.dart';

class TextFieldModified extends StatelessWidget {
  const TextFieldModified(
      {Key key,
      this.label,
      this.isEnabled,
      this.hint,
      this.icon,
      this.suffixIcon,
      this.controller,
      this.typeKeyboard,
      this.validatorFunc,
      this.isPasword,
      this.onFieldSubmitted,
      this.formatter})
      : super(key: key);

  final String label;
  final bool isEnabled;
  final String hint;
  final Widget icon;
  final Widget suffixIcon;
  final TextEditingController controller;
  final TextInputType typeKeyboard;
  final FormFieldValidator<String> validatorFunc;
  final bool isPasword;
  final ValueChanged<String> onFieldSubmitted;
  final List<TextInputFormatter> formatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ?? true,
      obscureText: isPasword ?? false,
      keyboardType: typeKeyboard,
      inputFormatters: formatter,
      controller: controller,
      validator: validatorFunc,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.grey)),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: AppColors.colorMap[800],
          ),
        ),
      ),
    );
  }
}
