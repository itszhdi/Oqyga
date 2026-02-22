import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/features/cards/presentation/bloc/card_bloc.dart';
import 'package:oqyga_frontend/features/cards/presentation/widgets/delete_card_confirmation_dialog.dart';
import 'package:oqyga_frontend/features/cards/utils/card_assets.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class PaymentCardsSelector extends StatefulWidget {
  final int? initialSelectedCardId;
  final Function(int)? onCardSelected;
  final bool isPurchaseFlow;
  final Function(String paymentMethodId, bool saveCard)? onOneTimeCardSelected;
  final bool showDeleteButton;

  const PaymentCardsSelector({
    super.key,
    this.initialSelectedCardId,
    this.onCardSelected,
    this.isPurchaseFlow = false,
    this.onOneTimeCardSelected,
    this.showDeleteButton = false,
  });

  @override
  State<PaymentCardsSelector> createState() => _PaymentCardsSelectorState();
}

class _PaymentCardsSelectorState extends State<PaymentCardsSelector> {
  int? _selectedCardId;
  String? _selectedOneTimeId;

  @override
  void initState() {
    super.initState();
    _selectedCardId = widget.initialSelectedCardId;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocConsumer<CardBloc, CardState>(
      listener: (context, state) {
        if (state is CardFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is CardLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        if (state is CardLoaded) {
          final cards = state.cards;

          if (!widget.showDeleteButton &&
              cards.isNotEmpty &&
              _selectedCardId == null &&
              _selectedOneTimeId == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _selectedCardId = cards.first.id;
                });
                widget.onCardSelected?.call(cards.first.id);
              }
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.cardsTitle, // "Карты"
                style: GoogleFonts.jura(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              if (cards.isEmpty && _selectedOneTimeId == null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(s.noSavedCards, style: GoogleFonts.jura()),
                )
              else ...[
                ...cards.map(
                  (card) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildPaymentMethodOption(
                      id: card.id,
                      title: "**** ${card.lastFourDigits}",
                      iconPath: CardAssets.getLogoByBrand(card.brand),
                      isSavedCard: true,
                      s: s,
                    ),
                  ),
                ),
                if (_selectedOneTimeId != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildPaymentMethodOption(
                      id: -1,
                      title: s.oneTimeCard,
                      iconPath: CardAssets.getLogoByBrand('Unknown'),
                      isSavedCard: false,
                      s: s,
                    ),
                  ),
              ],
              GestureDetector(
                onTap: () async {
                  final result = await context.push<Object?>(
                    '/new-card',
                    extra: {
                      'bloc': context.read<CardBloc>(),
                      'isPurchaseFlow': widget.isPurchaseFlow,
                    },
                  );

                  if (result != null && result is Map<String, dynamic>) {
                    final pmId = result['paymentMethodId'] as String;
                    final isSaving = result['saveCard'] as bool;

                    if (!isSaving) {
                      setState(() {
                        _selectedCardId = null;
                        _selectedOneTimeId = pmId;
                      });
                      widget.onOneTimeCardSelected?.call(pmId, false);
                    }
                  }
                },
                child: _buildAddCardButton(s),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPaymentMethodOption({
    required int id,
    required String title,
    required String iconPath,
    required bool isSavedCard,
    required S s,
  }) {
    final isSelected =
        (!widget.showDeleteButton) &&
        ((isSavedCard && _selectedCardId == id) ||
            (!isSavedCard && _selectedOneTimeId != null));

    return GestureDetector(
      onTap: () {
        if (!isSavedCard || widget.showDeleteButton) return;
        setState(() {
          _selectedCardId = id;
          _selectedOneTimeId = null;
        });
        widget.onCardSelected?.call(id);
      },
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 40, height: 25),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.jura(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 30,
              alignment: Alignment.centerRight,
              child: _buildTrailingWidget(id, isSelected, isSavedCard),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailingWidget(int id, bool isSelected, bool isSavedCard) {
    if (widget.showDeleteButton && isSavedCard) {
      return IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.redAccent,
          size: 22,
        ),
        onPressed: () async {
          final confirmed = await DeleteCardConfirmationDialog.show(context);
          if (confirmed == true) {
            if (mounted) {
              context.read<CardBloc>().add(DeleteCardEvent(id));
            }
          }
        },
      );
    }

    if (isSelected) {
      return const Icon(Icons.check, color: Colors.black, size: 24);
    }

    return const SizedBox.shrink();
  }

  Widget _buildAddCardButton(S s) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.add, color: Colors.black),
          const SizedBox(width: 16),
          Text(
            s.addCard,
            style: GoogleFonts.jura(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
