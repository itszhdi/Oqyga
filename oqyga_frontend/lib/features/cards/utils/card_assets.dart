class CardAssets {
  static const String _basePath = 'assets/static';

  static const String visa = '$_basePath/visa card.png';
  static const String mastercard = '$_basePath/master card.png';
  static const String amex = '$_basePath/emax.png';
  static const String unknown = '$_basePath/default.png';

  static String getLogoByBrand(String brand) {
    switch (brand.toLowerCase().trim()) {
      case 'visa':
        return visa;
      case 'mastercard':
        return mastercard;
      case 'american express':
      case 'amex':
        return amex;
      default:
        return unknown;
    }
  }
}
