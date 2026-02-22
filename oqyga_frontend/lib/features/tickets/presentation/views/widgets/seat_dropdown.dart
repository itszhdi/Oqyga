import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeatsDropdown extends StatefulWidget {
  final String allSeatsString;

  const SeatsDropdown({super.key, required this.allSeatsString});

  @override
  State<SeatsDropdown> createState() => _SeatsDropdownState();
}

class _SeatsDropdownState extends State<SeatsDropdown> {
  String? selectedSeat;
  late List<String> seats;

  @override
  void initState() {
    super.initState();
    seats = widget.allSeatsString
        .split(';')
        .where((element) => element.trim().isNotEmpty)
        .toList();

    if (seats.isNotEmpty) {
      selectedSeat = seats.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (seats.length <= 1) {
      return Text(
        widget.allSeatsString.replaceAll(';', ' '),
        style: GoogleFonts.jura(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedSeat,
        isDense: true,
        isExpanded: true,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          size: 20,
          color: Colors.black,
        ),
        style: GoogleFonts.jura(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        items: seats.map((String seat) {
          return DropdownMenuItem<String>(
            value: seat,
            child: Text(seat.trim(), overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedSeat = newValue;
          });
        },
      ),
    );
  }
}
