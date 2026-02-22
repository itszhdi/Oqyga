import 'package:flutter/material.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String itemName;
  final String? title;

  const DeleteConfirmationDialog({
    super.key,
    required this.itemName,
    this.title,
  });

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
                    s.deleteEventConfirmation(itemName),
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
                        onPressed: () => Navigator.of(context).pop(true),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          s.deleteButton,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: textColor,
                          side: BorderSide(color: textColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          s.cancelButton,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
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

  static Future<bool?> show(
    BuildContext context, {
    required String itemName,
    String title = 'Подтверждение удаления',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) =>
          DeleteConfirmationDialog(itemName: itemName, title: title),
    );
  }
}
