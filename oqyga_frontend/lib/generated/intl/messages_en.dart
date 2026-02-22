// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(code) => "Promo code: ${code}";

  static String m1(cityName) => "Is your city ${cityName}?";

  static String m2(itemName) => "Do you really want to delete \"${itemName}\"?";

  static String m3(percent) => "Discount (${percent}%)";

  static String m4(field) => "Enter ${field}";

  static String m5(reason) => "Error uploading photo: ${reason}";

  static String m6(phoneNumber) =>
      "We sent a code to ${phoneNumber}.\nEnter it below.";

  static String m7(amount) => "Pay ${amount} ₸";

  static String m8(row, number) => "Row ${row}, Seat ${number}";

  static String m9(row, number, price) =>
      "Row: ${row}, Seat: ${number}, Price: ${price} ₸";

  static String m10(count, row, number) =>
      "${count} ticket(s): row ${row}, seat ${number}...";

  static String m11(errorMessage) => "Sign-in error: ${errorMessage}";

  static String m12(errorMessage) => "Sign-up error: ${errorMessage}";

  static String m13(count, amount) => "${count} ticket(s): ${amount} ₸";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addCard": MessageLookupByLibrary.simpleMessage("Add card"),
    "addEventTitle": MessageLookupByLibrary.simpleMessage("Add Event"),
    "addPoster": MessageLookupByLibrary.simpleMessage("Add Poster"),
    "addPosterAndTitleError": MessageLookupByLibrary.simpleMessage(
      "Add a poster and fill in the title",
    ),
    "addPriceCategoryButton": MessageLookupByLibrary.simpleMessage(
      "Add Price Category",
    ),
    "addressNotSpecified": MessageLookupByLibrary.simpleMessage(
      "Address not specified",
    ),
    "ageRestrictionLabel": MessageLookupByLibrary.simpleMessage(
      "Age Restriction",
    ),
    "alreadyHaveAccountLink": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "appLanguageTitle": MessageLookupByLibrary.simpleMessage("App Language"),
    "appliedPromoCodeLabel": m0,
    "applyButton": MessageLookupByLibrary.simpleMessage("Apply"),
    "basicInfoTitle": MessageLookupByLibrary.simpleMessage("Basic Information"),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Buy Ticket"),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cardAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Card added successfully",
    ),
    "cardNumberHint": MessageLookupByLibrary.simpleMessage(
      "0000 0000 0000 0000",
    ),
    "cardNumberLabel": MessageLookupByLibrary.simpleMessage("Card Number"),
    "cardNumberTooShort": MessageLookupByLibrary.simpleMessage(
      "Card number is too short",
    ),
    "cardsTitle": MessageLookupByLibrary.simpleMessage("Cards"),
    "categoryHint": MessageLookupByLibrary.simpleMessage("Category"),
    "categoryLabel": MessageLookupByLibrary.simpleMessage("Category"),
    "changePasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Change Password",
    ),
    "changePhotoLabel": MessageLookupByLibrary.simpleMessage("Change Photo"),
    "changePoster": MessageLookupByLibrary.simpleMessage("Change Poster"),
    "changingPassword": MessageLookupByLibrary.simpleMessage(
      "Changing password...",
    ),
    "checkoutButton": MessageLookupByLibrary.simpleMessage("Checkout"),
    "chooseCityHint": MessageLookupByLibrary.simpleMessage("Choose City"),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("Choose language"),
    "choosePaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Please select a payment method",
    ),
    "cityLabel": MessageLookupByLibrary.simpleMessage("City"),
    "cityNotSpecified": MessageLookupByLibrary.simpleMessage(
      "City not specified",
    ),
    "confirmButton": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmPasswordEmpty": MessageLookupByLibrary.simpleMessage(
      "Confirm your password",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm password",
    ),
    "confirm_city_content": MessageLookupByLibrary.simpleMessage(
      "Show events in this city?",
    ),
    "confirm_city_title": m1,
    "currentPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Current Password",
    ),
    "cvvLabel": MessageLookupByLibrary.simpleMessage("CVV"),
    "dateHint": MessageLookupByLibrary.simpleMessage("Date"),
    "dateRangeHint": MessageLookupByLibrary.simpleMessage("Date - Date"),
    "deleteButton": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteCategoryTooltip": MessageLookupByLibrary.simpleMessage(
      "Delete Category",
    ),
    "deleteConfirmationTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Confirmation",
    ),
    "deleteEventConfirmation": m2,
    "descriptionTitle": MessageLookupByLibrary.simpleMessage("Description"),
    "discountLabel": m3,
    "editEventTitle": MessageLookupByLibrary.simpleMessage("Edit Event"),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage("Edit"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emptyError": m4,
    "enterCardNumber": MessageLookupByLibrary.simpleMessage(
      "Enter Card Number",
    ),
    "enterNewPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Enter your new password",
    ),
    "enterOtpError": MessageLookupByLibrary.simpleMessage("Enter code"),
    "enterPhoneToResetDescription": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number to receive a verification code.",
    ),
    "enterPromoCodeButton": MessageLookupByLibrary.simpleMessage(
      "Enter promo code",
    ),
    "enterPromoCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Enter promo code",
    ),
    "errorAddingCard": MessageLookupByLibrary.simpleMessage(
      "Error adding card",
    ),
    "errorChangingPassword": MessageLookupByLibrary.simpleMessage(
      "Failed to change password",
    ),
    "errorCreatingEvent": MessageLookupByLibrary.simpleMessage(
      "Error creating event",
    ),
    "errorDeletingEvent": MessageLookupByLibrary.simpleMessage(
      "Failed to delete event",
    ),
    "errorLoadingEvents": MessageLookupByLibrary.simpleMessage(
      "Error loading events!",
    ),
    "errorLoadingProfile": MessageLookupByLibrary.simpleMessage(
      "Error loading profile",
    ),
    "errorLoadingQrCode": MessageLookupByLibrary.simpleMessage(
      "Failed to load QR code",
    ),
    "errorLoadingTicketDetails": MessageLookupByLibrary.simpleMessage(
      "Failed to load ticket details",
    ),
    "errorLoadingTickets": MessageLookupByLibrary.simpleMessage(
      "Error loading tickets",
    ),
    "errorLoadingVenues": MessageLookupByLibrary.simpleMessage(
      "Failed to load venues list",
    ),
    "errorPrefix": MessageLookupByLibrary.simpleMessage("Error: "),
    "errorPurchasingTicket": MessageLookupByLibrary.simpleMessage(
      "Error purchasing ticket",
    ),
    "errorUpdatingEvent": MessageLookupByLibrary.simpleMessage(
      "Error updating event",
    ),
    "errorUpdatingProfile": MessageLookupByLibrary.simpleMessage(
      "Error updating profile",
    ),
    "errorUploadingPhoto": MessageLookupByLibrary.simpleMessage(
      "Failed to upload photo",
    ),
    "errorUploadingPhotoWithReason": m5,
    "eventCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Event successfully created!",
    ),
    "eventDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Tell about the event...",
    ),
    "eventFiltersTitle": MessageLookupByLibrary.simpleMessage("Event Filters"),
    "eventHasPassed": MessageLookupByLibrary.simpleMessage("Event has passed"),
    "eventListIsEmpty": MessageLookupByLibrary.simpleMessage(
      "The event list is empty",
    ),
    "eventNameHint": MessageLookupByLibrary.simpleMessage("Event Name"),
    "eventNotFound": MessageLookupByLibrary.simpleMessage("Event not found"),
    "eventUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Event successfully updated!",
    ),
    "expiryDateLabel": MessageLookupByLibrary.simpleMessage(
      "Expiry Date (MM/YY)",
    ),
    "failedToCreatePaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Failed to create payment method",
    ),
    "failedToGetCards": MessageLookupByLibrary.simpleMessage(
      "Failed to get cards",
    ),
    "failedToGetEvent": MessageLookupByLibrary.simpleMessage(
      "Failed to get event",
    ),
    "failedToGetEvents": MessageLookupByLibrary.simpleMessage(
      "Failed to get events",
    ),
    "failedToLoadAgeRestrictions": MessageLookupByLibrary.simpleMessage(
      "Failed to load age restrictions",
    ),
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "Failed to load categories",
    ),
    "failedToLoadCities": MessageLookupByLibrary.simpleMessage(
      "Failed to load cities",
    ),
    "failedToLoadFilterOptions": MessageLookupByLibrary.simpleMessage(
      "Failed to load filter options",
    ),
    "failedToLoadMyEvents": MessageLookupByLibrary.simpleMessage(
      "Error loading your events",
    ),
    "failedToResetPassword": MessageLookupByLibrary.simpleMessage(
      "Failed to reset password",
    ),
    "failedToSendOtp": MessageLookupByLibrary.simpleMessage(
      "Failed to send code",
    ),
    "fieldCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Field cannot be empty",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("Field is required"),
    "fillAllTicketDataError": MessageLookupByLibrary.simpleMessage(
      "Fill in data for all ticket categories",
    ),
    "filterButtonText": MessageLookupByLibrary.simpleMessage("Filter"),
    "findYourEvent": MessageLookupByLibrary.simpleMessage("Find your event"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "go_to_event": MessageLookupByLibrary.simpleMessage("Go to"),
    "invalidCardNumber": MessageLookupByLibrary.simpleMessage(
      "Invalid card number",
    ),
    "invalidCredentialsError": MessageLookupByLibrary.simpleMessage(
      "Invalid username or password",
    ),
    "invalidCvv": MessageLookupByLibrary.simpleMessage("Invalid CVV"),
    "invalidDateFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid date format",
    ),
    "invalidEventId": MessageLookupByLibrary.simpleMessage("Invalid event ID"),
    "invalidFormat": MessageLookupByLibrary.simpleMessage("Invalid format"),
    "invalidOtp": MessageLookupByLibrary.simpleMessage("Invalid code"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "linkCard": MessageLookupByLibrary.simpleMessage("Link Card"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "logoutButton": MessageLookupByLibrary.simpleMessage("Log Out"),
    "logoutDialogTitle": MessageLookupByLibrary.simpleMessage(
      "Do you really want to log out?",
    ),
    "maxTicketCategoriesError": MessageLookupByLibrary.simpleMessage(
      "Maximum 5 price categories",
    ),
    "myCards": MessageLookupByLibrary.simpleMessage("My Cards"),
    "myEventsTitle": MessageLookupByLibrary.simpleMessage("My Events"),
    "myTicketTitle": MessageLookupByLibrary.simpleMessage("My Ticket"),
    "myTicketsTitle": MessageLookupByLibrary.simpleMessage("My Tickets"),
    "networkError": MessageLookupByLibrary.simpleMessage("Network error"),
    "newCard": MessageLookupByLibrary.simpleMessage("New Card"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("New Password"),
    "newPasswordTitle": MessageLookupByLibrary.simpleMessage("New Password"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noAccountLink": MessageLookupByLibrary.simpleMessage("No account?"),
    "noButton": MessageLookupByLibrary.simpleMessage("No"),
    "noCreatedEvents": MessageLookupByLibrary.simpleMessage(
      "You haven\'t created any events yet",
    ),
    "noDataForTicket": MessageLookupByLibrary.simpleMessage(
      "No data to display ticket.",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage("No description"),
    "noEventsFound": MessageLookupByLibrary.simpleMessage(
      "No events found for your request",
    ),
    "noEventsFoundForQuery": MessageLookupByLibrary.simpleMessage(
      "No events found for your request",
    ),
    "noSavedCards": MessageLookupByLibrary.simpleMessage("No saved cards"),
    "noTicketPriceInfo": MessageLookupByLibrary.simpleMessage(
      "No ticket price information",
    ),
    "noTicketsFound": MessageLookupByLibrary.simpleMessage(
      "No tickets found for your request",
    ),
    "noTicketsYet": MessageLookupByLibrary.simpleMessage(
      "You have no purchased tickets yet",
    ),
    "notSpecified": MessageLookupByLibrary.simpleMessage("Not specified"),
    "oneTimeCard": MessageLookupByLibrary.simpleMessage("New card (one-time)"),
    "organizationNameLabel": MessageLookupByLibrary.simpleMessage(
      "Organization Name",
    ),
    "organizerFiltersTitle": MessageLookupByLibrary.simpleMessage(
      "Organizer Filters",
    ),
    "organizerTitle": MessageLookupByLibrary.simpleMessage("Organizer"),
    "otpLabel": MessageLookupByLibrary.simpleMessage("Verification code"),
    "otpSentDescription": m6,
    "passwordChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "Password changed successfully",
    ),
    "passwordEmpty": MessageLookupByLibrary.simpleMessage("Enter password"),
    "passwordError": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "Password successfully changed!",
    ),
    "passwordsDoNotMatchError": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "payButton": m7,
    "paymentMethodsTitle": MessageLookupByLibrary.simpleMessage(
      "Payment Methods",
    ),
    "phoneEmpty": MessageLookupByLibrary.simpleMessage("Enter phone number"),
    "phoneFormat": MessageLookupByLibrary.simpleMessage("Format: +77001234567"),
    "phoneHint": MessageLookupByLibrary.simpleMessage("+77001234567"),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("Phone number"),
    "photoUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Photo updated successfully",
    ),
    "posterNotFound": MessageLookupByLibrary.simpleMessage("Poster\nnot found"),
    "priceFromHint": MessageLookupByLibrary.simpleMessage("From"),
    "priceHint": MessageLookupByLibrary.simpleMessage("Price"),
    "priceLabel": MessageLookupByLibrary.simpleMessage("Price"),
    "priceToHint": MessageLookupByLibrary.simpleMessage("To"),
    "pricesAndTicketsTitle": MessageLookupByLibrary.simpleMessage(
      "Prices and Tickets",
    ),
    "processingPayment": MessageLookupByLibrary.simpleMessage("Processing..."),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "promoCodeHint": MessageLookupByLibrary.simpleMessage("Promo code"),
    "promoCodeSuccess": MessageLookupByLibrary.simpleMessage(
      "Promo code applied!",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Password",
    ),
    "retryButton": MessageLookupByLibrary.simpleMessage("Retry"),
    "saveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "saveCardForLater": MessageLookupByLibrary.simpleMessage(
      "Save card for future payments",
    ),
    "savingChanges": MessageLookupByLibrary.simpleMessage("Saving changes..."),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seatBooked": MessageLookupByLibrary.simpleMessage("Booked"),
    "seatInHall": MessageLookupByLibrary.simpleMessage("Seat in hall"),
    "seatRowAndNumber": m8,
    "seatSelected": MessageLookupByLibrary.simpleMessage("Selected"),
    "seatTooltip": m9,
    "seatsAmountHint": MessageLookupByLibrary.simpleMessage("Seats (qty)"),
    "seatsNotSelected": MessageLookupByLibrary.simpleMessage(
      "Seats not selected",
    ),
    "seatsNotSelectedLabel": MessageLookupByLibrary.simpleMessage(
      "Seats not selected",
    ),
    "selectAtLeastOneSeat": MessageLookupByLibrary.simpleMessage(
      "Please select at least one seat",
    ),
    "select_city_title": MessageLookupByLibrary.simpleMessage("Select a city"),
    "selectedSeatsDescription": m10,
    "sendCodeButton": MessageLookupByLibrary.simpleMessage("Send Code"),
    "serviceFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Service fee (10%)",
    ),
    "showTicketToStaff": MessageLookupByLibrary.simpleMessage(
      "Show the ticket\nto our staff!",
    ),
    "signInButton": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInError": m11,
    "signInFailedError": MessageLookupByLibrary.simpleMessage(
      "Sign-in failed!",
    ),
    "signInSuccess": MessageLookupByLibrary.simpleMessage("Login successful!"),
    "signUpButton": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpError": m12,
    "signUpFailedError": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "signUpSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful!",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Sold Out"),
    "stageLabel": MessageLookupByLibrary.simpleMessage("STAGE"),
    "standardTicketName": MessageLookupByLibrary.simpleMessage("Standard"),
    "statusActive": MessageLookupByLibrary.simpleMessage("Active"),
    "statusInactive": MessageLookupByLibrary.simpleMessage("Inactive"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Status"),
    "ticketBookingTitle": MessageLookupByLibrary.simpleMessage(
      "Ticket Booking",
    ),
    "ticketCount": MessageLookupByLibrary.simpleMessage("Ticket count"),
    "ticketFiltersTitle": MessageLookupByLibrary.simpleMessage(
      "Ticket Filters",
    ),
    "ticketNameHint": MessageLookupByLibrary.simpleMessage(
      "Name (e.g. VIP, Standard)",
    ),
    "ticketStatusActive": MessageLookupByLibrary.simpleMessage("Active"),
    "ticketTypeStandard": MessageLookupByLibrary.simpleMessage("Standard"),
    "timeHint": MessageLookupByLibrary.simpleMessage("Time"),
    "timeLabel": MessageLookupByLibrary.simpleMessage("Time"),
    "timeRangeHint": MessageLookupByLibrary.simpleMessage("Time - Time"),
    "tokenRefreshFailedError": MessageLookupByLibrary.simpleMessage(
      "Failed to refresh token",
    ),
    "totalPriceLabel": MessageLookupByLibrary.simpleMessage("Total price"),
    "totalPriceWithCount": m13,
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred",
    ),
    "untitledEvent": MessageLookupByLibrary.simpleMessage("Untitled"),
    "uploadingPhoto": MessageLookupByLibrary.simpleMessage(
      "Uploading photo...",
    ),
    "userNotAuthorized": MessageLookupByLibrary.simpleMessage(
      "User not authorized",
    ),
    "usernameEmpty": MessageLookupByLibrary.simpleMessage("Enter username"),
    "usernameLabel": MessageLookupByLibrary.simpleMessage("Username"),
    "venueAddressHint": MessageLookupByLibrary.simpleMessage("Venue Address"),
    "venueLabel": MessageLookupByLibrary.simpleMessage("Venue"),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "yesLogoutButton": MessageLookupByLibrary.simpleMessage("Log Out"),
    "yourCards": MessageLookupByLibrary.simpleMessage("Your Cards"),
    "yourDataTitle": MessageLookupByLibrary.simpleMessage("Your Data"),
    "yourOrganizationTitle": MessageLookupByLibrary.simpleMessage(
      "Your Organization",
    ),
  };
}
