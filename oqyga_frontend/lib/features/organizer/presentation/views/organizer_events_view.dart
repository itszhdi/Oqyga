import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart';
import 'package:oqyga_frontend/features/organizer/presentation/widgets/event_card.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/organizer_filters.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/organizer_events/organizer_events_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/widgets/delete_event.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/search_field.dart';

class OrganizerEventsView extends StatefulWidget {
  const OrganizerEventsView({super.key});

  @override
  State<OrganizerEventsView> createState() => _OrganizerEventsViewState();
}

class _OrganizerEventsViewState extends State<OrganizerEventsView> {
  String _searchQuery = '';
  OrganizerFilters? _currentFilters;

  bool get _hasFilters => _currentFilters != null && !_currentFilters!.isEmpty;

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query);
  }

  Future<void> _openFilters(BuildContext context) async {
    final result = await context.push<OrganizerFilters>(
      Routes.organizerFilterPage,
      extra: _currentFilters,
    );
    if (result != null && mounted) {
      setState(() {
        _currentFilters = result.isEmpty ? null : result;
      });
    }
  }

  void _clearFilters() {
    setState(() => _currentFilters = null);
  }

  Future<void> editEvent(BuildContext context, Event event) async {
    await context.push(
      '${Routes.organisatorEvents}/${Routes.editEvent}',
      extra: event,
    );

    if (mounted) {
      context.read<OrganizerEventsBloc>().add(FetchOrganizerEvents());
    }
  }

  Future<void> deleteEvent(BuildContext context, Event eventToDelete) async {
    final bool? shouldDelete = await DeleteConfirmationDialog.show(
      context,
      itemName: eventToDelete.title,
      title: S.of(context).deleteConfirmationTitle,
    );

    if (shouldDelete == true && context.mounted) {
      context.read<OrganizerEventsBloc>().add(
        DeleteOrganizerEvent(eventToDelete.id),
      );
    }
  }

  List<Event> _applySearchAndFilters(List<Event> events) {
    final query = _searchQuery.toLowerCase();
    return events.where((event) {
      final matchesSearch =
          event.title.toLowerCase().contains(query) ||
          event.city.toLowerCase().contains(query);
      final matchesFilters = _matchesFilters(event);
      return matchesSearch && matchesFilters;
    }).toList();
  }

  bool _matchesFilters(Event event) {
    final filters = _currentFilters;
    if (filters == null || filters.isEmpty) return true;

    if (filters.cityId != null && filters.cityId != event.cityId) {
      return false;
    }
    if (filters.categoryId != null && filters.categoryId != event.categoryId) {
      return false;
    }
    if (filters.ageRatingId != null &&
        filters.ageRatingId != event.ageRatingId) {
      return false;
    }
    if (filters.venueAddress != null) {
      if (!event.address.toLowerCase().contains(
        filters.venueAddress!.toLowerCase(),
      )) {
        return false;
      }
    }
    final eventDate = DateTime.tryParse(event.date);
    if (filters.dateFrom != null &&
        (eventDate == null || eventDate.isBefore(filters.dateFrom!))) {
      return false;
    }
    if (filters.dateTo != null &&
        (eventDate == null || eventDate.isAfter(filters.dateTo!))) {
      return false;
    }

    final eventTime = _parseTime(event.time);
    if (filters.timeFrom != null &&
        (eventTime == null ||
            !_isTimeAfterOrEqual(eventTime, filters.timeFrom!))) {
      return false;
    }
    if (filters.timeTo != null &&
        (eventTime == null ||
            !_isTimeBeforeOrEqual(eventTime, filters.timeTo!))) {
      return false;
    }

    return true;
  }

  TimeOfDay? _parseTime(String value) {
    final parts = value.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool _isTimeAfterOrEqual(TimeOfDay a, TimeOfDay b) {
    return a.hour > b.hour || (a.hour == b.hour && a.minute >= b.minute);
  }

  bool _isTimeBeforeOrEqual(TimeOfDay a, TimeOfDay b) {
    return a.hour < b.hour || (a.hour == b.hour && a.minute <= b.minute);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  s.myEventsTitle,
                  style: GoogleFonts.jura(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: SearchField(onChanged: _onSearchChanged)),
                  const SizedBox(width: 10),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => _openFilters(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.tune,
                            size: 24,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ),
                      if (_hasFilters)
                        const Positioned(
                          right: 6,
                          top: 6,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: Colors.red,
                          ),
                        ),
                    ],
                  ),
                  if (_hasFilters)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: _clearFilters,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.clear,
                            size: 24,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocConsumer<OrganizerEventsBloc, OrganizerEventsState>(
                  listener: (context, state) {
                    if (state.status == OrganizerEventsStatus.failure &&
                        state.message.isNotEmpty) {
                      final message = translateErrorMessage(
                        context,
                        state.message,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    Widget content;
                    if (state.status == OrganizerEventsStatus.loading ||
                        state.status == OrganizerEventsStatus.initial) {
                      content = const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == OrganizerEventsStatus.failure &&
                        state.events.isEmpty) {
                      content = Center(
                        child: Text(
                          s.errorLoadingEvents,
                          style: GoogleFonts.jura(color: Colors.red),
                        ),
                      );
                    } else {
                      final displayedEvents = _applySearchAndFilters(
                        state.events,
                      );
                      if (displayedEvents.isEmpty) {
                        content = Center(
                          child: Text(
                            _hasFilters || _searchQuery.isNotEmpty
                                ? s.noEventsFound
                                : s.noCreatedEvents,
                            style: GoogleFonts.jura(fontSize: 16),
                          ),
                        );
                      } else {
                        content = RefreshIndicator(
                          onRefresh: () async {
                            context.read<OrganizerEventsBloc>().add(
                              FetchOrganizerEvents(),
                            );
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: displayedEvents.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final event = displayedEvents[index];
                              return EventCard(
                                event: event,
                                onEdit: () => editEvent(context, event),
                                onDelete: () => deleteEvent(context, event),
                              );
                            },
                          ),
                        );
                      }
                    }

                    if (state.status == OrganizerEventsStatus.deleting) {
                      return Stack(
                        children: [
                          content,
                          Container(
                            color: Colors.black26,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    }

                    return content;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
