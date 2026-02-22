abstract class Routes {
  // Auth
  static const String signInPage = '/sign-in';
  static const String signUpPage = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String validateOTP = '/validate-otp';
  static const String newPassword = '/new-password';

  // Main Tabs (Shell)
  static const String homePage = '/home';
  static const String organisatorEvents = '/organisator-events';
  static const String ticketPage = '/tickets';
  static const String profilePage = '/profile';

  // Sub-routes (relative paths)
  static const String changeProfile = 'edit';
  static const String editEvent = 'edit';

  // Fullscreen pages
  static const String eventFilterPage = '/filter-events';
  static const String ticketFilterPage = '/filter-tickets';
  static const String organizerFilterPage = '/filter-organizer';
  static const String splashPage = '/splash';
}
