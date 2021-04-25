import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_antrean_babatan/utils/color.dart';

TextFormField textFieldModified(
    {String label,
      bool isEnabled = true,
      String hint,
      Icon icon,
      TextEditingController controller,
      TextInputType typeKeyboard,
      FormFieldValidator<String> validatorFunc,
      bool isPasword = false,
      List<TextInputFormatter> formatter}) {
  return TextFormField(
      enabled: isEnabled,
      obscureText: isPasword,
      keyboardType: typeKeyboard,
      inputFormatters: formatter,
      controller: controller,
      validator: validatorFunc,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey)),
          labelStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: ColorTheme.greenDark))));
}