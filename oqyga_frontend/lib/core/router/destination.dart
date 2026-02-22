import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

// Для пользователя - 4 вкладки
const userDestinations = [
  Destination(label: 'Home', icon: Icons.home),
  Destination(label: 'Map', icon: Icons.location_on_rounded),
  Destination(label: 'Tickets', icon: Icons.confirmation_num_sharp),
  Destination(label: 'Profile', icon: Icons.person),
];

// Для организатора - 3 вкладки
const organisatorDestinations = [
  Destination(label: 'Add', icon: Icons.add_circle_outline_outlined),
  Destination(label: 'My Events', icon: Icons.confirmation_num_sharp),
  Destination(label: 'Profile', icon: Icons.person),
];
