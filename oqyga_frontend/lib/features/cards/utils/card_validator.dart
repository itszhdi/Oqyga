class CardValidator {
  static bool validateSum52(String cardNumber) {
    String cleanNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (cleanNumber.length != 16) return false;
    int sum = 0;
    for (int i = 0; i < cleanNumber.length; i++) {
      sum += int.parse(cleanNumber[i]);
    }
    return sum > 20;
  }

  static String getCardType(String cardNumber) {
    String cleanNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.isEmpty) return 'unknown';

    if (cleanNumber.startsWith('4')) {
      return 'visa';
    } else if (RegExp(
      r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[0-1]|2720)',
    ).hasMatch(cleanNumber)) {
      return 'mastercard';
    } else if (cleanNumber.startsWith('34') || cleanNumber.startsWith('37')) {
      return 'amex';
    }

    return 'unknown';
  }
}
