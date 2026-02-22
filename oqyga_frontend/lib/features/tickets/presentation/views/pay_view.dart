import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/core/errors/error_translator.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_purchase/ticket_purchase_bloc.dart';
import 'package:oqyga_frontend/features/cards/presentation/bloc/card_bloc.dart';
import 'package:oqyga_frontend/shared/views/widgets/button.dart';
import 'package:oqyga_frontend/shared/views/widgets/cards.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

class PayView extends StatefulWidget {
  const PayView({super.key});

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  int? selectedCardId;
  String? oneTimePaymentMethodId;
  final TextEditingController _promoController = TextEditingController();

  static const double serviceFeeRate = 0.10;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _showPromoBottomSheet(BuildContext context) {
    final s = S.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.enterPromoCodeTitle,
                style: GoogleFonts.jura(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _promoController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: s.promoCodeHint,
                        hintStyle: GoogleFonts.jura(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: GoogleFonts.jura(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      if (_promoController.text.isNotEmpty) {
                        context.read<TicketPurchaseBloc>().add(
                          PromocodeSubmitted(_promoController.text),
                        );
                      }
                    },
                    child: Text(
                      s.applyButton,
                      style: GoogleFonts.jura(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (context) => sl<CardBloc>()..add(LoadMyCardsEvent()),
      child: BlocConsumer<TicketPurchaseBloc, TicketPurchaseState>(
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

          if (state.status == TicketPurchaseStatus.success) {
            if (state.purchasedTicketIds.isNotEmpty) {
              context.pushReplacementNamed(
                'ticket-detail',
                pathParameters: {
                  'id': state.purchasedTicketIds.first.toString(),
                },
              );
            } else {
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
          }
        },
        builder: (context, state) {
          if (state.event == null) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final isLoading = state.status == TicketPurchaseStatus.processing;
          final event = state.event!;
          final selectedSeats = state.selectedSeats;

          final totalPrice = state.totalPrice;
          final serviceFee = (totalPrice * serviceFeeRate);

          final double totalBeforeDiscount = totalPrice + serviceFee;

          final double discountRate = state.discountAmount;

          final double discountValueMoney = totalBeforeDiscount * discountRate;

          double finalPrice = totalBeforeDiscount - discountValueMoney;
          if (finalPrice < 0) finalPrice = 0;

          final title = event.title;
          final date = event.date;
          final time = event.time;
          final dateTime = time.isNotEmpty ? '$date, $time' : date;
          final location = '${event.city}, ${event.address}';

          final List<Widget> seatsDisplayWidgets = selectedSeats.isEmpty
              ? [
                  Text(
                    s.seatsNotSelectedLabel,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ]
              : selectedSeats
                    .map(
                      (seat) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          s.seatRowAndNumber(seat.row, seat.number),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList();

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        ShadowedBackButton(
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  title,
                                  style: GoogleFonts.jura(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                dateTime,
                                style: GoogleFonts.jura(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                location,
                                style: GoogleFonts.jura(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: seatsDisplayWidgets,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // --- КНОПКА ПРОМОКОДА ---
                          Center(
                            child: state.isPromocodeLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black,
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () =>
                                        _showPromoBottomSheet(context),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      state.appliedPromocode.isEmpty
                                          ? s.enterPromoCodeButton
                                          : s.appliedPromoCodeLabel(
                                              state.appliedPromocode,
                                            ),
                                      style: GoogleFonts.jura(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.black,
                                      ),
                                    ),
                                  ),
                          ),

                          if (state.appliedPromocode.isNotEmpty &&
                              !state.isPromocodeLoading)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  s.promoCodeSuccess,
                                  style: GoogleFonts.jura(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 24),

                          _buildPriceRow(
                            s.priceLabel,
                            '${totalPrice.toStringAsFixed(0)} тг',
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: _buildPriceRow(
                              s.serviceFeeLabel,
                              '$serviceFee тг',
                            ),
                          ),
                          if (discountRate > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: _buildPriceRow(
                                s.discountLabel(
                                  (discountRate * 100).toStringAsFixed(0),
                                ),
                                '-${discountValueMoney.toStringAsFixed(0)} тг',
                                color: Colors.green,
                                isBold: true,
                              ),
                            ),

                          const SizedBox(height: 12),
                          _buildPriceRow(
                            s.totalPriceLabel,
                            '${finalPrice.toStringAsFixed(0)} тг',
                            isBold: true,
                          ),
                          const SizedBox(height: 32),

                          PaymentCardsSelector(
                            isPurchaseFlow: true,
                            showDeleteButton: false,
                            onCardSelected: (cardId) {
                              setState(() {
                                selectedCardId = cardId;
                                oneTimePaymentMethodId = null;
                              });
                            },
                            onOneTimeCardSelected: (pmId, save) {
                              setState(() {
                                selectedCardId = null;
                                oneTimePaymentMethodId = pmId;
                              });
                            },
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: CustomButton(
                      text: isLoading
                          ? s.processingPayment
                          : s.payButton(finalPrice.toStringAsFixed(0)),
                      onPressed: () {
                        if (isLoading) return;

                        if (selectedCardId == null &&
                            oneTimePaymentMethodId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(s.choosePaymentMethod)),
                          );
                          return;
                        }
                        if (selectedSeats.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(s.seatsNotSelected)),
                          );
                          return;
                        }
                        context.read<TicketPurchaseBloc>().add(
                          PurchaseSubmitted(
                            savedCardId: selectedCardId,
                            newPaymentMethodId: oneTimePaymentMethodId,

                            saveNewCard: false,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool isBold = false,
    Color color = Colors.black,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jura(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: color,
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.jura(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
