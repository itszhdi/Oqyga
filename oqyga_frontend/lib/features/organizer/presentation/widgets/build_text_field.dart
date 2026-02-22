import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required OutlineInputBorder border,
  IconData? prefixIcon,
  int maxLines = 1, required TextInputType inputType,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.black)
          : null,
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
    ),
  );
}
