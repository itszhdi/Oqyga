import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/my_ticket.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/my_tickets/my_tickets_bloc.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/search_field.dart';

class MyTicketsView extends StatefulWidget {
  const MyTicketsView({super.key});

  @override
  State<MyTicketsView> createState() => _MyTicketsViewState();
}

class _MyTicketsViewState extends State<MyTicketsView> {
  String _searchQuery = '';
  TicketFilters? _currentFilters;

  bool get _hasActiveFilters =>
      _currentFilters != null && !_currentFilters!.isEmpty;

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _openFiltersPage() async {
    final result = await context.push<TicketFilters>(
      Routes.ticketFilterPage,
      extra: _currentFilters,
    );

    if (result != null && mounted) {
      final appliedFilters = result.isEmpty ? null : result;
      setState(() {
        _currentFilters = appliedFilters;
      });
      context.read<MyTicketsBloc>().add(
        FetchMyTickets(filters: appliedFilters),
      );
    }
  }

  void _clearFilters() {
    if (!_hasActiveFilters) return;
    setState(() {
      _currentFilters = null;
    });
    if (!mounted) return;
    context.read<MyTicketsBloc>().add(const FetchMyTickets());
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                s.myTicketsTitle,
                style: GoogleFonts.jura(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: SearchField(onChanged: _onSearchChanged)),
                  const SizedBox(width: 12),
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
                      if (_hasActiveFilters)
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
                  if (_hasActiveFilters)
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
            Expanded(
              child: BlocBuilder<MyTicketsBloc, MyTicketsState>(
                builder: (context, state) {
                  if (state.status == MyTicketsStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == MyTicketsStatus.failure) {
                    final errorMessage = translateErrorMessage(
                      context,
                      state.errorMessage,
                    );
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${s.errorPrefix} $errorMessage',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.jura(color: Colors.red),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<MyTicketsBloc>().add(
                                    FetchMyTickets(filters: _currentFilters),
                                  ),
                              child: Text(s.retryButton),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state.status == MyTicketsStatus.success) {
                    final filteredTickets = state.tickets.where((ticket) {
                      final matchesSearch = ticket.eventName
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                      return matchesSearch;
                    }).toList();

                    if (filteredTickets.isEmpty) {
                      final hasFilters =
                          _searchQuery.isNotEmpty ||
                          (_currentFilters != null &&
                              !_currentFilters!.isEmpty);

                      // Если список пуст из-за фильтров/поиска
                      if (hasFilters) {
                        return Center(
                          child: Text(
                            s.noTicketsFound,
                            style: GoogleFonts.jura(fontSize: 16),
                          ),
                        );
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.confirmation_number_outlined,
                              size: 100,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              s.noTicketsYet,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.jura(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<MyTicketsBloc>().add(
                          FetchMyTickets(filters: _currentFilters),
                        );
                      },
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        itemCount: filteredTickets.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 18),
                        itemBuilder: (context, index) =>
                            _TicketCard(ticket: filteredTickets[index]),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getLocalizedStatus(BuildContext context, String rawStatus) {
  final s = S.of(context);
  final status = rawStatus.toLowerCase().trim();

  if (status == 'active' || status == 'активен') {
    return s.statusActive;
  } else if (status == 'inactive' || status == 'неактивен') {
    return s.statusInactive;
  }
  return rawStatus;
}

class _TicketCard extends StatelessWidget {
  final MyTicket ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final String rawStatus = ticket.status.toLowerCase().trim();
    final bool isActive = rawStatus == 'active' || rawStatus == 'активен';

    return GestureDetector(
      onTap: () => context.pushNamed(
        'ticket-detail',
        pathParameters: {'id': ticket.ticketId.toString()},
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                ticket.fullPosterUrl ?? '',
                width: 70,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 70,
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.eventName,
                    style: GoogleFonts.jura(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ticket.eventDate,
                    style: GoogleFonts.jura(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getLocalizedStatus(context, ticket.status),
                    style: GoogleFonts.jura(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isActive ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 26),
          ],
        ),
      ),
    );
  }
}
