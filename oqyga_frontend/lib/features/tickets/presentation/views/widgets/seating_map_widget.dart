import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/features/tickets/domain/entities/seat.dart'
    show Seat;
import 'package:oqyga_frontend/generated/l10n.dart';
import 'package:oqyga_frontend/shared/themes/pallete.dart';

List<List<Seat>> getSeatingMapByPrices(List<int> prices) {
  switch (prices.length) {
    case 1:
      return generateArenaSeatingMap(prices.first);
    case 2:
      return generateSeatingMap2Types(prices);
    case 3:
      return generateClubSeatingMap(prices);
    case 4:
      return generateSeatingMap4Types(prices);
    case 5:
      return generateSeatingMap5Types(prices);
    default:
      return generateClubSeatingMap(prices);
  }
}

List<List<Seat>> generateSeatingMap5Types(List<int> prices) {
  List<List<Seat>> map = [];
  const int totalRows = 12;
  const int seatsPerRow = 16;

  List<int> sortedPrices = List.from(prices)..sort((a, b) => b.compareTo(a));

  for (int r = 1; r <= totalRows; r++) {
    List<Seat> row = [];
    int priceIndex;

    if (r <= 2) {
      priceIndex = 0; // Zone A
    } else if (r <= 4) {
      priceIndex = 1; // Zone B
    } else if (r <= 6) {
      priceIndex = 2; // Zone C
    } else if (r <= 9) {
      priceIndex = 3; // Zone D
    } else {
      priceIndex = 4; // Zone E
    }

    for (int s = 1; s <= seatsPerRow; s++) {
      int skipSides = 0;
      if (r == 1) skipSides = 3;
      if (r == 2) skipSides = 2;
      if (r == 3) skipSides = 1;

      if (s <= skipSides || s > seatsPerRow - skipSides) continue;

      bool isBooked = (r == 5 && s == 5);

      row.add(
        Seat(
          row: r,
          number: s,
          priceIndex: priceIndex,
          price: sortedPrices[priceIndex],
          isBooked: isBooked,
          isVip: priceIndex == 0,
        ),
      );
    }
    map.add(row);
  }
  return map;
}

List<List<Seat>> generateSeatingMap4Types(List<int> prices) {
  List<List<Seat>> map = [];
  const int totalRows = 10;
  const int seatsPerRow = 16;

  List<int> sortedPrices = List.from(prices)..sort((a, b) => b.compareTo(a));

  for (int r = 1; r <= totalRows; r++) {
    List<Seat> row = [];
    int priceIndex;

    if (r <= 2) {
      priceIndex = 0;
    } else if (r <= 4) {
      priceIndex = 1;
    } else if (r <= 7) {
      priceIndex = 2;
    } else {
      priceIndex = 3;
    }

    for (int s = 1; s <= seatsPerRow; s++) {
      if (r <= 2 && (s < 3 || s > seatsPerRow - 2)) continue;

      bool isBooked = (r % 3 == 0 && s % 5 == 0);

      row.add(
        Seat(
          row: r,
          number: s,
          priceIndex: priceIndex,
          price: sortedPrices[priceIndex],
          isBooked: isBooked,
          isVip: priceIndex == 0,
        ),
      );
    }
    map.add(row);
  }
  return map;
}

List<List<Seat>> generateSeatingMap2Types(List<int> prices) {
  List<List<Seat>> map = [];
  const int totalRows = 8;
  const int seatsPerRow = 14;

  List<int> sortedPrices = List.from(prices)..sort((a, b) => b.compareTo(a));

  for (int r = 1; r <= totalRows; r++) {
    List<Seat> row = [];
    int priceIndex;
    if (r <= 4) {
      priceIndex = 0;
    } else {
      priceIndex = 1;
    }

    for (int s = 1; s <= seatsPerRow; s++) {
      bool isBooked = (r == 2 && s % 6 == 0) || (r == 6 && s % 4 == 0);

      row.add(
        Seat(
          row: r,
          number: s,
          priceIndex: priceIndex,
          price: sortedPrices[priceIndex],
          isBooked: isBooked,
          isVip: priceIndex == 0,
        ),
      );
    }
    map.add(row);
  }
  return map;
}

List<List<Seat>> generateArenaSeatingMap(int singlePrice) {
  List<List<Seat>> map = [];
  const int totalRows = 8;

  int seatsInRow = 6;

  for (int r = 1; r <= totalRows; r++) {
    List<Seat> row = [];

    int currentSeatsCount = seatsInRow + ((r - 1) * 2);

    for (int s = 1; s <= currentSeatsCount; s++) {
      bool isBooked = (r % 2 == 0 && s % 5 == 0);

      row.add(
        Seat(
          row: r,
          number: s,
          priceIndex: 0,
          price: singlePrice,
          isBooked: isBooked,
          isVip: false,
        ),
      );
    }
    map.add(row);
  }
  return map;
}

