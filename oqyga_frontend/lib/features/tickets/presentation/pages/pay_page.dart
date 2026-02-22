import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_purchase/ticket_purchase_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/views/pay_view.dart';

class PayPage extends StatelessWidget {
  final TicketPurchaseBloc ticketPurchaseBloc;

  const PayPage({super.key, required this.ticketPurchaseBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ticketPurchaseBloc,
      child: const PayView(),
    );
  }
}
