import 'package:flutter/material.dart';

class UIViews {
  static OutlineInputBorder inputBorder({required double radius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(
        color: Colors.black,
        style: BorderStyle.solid,
        width: 2,
      ),
    );
  }
}
