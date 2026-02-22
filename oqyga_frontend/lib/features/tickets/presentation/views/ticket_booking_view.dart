import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_purchase/ticket_purchase_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/widgets/seating_map_widget.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/themes/pallete.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

class TicketBookingView extends StatefulWidget {
  const TicketBookingView({super.key});

  @override
  State<TicketBookingView> createState() => _TicketBookingViewState();
}

class _TicketBookingViewState extends State<TicketBookingView> {
  int? selectedPriceIndex;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<TicketPurchaseBloc, TicketPurchaseState>(
      listener: (context, state) {
        if (state.status == TicketPurchaseStatus.failure) {
          final errorMessage = translateErrorMessage(
            context,
            state.errorMessage,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == TicketPurchaseStatus.initial ||
            (state.status == TicketPurchaseStatus.selecting &&
                state.event == null)) {
          return const Scaffold(
            backgroundColor: AppPallete.backgroundColor,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final event = state.event!;

        final displayPrices = state.sortedTicketTypes
            .map((e) => e.price.toInt())
            .toList();
        final selectedSeats = state.selectedSeats;

        String selectedSeatsDescription;
        if (selectedSeats.isEmpty) {
          selectedSeatsDescription = s.seatsNotSelectedLabel;
        } else if (selectedSeats.length == 1) {
          final seat = selectedSeats.first;
          selectedSeatsDescription = s.seatRowAndNumber(seat.row, seat.number);
        } else {
          final firstSeat = selectedSeats.first;
          selectedSeatsDescription = s.selectedSeatsDescription(
            selectedSeats.length,
            firstSeat.row,
            firstSeat.number,
          );
        }

        return Scaffold(
          backgroundColor: AppPallete.backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      ShadowedBackButton(onPressed: () => context.pop()),
                      const SizedBox(width: 16),
                      Text(
                        s.ticketBookingTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                event.title,
                                style: GoogleFonts.jura(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: AppPallete.borderColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                event.date,
                                style: GoogleFonts.jura(
                                  fontSize: 14,
                                  color: AppPallete.borderColor.withOpacity(
                                    0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${event.city}, ${event.address}',
                                style: GoogleFonts.jura(
                                  fontSize: 14,
                                  color: AppPallete.borderColor.withOpacity(
                                    0.6,
                                  ),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),

                        // Map Container
                        Container(
                          width: double.infinity,
                          height: 500,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E8E8),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              children: [
                                // Цены (фильтр)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      displayPrices.length,
                                      (index) {
                                        final isSelected =
                                            selectedPriceIndex == index;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4.5,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedPriceIndex = isSelected
                                                    ? null
                                                    : index;
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? AppPallete.buttonColor
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.05),
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                '${displayPrices[index]} тг',
                                                style: GoogleFonts.jura(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : AppPallete.borderColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Карта мест
                                Expanded(
                                  child: SeatingMapWidget(
                                    seatingMap: state.seatingMap,
                                    prices: displayPrices,
                                    selectedPriceIndex: selectedPriceIndex,
                                    onSeatTap: (row, number) {
                                      context.read<TicketPurchaseBloc>().add(
                                        SeatToggled(row: row, number: number),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Bar
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppPallete.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedSeatsDescription,
                    style: GoogleFonts.jura(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppPallete.borderColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        s.totalPriceWithCount(
                          selectedSeats.length,
                          state.totalPrice.toStringAsFixed(0),
                        ),
                        style: GoogleFonts.jura(
                          fontSize: 16,
                          color: AppPallete.borderColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: s.checkoutButton,
                    onPressed: () {
                      if (selectedSeats.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(s.selectAtLeastOneSeat)),
                        );
                        return;
                      }

                      // Переход на страницу оплаты
                      final bloc = context.read<TicketPurchaseBloc>();
                      context.push('/event/${event.id}/pay', extra: bloc);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
