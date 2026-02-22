import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/city.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/category.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/age_restriction.dart';

mixin FilterFormMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController priceFromController = TextEditingController();
  final TextEditingController priceToController = TextEditingController();

  DateTime? dateFrom;
  DateTime? dateTo;
  TimeOfDay? timeFrom;
  TimeOfDay? timeTo;

  City? selectedCity;
  AgeRestriction? selectedAge;
  Category? selectedCategory;

  @override
  void dispose() {
    priceFromController.dispose();
    priceToController.dispose();
    super.dispose();
  }

  void resetFormFields() {
    setState(() {
      priceFromController.clear();
      priceToController.clear();
      dateFrom = null;
      dateTo = null;
      timeFrom = null;
      timeTo = null;
      selectedCity = null;
      selectedAge = null;
      selectedCategory = null;
    });
  }

  Future<void> pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      locale: Localizations.localeOf(context),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: dateFrom != null && dateTo != null
          ? DateTimeRange(start: dateFrom!, end: dateTo!)
          : null,
    );
    if (picked != null) {
      setState(() {
        dateFrom = picked.start;
        dateTo = picked.end;
      });
    }
  }

  Future<void> pickTimeRange(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (timeFrom ?? TimeOfDay.now())
          : (timeTo ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          timeFrom = picked;
        } else {
          timeTo = picked;
        }
      });
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget buildDropdownField<ItemType>({
    required String label,
    required ItemType? value,
    required List<ItemType> items,
    required String Function(ItemType) titleBuilder,
    required Function(ItemType?) onChanged,
  }) {
    final validValue = value != null && items.contains(value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<ItemType>(
          value: validValue as ItemType?,
          isExpanded: true,
          items: items.map((item) {
            return DropdownMenuItem<ItemType>(
              value: item,
              child: Text(titleBuilder(item), overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOutlinedButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
    );
  }

  Widget buildFilterFormContent({
    required String title,
    required List<City> cities,
    required Widget specificFilters,
    required VoidCallback onApply,
    bool showPriceFilters = true,
    double actionButtonTopSpacing = 100,
  }) {
    final s = S.of(context); // ПОЛУЧАЕМ S
    final textStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontSize: 16);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              ShadowedBackButton(onPressed: () => context.pop()),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showPriceFilters) ...[
                    Text(s.priceLabel, style: textStyle),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField(
                            controller: priceFromController,
                            hint: s.priceFromHint,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildTextField(
                            controller: priceToController,
                            hint: s.priceToHint,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],

                  buildDropdownField<City>(
                    label: s.cityLabel,
                    value: selectedCity,
                    items: cities,
                    titleBuilder: (city) => city.cityName,
                    onChanged: (val) => setState(() => selectedCity = val),
                  ),

                  const SizedBox(height: 20),

                  // Date & Time
                  Text(s.timeLabel, style: textStyle),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: buildOutlinedButton(
                          text: dateFrom == null
                              ? s.dateRangeHint
                              : '${dateFrom!.day}.${dateFrom!.month} - ${dateTo!.day}.${dateTo!.month}',
                          onPressed: pickDateRange,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: buildOutlinedButton(
                          text: timeFrom == null
                              ? s.timeRangeHint
                              : '${timeFrom!.format(context)} - ${timeTo?.format(context) ?? ''}',
                          onPressed: () async {
                            await pickTimeRange(true);
                            if (timeFrom != null && mounted)
                              await pickTimeRange(false);
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  specificFilters,

                  SizedBox(height: actionButtonTopSpacing),
                  CustomButton(text: s.filterButtonText, onPressed: onApply),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
