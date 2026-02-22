import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/features/cards/presentation/bloc/card_bloc.dart';
import 'package:oqyga_frontend/features/cards/presentation/views/my_cards_view.dart';

class MyCardsPage extends StatelessWidget {
  const MyCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CardBloc>()..add(LoadMyCardsEvent()),
      child: const MyCardsView(),
    );
  }
}
