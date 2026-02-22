import 'package:flutter/material.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class DeleteCardConfirmationDialog extends StatelessWidget {
  const DeleteCardConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final Color textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40.0),
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(
              top: 45,
              bottom: 25,
              left: 25,
              right: 25,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Удалить эту карту?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textColor,
                          side: BorderSide(color: textColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          s.noButton,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Удалить", // Можно заменить на s.deleteButton
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Icon(Icons.close, color: textColor, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const DeleteCardConfirmationDialog(),
    );
  }
}