List<List<Seat>> generateClubSeatingMap(List<int> prices) {
  List<List<Seat>> map = [];
  List<int> sortedPrices = List.from(prices)..sort((a, b) => b.compareTo(a));

  int getSafePrice(int index) {
    if (index < sortedPrices.length) return sortedPrices[index];
    return sortedPrices.last;
  }

  int getSafeIndex(int index) {
    if (index < sortedPrices.length) return index;
    return sortedPrices.length - 1;
  }

  final List<List<int>> rowConfig = [
    [1, 10, 0],
    [2, 12, 0],
    [3, 14, 0],
    [4, 10, 1],
    [5, 10, 1],
    [6, 12, 1],
    [7, 16, 2],
    [8, 16, 2],
  ];

  for (var config in rowConfig) {
    int r = config[0];
    int count = config[1];
    int configPIndex = config[2];

    int actualPIndex = getSafeIndex(configPIndex);
    int price = getSafePrice(configPIndex);

    List<Seat> row = [];

    for (int s = 1; s <= count; s++) {
      bool isBooked = (r == 8 && s > 10);

      row.add(
        Seat(
          row: r,
          number: s,
          priceIndex: actualPIndex,
          price: price,
          isBooked: isBooked,
          isVip: actualPIndex == 0,
        ),
      );
    }
    map.add(row);
  }
  return map;
}

class SeatingMapWidget extends StatelessWidget {
  final List<List<Seat>> seatingMap;
  final List<int> prices;
  final int? selectedPriceIndex;
  final Function(int row, int number) onSeatTap;

  const SeatingMapWidget({
    super.key,
    required this.seatingMap,
    required this.prices,
    required this.onSeatTap,
    this.selectedPriceIndex,
  });

  static const double seatDiameter = 20.0;
  static const double seatMargin = 2.5;
  static const double totalSeatWidth = seatDiameter + (seatMargin * 2);
  static const double rowNumberWidth = 25.0;

  Color _getSeatColor(Seat seat, Color defaultSelectedColor) {
    if (seat.isBooked) return Colors.grey.shade900;
    if (seat.isSelected) return defaultSelectedColor;

    if (prices.length == 1) return Colors.blueGrey.shade200;

    switch (seat.priceIndex) {
      case 0:
        return const Color.fromARGB(255, 215, 77, 77); // Самый дорогой
      case 1:
        return const Color.fromARGB(255, 121, 200, 234);
      case 2:
        return const Color.fromARGB(255, 109, 224, 117);
      case 3:
        return const Color.fromARGB(255, 193, 174, 62);
      case 4:
        return const Color.fromARGB(255, 63, 85, 147); // Самый дешевый
      default:
        return const Color.fromARGB(255, 202, 124, 184);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final Color selectedColor = AppPallete.buttonColor;

    return Column(
      children: [
        Expanded(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            boundaryMargin: const EdgeInsets.all(50.0),
            constrained: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Сцена
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      s.stageLabel,
                      style: GoogleFonts.jura(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                ...seatingMap.map((row) {
                  final rowIndex = row.first.row;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Номер ряда (слева)
                        SizedBox(
                          width: rowNumberWidth,
                          child: Text(
                            '$rowIndex',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Места
                        ...row.map(
                          (seat) => _buildSeat(seat, selectedColor, s),
                        ),

                        const SizedBox(width: 8),
                        SizedBox(
                          width: rowNumberWidth,
                          child: Text(
                            '$rowIndex',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        _buildLegend(selectedColor, s),
      ],
    );
  }

  Widget _buildSeat(Seat seat, Color selectedColor, S s) {
    final Color seatColor = _getSeatColor(seat, selectedColor);
    Color borderColor = Colors.transparent;

    if (prices.length > 1 &&
        selectedPriceIndex == seat.priceIndex &&
        !seat.isSelected) {
      borderColor = selectedColor.withOpacity(0.7);
    }
    if (seat.isSelected) {
      borderColor = selectedColor;
    }

    return GestureDetector(
      onTap: () => onSeatTap(seat.row, seat.number),
      child: Tooltip(
        message: s.seatTooltip(
          seat.row,
          seat.number,
          (seat.price as num).toDouble(),
        ),
        child: Container(
          width: seatDiameter,
          height: seatDiameter,
          margin: const EdgeInsets.symmetric(horizontal: seatMargin),
          decoration: BoxDecoration(
            color: seatColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: borderColor == Colors.transparent ? 0 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: seat.isSelected
              ? const Center(
                  child: Icon(Icons.check, size: 12, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLegend(Color selectedColor, S s) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.center,
      children: [
        _legendItem(Colors.black, s.seatSelected),
        _legendItem(Colors.grey.shade900, s.seatBooked),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12, width: 0.5),
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
      ],
    );
  }
}
