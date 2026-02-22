import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/router/destination.dart';
import 'package:oqyga_frontend/features/auth/domain/entities/user.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/shared/themes/pallete.dart';

class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final role = context.select((AuthBloc bloc) => bloc.state.user.role);
    final isOrganisator = role == UserRole.organisator;
    final currentIndex = navigationShell.currentIndex;

    final visibleDestinations = isOrganisator
        ? organisatorDestinations
        : userDestinations;

    if (currentIndex >= visibleDestinations.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigationShell.goBranch(0, initialLocation: true);
      });
    }

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 12, right: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: AppPallete.buttonColor,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(visibleDestinations.length, (index) {
                final destination = visibleDestinations[index];
                final isSelected = index == currentIndex;

                return GestureDetector(
                  onTap: () => navigationShell.goBranch(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppPallete.navigateButton
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      destination.icon,
                      size: 30,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
