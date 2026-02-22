import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/views/widgets/cards.dart';
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

class MyCardsView extends StatelessWidget {
  const MyCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShadowedBackButton(
                    onPressed: () {
                      if (context.canPop()) context.pop();
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    s.myCards,
                    style: GoogleFonts.jura(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: PaymentCardsSelector(
                    showDeleteButton: true,
                    onCardSelected: (cardId) {
                      debugPrint('Selected Card ID: $cardId');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
