
import 'package:flutter/material.dart';

class TextFormFieldStyle {
  static InputDecoration textFieldStyle({String labelTextStr = "", String hintTextStr = "", String? errorTextStr}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      errorText: errorTextStr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}