import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/features/events/presentation/bloc/event_list/event_list_bloc.dart';
import 'package:oqyga_frontend/features/events/presentation/widgets/event_card.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/search_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  EventFilters? _currentFilters;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<EventsListBloc>().add(const FetchEvents());
  }

  Future<void> _openFiltersPage() async {
    final result = await context.push<EventFilters>(
      Routes.eventFilterPage,
      extra: _currentFilters,
    );
    if (result != null && mounted) {
      setState(() {
        _currentFilters = result;
      });
      context.read<EventsListBloc>().add(FetchEvents(filters: _currentFilters));
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _clearFilters() {
    setState(() {
      _currentFilters = null;
    });
    context.read<EventsListBloc>().add(const FetchEvents());
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final s = S.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(1, 1),
        child: Container(),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'oqıgany tabynyz',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: SearchField(onChanged: _onSearchChanged)),
                  const SizedBox(width: 12),
                  // Кнопка фильтров с индикатором
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _openFiltersPage,
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
                      // Индикатор активных фильтров
                      if (_currentFilters != null && !_currentFilters!.isEmpty)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Кнопка сброса фильтров
                  if (_currentFilters != null && !_currentFilters!.isEmpty)
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
            ),
            Expanded(child: _buildContent(s)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(S s) {
    final String currentLang = Localizations.localeOf(context).languageCode;

    return BlocBuilder<EventsListBloc, EventsListState>(
      builder: (context, state) {
        switch (state.status) {
          case EventsListStatus.initial:
          case EventsListStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case EventsListStatus.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(s.errorLoadingEvents)],
              ),
            );

          case EventsListStatus.success:
            final filteredEvents = state.events.where((event) {
              final query = _searchQuery.toLowerCase();

              final title = event.getLocalizedTitle(currentLang).toLowerCase();

              return title.contains(query);
            }).toList();

            if (filteredEvents.isEmpty) {
              final hasFilters =
                  _searchQuery.isNotEmpty ||
                  (_currentFilters != null && !_currentFilters!.isEmpty);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hasFilters ? s.noEventsFoundForQuery : s.eventListIsEmpty,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<EventsListBloc>().add(
                  FetchEvents(filters: _currentFilters),
                );
              },
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.63,
                ),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) =>
                    EventCard(event: filteredEvents[index]),
              ),
            );
        }
      },
    );
  }
}
