class TicketTypeRequest {
  final String description;
  final double price;
  final int quantity;

  const TicketTypeRequest({
    required this.description,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'price': price,
    'quantity': quantity,
  };
}
