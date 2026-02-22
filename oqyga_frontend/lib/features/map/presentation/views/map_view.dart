import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:oqyga_frontend/features/events/data/models/event_model.dart';
import 'package:oqyga_frontend/features/filters/data/models/city_model.dart';
import 'package:oqyga_frontend/features/map/presentation/bloc/map_bloc.dart';
import 'package:oqyga_frontend/features/map/presentation/widgets/map_dialogs.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();

  void _showCitySelectionDialog(BuildContext context, List<CityModel> cities) {
    MapDialogs.showCitySelectionDialog(
      context: context,
      cities: cities,
      onSelected: (city) {
        context.pop();
        final currentLang = Intl.getCurrentLocale().substring(0, 2);
        context.read<MapBloc>().add(
          MapCitySelectedEvent(city: city, languageCode: currentLang),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listenWhen: (previous, current) =>
          current.status == MapStatus.showCityDialog ||
          current.status == MapStatus.showConfirmDialog ||
          current.status == MapStatus.success,
      listener: (context, state) {
        if (state.status == MapStatus.showCityDialog) {
          _showCitySelectionDialog(context, state.cities);
        } else if (state.status == MapStatus.showConfirmDialog &&
            state.detectedCity != null) {
          MapDialogs.showConfirmCityDialog(
            context: context,
            city: state.detectedCity!,
            onConfirm: () {
              context.pop();
              final currentLang = Intl.getCurrentLocale().substring(0, 2);
              context.read<MapBloc>().add(
                MapCitySelectedEvent(
                  city: state.detectedCity!,
                  languageCode: currentLang,
                ),
              );
            },
            onDecline: () {
              // Если отказались, открываем ручной выбор
              _showCitySelectionDialog(context, state.cities);
            },
          );
        } else if (state.status == MapStatus.success) {
          // При успешной загрузке двигаем камеру к первому маркеру
          if (state.mapItems.isNotEmpty) {
            _mapController.move(state.mapItems.first.coordinates, 12.0);
          }
        }
      },
      builder: (context, state) {
        final isLoading =
            state.status == MapStatus.loading ||
            state.status == MapStatus.initial;

        return Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: const MapOptions(
                  initialCenter: LatLng(48.0196, 66.9237),
                  initialZoom: 5.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.oqyga.app',
                  ),
                  MarkerLayer(
                    markers: state.mapItems.map((item) {
                      return Marker(
                        point: item.coordinates,
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                          onTap: () => _showEventInfo(context, item.event),
                          child: Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // Виджет выбора города
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                right: 20,
                child: InkWell(
                  onTap: () => _showCitySelectionDialog(context, state.cities),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          state.selectedCity?.cityName ?? S.of(context).loading,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black12,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showEventInfo(BuildContext context, EventModel event) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              event.title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(event.address, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 30),
            CustomButton(
              text: S.of(context).go_to_event,
              onPressed: () {
                context.pop();
                context.pushNamed(
                  'event-detail',
                  pathParameters: {'id': event.id.toString()},
                );
              },
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
