import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/core/router/routes.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_detail/ticket_detail_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/widgets/seat_dropdown.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

part 'widgets/ticket_content.dart';
part 'widgets/ticket_header.dart';
part 'widgets/ticket_info_column.dart';
part 'widgets/event_poster.dart';
part 'widgets/poster_placeholder.dart';
part 'widgets/ticket_separator.dart';

class TicketDetailView extends StatelessWidget {
  const TicketDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TicketHeader(
              onBackPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(Routes.ticketPage);
                }
              },
            ),
            Expanded(
              child: BlocBuilder<TicketDetailBloc, TicketDetailState>(
                builder: (context, state) {
                  switch (state.status) {
                    case TicketDetailStatus.loading:
                      return const Center(child: CircularProgressIndicator());

                    case TicketDetailStatus.failure:
                      final errorMessage = translateErrorMessage(
                        context,
                        state.errorMessage,
                      );
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '${s.errorPrefix} $errorMessage',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.jura(color: Colors.red),
                          ),
                        ),
                      );

                    case TicketDetailStatus.success:
                      if (state.details != null && state.qrCodeBytes != null) {
                        return _TicketContent(
                          details: state.details!,
                          qrCodeBytes: state.qrCodeBytes!,
                        );
                      }
                      return Center(child: Text(s.noDataForTicket));

                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
