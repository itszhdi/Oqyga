import 'package:flutter/material.dart';
import 'package:oqyga_frontend/features/filters/data/models/city_model.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class MapDialogs {
  static void showConfirmCityDialog({
    required BuildContext context,
    required CityModel city,
    required VoidCallback onConfirm,
    required VoidCallback onDecline,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          S.of(context).confirm_city_title(city.cityName),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(S.of(context).confirm_city_content),
        actions: [
          TextButton(onPressed: onDecline, child: Text(S.of(context).no)),
          TextButton(onPressed: onConfirm, child: Text(S.of(context).yes)),
        ],
      ),
    );
  }

  static void showCitySelectionDialog({
    required BuildContext context,
    required List<CityModel> cities,
    required Function(CityModel) onSelected,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        title: Text(
          S.of(context).select_city_title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 200,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: cities.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  title: Text(
                    city.cityName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 18),
                  onTap: () => onSelected(city),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
