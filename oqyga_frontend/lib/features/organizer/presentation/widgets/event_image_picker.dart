import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class EventImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? existingImageUrl;
  final VoidCallback onTap;
  final bool isEditMode;

  const EventImagePicker({
    super.key,
    this.imageFile,
    this.existingImageUrl,
    required this.onTap,
    required this.isEditMode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 306,
              height: 367,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAEA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black, width: 1.2),
              ),
              child: _buildContent(context),
            ),
          ),
          if (imageFile != null || existingImageUrl != null)
            Positioned(
              bottom: 12,
              right: 12,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.2),
                  ),
                  child: const Icon(Icons.edit_outlined, size: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final s = S.of(context);
    if (imageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          imageFile!,
          fit: BoxFit.cover,
          width: 306,
          height: 367,
        ),
      );
    } else if (existingImageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          existingImageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error)),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 40, color: Colors.black54),
            const SizedBox(height: 8),
            Text(isEditMode ? s.changePoster : s.addPoster),
          ],
        ),
      );
    }
  }
}
