part of '../ticket_detail_view.dart';

class _TicketContent extends StatelessWidget {
  final TicketDetails details;
  final Uint8List qrCodeBytes;

  const _TicketContent({required this.details, required this.qrCodeBytes});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final eventInfo = '${details.eventLocation}\n${details.eventDateTime}';
    const borderColor = Colors.black;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: borderColor),
                      left: BorderSide(color: borderColor),
                      right: BorderSide(color: borderColor),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          details.eventName,
                          style: GoogleFonts.jura(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          eventInfo,
                          style: GoogleFonts.jura(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RotatedBox(
                              quarterTurns: -3,
                              child: Text(
                                'Jaña oqyga!',
                                style: GoogleFonts.jura(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _EventPoster(
                                posterUrl: details.fullPosterUrl,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _TicketInfoColumn(
                              title: s.seatInHall,
                              content: SeatsDropdown(
                                allSeatsString: details.allSeatDetails,
                              ),
                            ),
                            _TicketInfoColumn(
                              title: s.ticketCount,
                              content: Text(
                                "${details.totalTickets}",
                                style: GoogleFonts.jura(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const _TicketSeparator(height: 30, color: borderColor),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,

                    border: Border(
                      bottom: BorderSide(color: borderColor),
                      left: BorderSide(color: borderColor),
                      right: BorderSide(color: borderColor),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 95,
                          height: 95,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          alignment: Alignment.center,
                          child: Image.memory(qrCodeBytes),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            s.showTicketToStaff,
                            style: GoogleFonts.jura(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
