import 'package:flutter/material.dart';
import 'dart:io';
import 'package:oqyga_frontend/core/constants/app_constants.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class UserAvatar extends StatelessWidget {
  final String? photoUrl;
  final File? localFile;
  final double size;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;

  static const String baseUrl = API;

  const UserAvatar({
    super.key,
    this.photoUrl,
    this.localFile,
    this.size = 100,
    this.showBorder = false,
    this.borderColor = Colors.black,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
        border: showBorder
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: ClipOval(child: _buildImage()),
    );
  }

  Widget _buildImage() {
    if (localFile != null) {
      return Image.file(
        localFile!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _defaultAvatar(),
      );
    }

    if (photoUrl != null && photoUrl!.isNotEmpty) {
      String fullUrl = photoUrl!;

      if (!fullUrl.startsWith('http')) {
        if (fullUrl.startsWith('/') && baseUrl.endsWith('/')) {
          fullUrl = "$baseUrl${fullUrl.substring(1)}";
        } else if (!fullUrl.startsWith('/') && !baseUrl.endsWith('/')) {
          fullUrl = "$baseUrl/$fullUrl";
        } else {
          fullUrl = "$baseUrl$fullUrl";
        }
      }

      return Image.network(
        fullUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _defaultAvatar();
        },
      );
    }

    // 3. Дефолтный аватар
    return _defaultAvatar();
  }

  Widget _defaultAvatar() {
    return Image.asset(
      'assets/static/noAvatar.jpg',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: Icon(Icons.person, size: size * 0.5, color: Colors.grey[600]),
        );
      },
    );
  }
}

class EditableUserAvatar extends StatelessWidget {
  final String? currentPhotoUrl;
  final File? newPhotoFile;
  final VoidCallback onAddPhoto;
  final bool isEnabled;
  final double avatarSize;

  const EditableUserAvatar({
    super.key,
    this.currentPhotoUrl,
    this.newPhotoFile,
    required this.onAddPhoto,
    this.isEnabled = true,
    this.avatarSize = 90,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Текущий/новый аватар
            UserAvatar(
              photoUrl: currentPhotoUrl,
              localFile: newPhotoFile,
              size: avatarSize,
              showBorder: true,
            ),
            const SizedBox(width: 16),

            // Кнопка добавления фото
            GestureDetector(
              onTap: isEnabled ? onAddPhoto : null,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isEnabled ? Colors.black : Colors.grey,
                ),
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: avatarSize * 0.35,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          s.changePhotoLabel,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
