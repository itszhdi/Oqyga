import 'package:flutter/material.dart';
import 'package:oqyga_frontend/features/cards/presentation/views/new_card_method_view.dart';

class NewCardMethodPage extends StatelessWidget {
  final bool isPurchaseFlow;

  const NewCardMethodPage({super.key, this.isPurchaseFlow = false});

  @override
  Widget build(BuildContext context) {
    return NewCardMethodView(isPurchaseFlow: isPurchaseFlow);
  }
}
