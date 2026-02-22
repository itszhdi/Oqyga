import 'package:flutter/material.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? hintText;

  const SearchField({super.key, required this.onChanged, this.hintText});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText ?? s.search,
        hintStyle: const TextStyle(color: Colors.black26),
        prefixIcon: const Icon(Icons.search, color: Colors.black26),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
      ),
    );
  }
}
