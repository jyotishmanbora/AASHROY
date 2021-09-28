import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(String label, String? helperText) {
  return InputDecoration(
    label: Text(label),
    floatingLabelStyle: const TextStyle(color: Color(0xff637CFF)),
    helperText: helperText,
    fillColor: const Color.fromRGBO(99, 124, 255, 0.2),
    filled: true,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff637CFF),
        width: 3.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff637CFF),
        width: 3.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
  );
}

InputDecoration postScreenTextFieldDecoration(String label) {
  return InputDecoration(
    label: Text(label),
    floatingLabelStyle: const TextStyle(color: Color(0xff637CFF)),
    fillColor: const Color.fromRGBO(99, 124, 255, 0.2),
    filled: true,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    contentPadding: const EdgeInsets.all(20.0),
  );
}
