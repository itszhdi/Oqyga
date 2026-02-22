import 'package:flutter/material.dart';
import 'package:oqyga_frontend/features/organizer/presentation/widgets/build_text_field.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class TicketTypeControllers {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }
}

class TicketTypeRow extends StatelessWidget {
  final TicketTypeControllers controllers;
  final int index;
  final bool showDeleteButton;
  final VoidCallback onRemove;
  final OutlineInputBorder border;

  const TicketTypeRow({
    super.key,
    required this.controllers,
    required this.index,
    required this.showDeleteButton,
    required this.onRemove,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  controller: controllers.nameController,
                  hintText: s.ticketNameHint,
                  border: border,
                  inputType: TextInputType.text,
                ),
              ),
              if (showDeleteButton) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: s.deleteCategoryTooltip,
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  controller: controllers.priceController,
                  hintText: s.priceHint,
                  border: border,
                  inputType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildTextField(
                  controller: controllers.quantityController,
                  hintText: s.seatsAmountHint,
                  border: border,
                  inputType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
