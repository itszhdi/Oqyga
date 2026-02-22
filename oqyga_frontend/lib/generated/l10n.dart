// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username`
  String get usernameLabel {
    return Intl.message('Username', name: 'usernameLabel', desc: '', args: []);
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButton {
    return Intl.message('Sign In', name: 'signInButton', desc: '', args: []);
  }

  /// `No account?`
  String get noAccountLink {
    return Intl.message(
      'No account?',
      name: 'noAccountLink',
      desc: '',
      args: [],
    );
  }

  /// `Enter {field}`
  String emptyError(Object field) {
    return Intl.message(
      'Enter $field',
      name: 'emptyError',
      desc: '',
      args: [field],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordError {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get phoneEmpty {
    return Intl.message(
      'Enter phone number',
      name: 'phoneEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Format: +77001234567`
  String get phoneFormat {
    return Intl.message(
      'Format: +77001234567',
      name: 'phoneFormat',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get passwordEmpty {
    return Intl.message(
      'Enter password',
      name: 'passwordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordLength {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordLength',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneLabel {
    return Intl.message('Phone number', name: 'phoneLabel', desc: '', args: []);
  }

  /// `+77001234567`
  String get phoneHint {
    return Intl.message('+77001234567', name: 'phoneHint', desc: '', args: []);
  }

  /// `Confirm password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatchError',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpButton {
    return Intl.message('Sign Up', name: 'signUpButton', desc: '', args: []);
  }

  /// `Already have an account?`
  String get alreadyHaveAccountLink {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccountLink',
      desc: '',
      args: [],
    );
  }

  /// `Enter username`
  String get usernameEmpty {
    return Intl.message(
      'Enter username',
      name: 'usernameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmPasswordEmpty {
    return Intl.message(
      'Confirm your password',
      name: 'confirmPasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Sign-up error: {errorMessage}`
  String signUpError(String errorMessage) {
    return Intl.message(
      'Sign-up error: $errorMessage',
      name: 'signUpError',
      desc: 'Error message shown on sign-up failure',
      args: [errorMessage],
    );
  }

  /// `Registration successful!`
  String get signUpSuccess {
    return Intl.message(
      'Registration successful!',
      name: 'signUpSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in error: {errorMessage}`
  String signInError(String errorMessage) {
    return Intl.message(
      'Sign-in error: $errorMessage',
      name: 'signInError',
      desc: 'Error message shown on sign-in failure',
      args: [errorMessage],
    );
  }

  /// `Login successful!`
  String get signInSuccess {
    return Intl.message(
      'Login successful!',
      name: 'signInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password`
  String get invalidCredentialsError {
    return Intl.message(
      'Invalid username or password',
      name: 'invalidCredentialsError',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in failed!`
  String get signInFailedError {
    return Intl.message(
      'Sign-in failed!',
      name: 'signInFailedError',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get signUpFailedError {
    return Intl.message(
      'Registration failed',
      name: 'signUpFailedError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to refresh token`
  String get tokenRefreshFailedError {
    return Intl.message(
      'Failed to refresh token',
      name: 'tokenRefreshFailedError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get events`
  String get failedToGetEvents {
    return Intl.message(
      'Failed to get events',
      name: 'failedToGetEvents',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get networkError {
    return Intl.message(
      'Network error',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get event`
  String get failedToGetEvent {
    return Intl.message(
      'Failed to get event',
      name: 'failedToGetEvent',
      desc: '',
      args: [],
    );
  }

  /// `Error loading your events`
  String get failedToLoadMyEvents {
    return Intl.message(
      'Error loading your events',
      name: 'failedToLoadMyEvents',
      desc: '',
      args: [],
    );
  }

  /// `Untitled`
  String get untitledEvent {
    return Intl.message('Untitled', name: 'untitledEvent', desc: '', args: []);
  }

  /// `No description`
  String get noDescription {
    return Intl.message(
      'No description',
      name: 'noDescription',
      desc: '',
      args: [],
    );
  }

  /// `Address not specified`
  String get addressNotSpecified {
    return Intl.message(
      'Address not specified',
      name: 'addressNotSpecified',
      desc: '',
      args: [],
    );
  }

  /// `City not specified`
  String get cityNotSpecified {
    return Intl.message(
      'City not specified',
      name: 'cityNotSpecified',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get ticketTypeStandard {
    return Intl.message(
      'Standard',
      name: 'ticketTypeStandard',
      desc: '',
      args: [],
    );
  }

  /// `Invalid event ID`
  String get invalidEventId {
    return Intl.message(
      'Invalid event ID',
      name: 'invalidEventId',
      desc: '',
      args: [],
    );
  }

  /// `Error: `
  String get errorPrefix {
    return Intl.message('Error: ', name: 'errorPrefix', desc: '', args: []);
  }

  /// `Event not found`
  String get eventNotFound {
    return Intl.message(
      'Event not found',
      name: 'eventNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Buy Ticket`
  String get buyTicket {
    return Intl.message('Buy Ticket', name: 'buyTicket', desc: '', args: []);
  }

  /// `Event has passed`
  String get eventHasPassed {
    return Intl.message(
      'Event has passed',
      name: 'eventHasPassed',
      desc: '',
      args: [],
    );
  }

  /// `Sold Out`
  String get soldOut {
    return Intl.message('Sold Out', name: 'soldOut', desc: '', args: []);
  }

  /// `Find your event`
  String get findYourEvent {
    return Intl.message(
      'Find your event',
      name: 'findYourEvent',
      desc: '',
      args: [],
    );
  }

  /// `Error loading events!`
  String get errorLoadingEvents {
    return Intl.message(
      'Error loading events!',
      name: 'errorLoadingEvents',
      desc: '',
      args: [],
    );
  }

  /// `No events found for your request`
  String get noEventsFoundForQuery {
    return Intl.message(
      'No events found for your request',
      name: 'noEventsFoundForQuery',
      desc: '',
      args: [],
    );
  }

  /// `The event list is empty`
  String get eventListIsEmpty {
    return Intl.message(
      'The event list is empty',
      name: 'eventListIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load cities`
  String get failedToLoadCities {
    return Intl.message(
      'Failed to load cities',
      name: 'failedToLoadCities',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load categories`
  String get failedToLoadCategories {
    return Intl.message(
      'Failed to load categories',
      name: 'failedToLoadCategories',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load age restrictions`
  String get failedToLoadAgeRestrictions {
    return Intl.message(
      'Failed to load age restrictions',
      name: 'failedToLoadAgeRestrictions',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load filter options`
  String get failedToLoadFilterOptions {
    return Intl.message(
      'Failed to load filter options',
      name: 'failedToLoadFilterOptions',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get priceLabel {
    return Intl.message('Price', name: 'priceLabel', desc: '', args: []);
  }

  /// `From`
  String get priceFromHint {
    return Intl.message('From', name: 'priceFromHint', desc: '', args: []);
  }

  /// `To`
  String get priceToHint {
    return Intl.message('To', name: 'priceToHint', desc: '', args: []);
  }

  /// `City`
  String get cityLabel {
    return Intl.message('City', name: 'cityLabel', desc: '', args: []);
  }

  /// `Time`
  String get timeLabel {
    return Intl.message('Time', name: 'timeLabel', desc: '', args: []);
  }

  /// `Date - Date`
  String get dateRangeHint {
    return Intl.message(
      'Date - Date',
      name: 'dateRangeHint',
      desc: '',
      args: [],
    );
  }

  /// `Time - Time`
  String get timeRangeHint {
    return Intl.message(
      'Time - Time',
      name: 'timeRangeHint',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filterButtonText {
    return Intl.message('Filter', name: 'filterButtonText', desc: '', args: []);
  }

  /// `Retry`
  String get retryButton {
    return Intl.message('Retry', name: 'retryButton', desc: '', args: []);
  }

  /// `Event Filters`
  String get eventFiltersTitle {
    return Intl.message(
      'Event Filters',
      name: 'eventFiltersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get categoryLabel {
    return Intl.message('Category', name: 'categoryLabel', desc: '', args: []);
  }

  /// `Age Restriction`
  String get ageRestrictionLabel {
    return Intl.message(
      'Age Restriction',
      name: 'ageRestrictionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Organizer Filters`
  String get organizerFiltersTitle {
    return Intl.message(
      'Organizer Filters',
      name: 'organizerFiltersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Venue`
  String get venueLabel {
    return Intl.message('Venue', name: 'venueLabel', desc: '', args: []);
  }

  /// `Ticket Filters`
  String get ticketFiltersTitle {
    return Intl.message(
      'Ticket Filters',
      name: 'ticketFiltersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get statusLabel {
    return Intl.message('Status', name: 'statusLabel', desc: '', args: []);
  }

  /// `Active`
  String get statusActive {
    return Intl.message('Active', name: 'statusActive', desc: '', args: []);
  }

  /// `Inactive`
  String get statusInactive {
    return Intl.message('Inactive', name: 'statusInactive', desc: '', args: []);
  }

  /// `Failed to send code`
  String get failedToSendOtp {
    return Intl.message(
      'Failed to send code',
      name: 'failedToSendOtp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidOtp {
    return Intl.message('Invalid code', name: 'invalidOtp', desc: '', args: []);
  }

  /// `Failed to reset password`
  String get failedToResetPassword {
    return Intl.message(
      'Failed to reset password',
      name: 'failedToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password successfully changed!`
  String get passwordResetSuccess {
    return Intl.message(
      'Password successfully changed!',
      name: 'passwordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number to receive a verification code.`
  String get enterPhoneToResetDescription {
    return Intl.message(
      'Enter your phone number to receive a verification code.',
      name: 'enterPhoneToResetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCodeButton {
    return Intl.message(
      'Send Code',
      name: 'sendCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `Field cannot be empty`
  String get fieldCannotBeEmpty {
    return Intl.message(
      'Field cannot be empty',
      name: 'fieldCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `We sent a code to {phoneNumber}.\nEnter it below.`
  String otpSentDescription(String phoneNumber) {
    return Intl.message(
      'We sent a code to $phoneNumber.\nEnter it below.',
      name: 'otpSentDescription',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `Verification code`
  String get otpLabel {
    return Intl.message(
      'Verification code',
      name: 'otpLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter code`
  String get enterOtpError {
    return Intl.message(
      'Enter code',
      name: 'enterOtpError',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmButton {
    return Intl.message('Confirm', name: 'confirmButton', desc: '', args: []);
  }

  /// `New Password`
  String get newPasswordTitle {
    return Intl.message(
      'New Password',
      name: 'newPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enterNewPasswordDescription {
    return Intl.message(
      'Enter your new password',
      name: 'enterNewPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message('Save', name: 'saveButton', desc: '', args: []);
  }

  /// `Error loading tickets`
  String get errorLoadingTickets {
    return Intl.message(
      'Error loading tickets',
      name: 'errorLoadingTickets',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load ticket details`
  String get errorLoadingTicketDetails {
    return Intl.message(
      'Failed to load ticket details',
      name: 'errorLoadingTicketDetails',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load QR code`
  String get errorLoadingQrCode {
    return Intl.message(
      'Failed to load QR code',
      name: 'errorLoadingQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Error purchasing ticket`
  String get errorPurchasingTicket {
    return Intl.message(
      'Error purchasing ticket',
      name: 'errorPurchasingTicket',
      desc: '',
      args: [],
    );
  }

  /// `No ticket price information`
  String get noTicketPriceInfo {
    return Intl.message(
      'No ticket price information',
      name: 'noTicketPriceInfo',
      desc: '',
      args: [],
    );
  }

  /// `User not authorized`
  String get userNotAuthorized {
    return Intl.message(
      'User not authorized',
      name: 'userNotAuthorized',
      desc: '',
      args: [],
    );
  }

  /// `Seats not selected`
  String get seatsNotSelected {
    return Intl.message(
      'Seats not selected',
      name: 'seatsNotSelected',
      desc: '',
      args: [],
    );
  }

  /// `Poster\nnot found`
  String get posterNotFound {
    return Intl.message(
      'Poster\nnot found',
      name: 'posterNotFound',
      desc: '',
      args: [],
    );
  }

  /// `STAGE`
  String get stageLabel {
    return Intl.message('STAGE', name: 'stageLabel', desc: '', args: []);
  }

  /// `Selected`
  String get seatSelected {
    return Intl.message('Selected', name: 'seatSelected', desc: '', args: []);
  }

  /// `Booked`
  String get seatBooked {
    return Intl.message('Booked', name: 'seatBooked', desc: '', args: []);
  }

  /// `Row: {row}, Seat: {number}, Price: {price} ₸`
  String seatTooltip(int row, int number, double price) {
    return Intl.message(
      'Row: $row, Seat: $number, Price: $price ₸',
      name: 'seatTooltip',
      desc: '',
      args: [row, number, price],
    );
  }

  /// `Seat in hall`
  String get seatInHall {
    return Intl.message('Seat in hall', name: 'seatInHall', desc: '', args: []);
  }

  /// `Ticket count`
  String get ticketCount {
    return Intl.message(
      'Ticket count',
      name: 'ticketCount',
      desc: '',
      args: [],
    );
  }

  /// `Show the ticket\nto our staff!`
  String get showTicketToStaff {
    return Intl.message(
      'Show the ticket\nto our staff!',
      name: 'showTicketToStaff',
      desc: '',
      args: [],
    );
  }

  /// `My Ticket`
  String get myTicketTitle {
    return Intl.message('My Ticket', name: 'myTicketTitle', desc: '', args: []);
  }

  /// `My Tickets`
  String get myTicketsTitle {
    return Intl.message(
      'My Tickets',
      name: 'myTicketsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No tickets found for your request`
  String get noTicketsFound {
    return Intl.message(
      'No tickets found for your request',
      name: 'noTicketsFound',
      desc: '',
      args: [],
    );
  }

  /// `You have no purchased tickets yet`
  String get noTicketsYet {
    return Intl.message(
      'You have no purchased tickets yet',
      name: 'noTicketsYet',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get ticketStatusActive {
    return Intl.message(
      'Active',
      name: 'ticketStatusActive',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processingPayment {
    return Intl.message(
      'Processing...',
      name: 'processingPayment',
      desc: '',
      args: [],
    );
  }

  /// `Pay {amount} ₸`
  String payButton(String amount) {
    return Intl.message(
      'Pay $amount ₸',
      name: 'payButton',
      desc: '',
      args: [amount],
    );
  }

  /// `Please select a payment method`
  String get choosePaymentMethod {
    return Intl.message(
      'Please select a payment method',
      name: 'choosePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Service fee (10%)`
  String get serviceFeeLabel {
    return Intl.message(
      'Service fee (10%)',
      name: 'serviceFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total price`
  String get totalPriceLabel {
    return Intl.message(
      'Total price',
      name: 'totalPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Seats not selected`
  String get seatsNotSelectedLabel {
    return Intl.message(
      'Seats not selected',
      name: 'seatsNotSelectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Row {row}, Seat {number}`
  String seatRowAndNumber(int row, int number) {
    return Intl.message(
      'Row $row, Seat $number',
      name: 'seatRowAndNumber',
      desc: '',
      args: [row, number],
    );
  }

  /// `Ticket Booking`
  String get ticketBookingTitle {
    return Intl.message(
      'Ticket Booking',
      name: 'ticketBookingTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count} ticket(s): row {row}, seat {number}...`
  String selectedSeatsDescription(int count, int row, int number) {
    return Intl.message(
      '$count ticket(s): row $row, seat $number...',
      name: 'selectedSeatsDescription',
      desc: '',
      args: [count, row, number],
    );
  }

  /// `{count} ticket(s): {amount} ₸`
  String totalPriceWithCount(int count, String amount) {
    return Intl.message(
      '$count ticket(s): $amount ₸',
      name: 'totalPriceWithCount',
      desc: '',
      args: [count, amount],
    );
  }

  /// `Checkout`
  String get checkoutButton {
    return Intl.message('Checkout', name: 'checkoutButton', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Please select at least one seat`
  String get selectAtLeastOneSeat {
    return Intl.message(
      'Please select at least one seat',
      name: 'selectAtLeastOneSeat',
      desc: '',
      args: [],
    );
  }

  /// `No data to display ticket.`
  String get noDataForTicket {
    return Intl.message(
      'No data to display ticket.',
      name: 'noDataForTicket',
      desc: '',
      args: [],
    );
  }

  /// `Error loading profile`
  String get errorLoadingProfile {
    return Intl.message(
      'Error loading profile',
      name: 'errorLoadingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get errorUpdatingProfile {
    return Intl.message(
      'Error updating profile',
      name: 'errorUpdatingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Failed to change password`
  String get errorChangingPassword {
    return Intl.message(
      'Failed to change password',
      name: 'errorChangingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload photo`
  String get errorUploadingPhoto {
    return Intl.message(
      'Failed to upload photo',
      name: 'errorUploadingPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Error uploading photo: {reason}`
  String errorUploadingPhotoWithReason(String reason) {
    return Intl.message(
      'Error uploading photo: $reason',
      name: 'errorUploadingPhotoWithReason',
      desc: '',
      args: [reason],
    );
  }

  /// `Uploading photo...`
  String get uploadingPhoto {
    return Intl.message(
      'Uploading photo...',
      name: 'uploadingPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Saving changes...`
  String get savingChanges {
    return Intl.message(
      'Saving changes...',
      name: 'savingChanges',
      desc: '',
      args: [],
    );
  }

  /// `Changing password...`
  String get changingPassword {
    return Intl.message(
      'Changing password...',
      name: 'changingPassword',
      desc: '',
      args: [],
    );
  }

  /// `Photo updated successfully`
  String get photoUpdatedSuccess {
    return Intl.message(
      'Photo updated successfully',
      name: 'photoUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Your Data`
  String get yourDataTitle {
    return Intl.message('Your Data', name: 'yourDataTitle', desc: '', args: []);
  }

  /// `Edit`
  String get editProfileTitle {
    return Intl.message('Edit', name: 'editProfileTitle', desc: '', args: []);
  }

  /// `Change Password`
  String get changePasswordTitle {
    return Intl.message(
      'Change Password',
      name: 'changePasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logoutButton {
    return Intl.message('Log Out', name: 'logoutButton', desc: '', args: []);
  }

  /// `Do you really want to log out?`
  String get logoutDialogTitle {
    return Intl.message(
      'Do you really want to log out?',
      name: 'logoutDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get noButton {
    return Intl.message('No', name: 'noButton', desc: '', args: []);
  }

  /// `Log Out`
  String get yesLogoutButton {
    return Intl.message('Log Out', name: 'yesLogoutButton', desc: '', args: []);
  }

  /// `Change Photo`
  String get changePhotoLabel {
    return Intl.message(
      'Change Photo',
      name: 'changePhotoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Not specified`
  String get notSpecified {
    return Intl.message(
      'Not specified',
      name: 'notSpecified',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethodsTitle {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethodsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Cards`
  String get yourCards {
    return Intl.message('Your Cards', name: 'yourCards', desc: '', args: []);
  }

  /// `App Language`
  String get appLanguageTitle {
    return Intl.message(
      'App Language',
      name: 'appLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get emailLabel {
    return Intl.message('E-mail', name: 'emailLabel', desc: '', args: []);
  }

  /// `Current Password`
  String get currentPasswordLabel {
    return Intl.message(
      'Current Password',
      name: 'currentPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Error creating event`
  String get errorCreatingEvent {
    return Intl.message(
      'Error creating event',
      name: 'errorCreatingEvent',
      desc: '',
      args: [],
    );
  }

  /// `Error updating event`
  String get errorUpdatingEvent {
    return Intl.message(
      'Error updating event',
      name: 'errorUpdatingEvent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete event`
  String get errorDeletingEvent {
    return Intl.message(
      'Failed to delete event',
      name: 'errorDeletingEvent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load venues list`
  String get errorLoadingVenues {
    return Intl.message(
      'Failed to load venues list',
      name: 'errorLoadingVenues',
      desc: '',
      args: [],
    );
  }

  /// `Add Event`
  String get addEventTitle {
    return Intl.message('Add Event', name: 'addEventTitle', desc: '', args: []);
  }

  /// `Edit Event`
  String get editEventTitle {
    return Intl.message(
      'Edit Event',
      name: 'editEventTitle',
      desc: '',
      args: [],
    );
  }

  /// `Event successfully created!`
  String get eventCreatedSuccess {
    return Intl.message(
      'Event successfully created!',
      name: 'eventCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Event successfully updated!`
  String get eventUpdatedSuccess {
    return Intl.message(
      'Event successfully updated!',
      name: 'eventUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Organizer`
  String get organizerTitle {
    return Intl.message(
      'Organizer',
      name: 'organizerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your Organization`
  String get yourOrganizationTitle {
    return Intl.message(
      'Your Organization',
      name: 'yourOrganizationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Organization Name`
  String get organizationNameLabel {
    return Intl.message(
      'Organization Name',
      name: 'organizationNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 5 price categories`
  String get maxTicketCategoriesError {
    return Intl.message(
      'Maximum 5 price categories',
      name: 'maxTicketCategoriesError',
      desc: '',
      args: [],
    );
  }

  /// `Add a poster and fill in the title`
  String get addPosterAndTitleError {
    return Intl.message(
      'Add a poster and fill in the title',
      name: 'addPosterAndTitleError',
      desc: '',
      args: [],
    );
  }

  /// `Fill in data for all ticket categories`
  String get fillAllTicketDataError {
    return Intl.message(
      'Fill in data for all ticket categories',
      name: 'fillAllTicketDataError',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basicInfoTitle {
    return Intl.message(
      'Basic Information',
      name: 'basicInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Event Name`
  String get eventNameHint {
    return Intl.message(
      'Event Name',
      name: 'eventNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dateHint {
    return Intl.message('Date', name: 'dateHint', desc: '', args: []);
  }

  /// `Time`
  String get timeHint {
    return Intl.message('Time', name: 'timeHint', desc: '', args: []);
  }

  /// `Choose City`
  String get chooseCityHint {
    return Intl.message(
      'Choose City',
      name: 'chooseCityHint',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get categoryHint {
    return Intl.message('Category', name: 'categoryHint', desc: '', args: []);
  }

  /// `Venue Address`
  String get venueAddressHint {
    return Intl.message(
      'Venue Address',
      name: 'venueAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Prices and Tickets`
  String get pricesAndTicketsTitle {
    return Intl.message(
      'Prices and Tickets',
      name: 'pricesAndTicketsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name (e.g. VIP, Standard)`
  String get ticketNameHint {
    return Intl.message(
      'Name (e.g. VIP, Standard)',
      name: 'ticketNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Delete Category`
  String get deleteCategoryTooltip {
    return Intl.message(
      'Delete Category',
      name: 'deleteCategoryTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get priceHint {
    return Intl.message('Price', name: 'priceHint', desc: '', args: []);
  }

  /// `Seats (qty)`
  String get seatsAmountHint {
    return Intl.message(
      'Seats (qty)',
      name: 'seatsAmountHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Price Category`
  String get addPriceCategoryButton {
    return Intl.message(
      'Add Price Category',
      name: 'addPriceCategoryButton',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get standardTicketName {
    return Intl.message(
      'Standard',
      name: 'standardTicketName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionTitle {
    return Intl.message(
      'Description',
      name: 'descriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tell about the event...`
  String get eventDescriptionHint {
    return Intl.message(
      'Tell about the event...',
      name: 'eventDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `My Events`
  String get myEventsTitle {
    return Intl.message('My Events', name: 'myEventsTitle', desc: '', args: []);
  }

  /// `No events found for your request`
  String get noEventsFound {
    return Intl.message(
      'No events found for your request',
      name: 'noEventsFound',
      desc: '',
      args: [],
    );
  }

  /// `You haven't created any events yet`
  String get noCreatedEvents {
    return Intl.message(
      'You haven\'t created any events yet',
      name: 'noCreatedEvents',
      desc: '',
      args: [],
    );
  }

  /// `Delete Confirmation`
  String get deleteConfirmationTitle {
    return Intl.message(
      'Delete Confirmation',
      name: 'deleteConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete "{itemName}"?`
  String deleteEventConfirmation(String itemName) {
    return Intl.message(
      'Do you really want to delete "$itemName"?',
      name: 'deleteEventConfirmation',
      desc: '',
      args: [itemName],
    );
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message('Delete', name: 'deleteButton', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton', desc: '', args: []);
  }

  /// `Change Poster`
  String get changePoster {
    return Intl.message(
      'Change Poster',
      name: 'changePoster',
      desc: '',
      args: [],
    );
  }

  /// `Add Poster`
  String get addPoster {
    return Intl.message('Add Poster', name: 'addPoster', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Choose language`
  String get chooseLanguage {
    return Intl.message(
      'Choose language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get cards`
  String get failedToGetCards {
    return Intl.message(
      'Failed to get cards',
      name: 'failedToGetCards',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create payment method`
  String get failedToCreatePaymentMethod {
    return Intl.message(
      'Failed to create payment method',
      name: 'failedToCreatePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `My Cards`
  String get myCards {
    return Intl.message('My Cards', name: 'myCards', desc: '', args: []);
  }

  /// `New Card`
  String get newCard {
    return Intl.message('New Card', name: 'newCard', desc: '', args: []);
  }

  /// `Card added successfully`
  String get cardAddedSuccess {
    return Intl.message(
      'Card added successfully',
      name: 'cardAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date format`
  String get invalidDateFormat {
    return Intl.message(
      'Invalid date format',
      name: 'invalidDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Error adding card`
  String get errorAddingCard {
    return Intl.message(
      'Error adding card',
      name: 'errorAddingCard',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumberLabel {
    return Intl.message(
      'Card Number',
      name: 'cardNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `0000 0000 0000 0000`
  String get cardNumberHint {
    return Intl.message(
      '0000 0000 0000 0000',
      name: 'cardNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date (MM/YY)`
  String get expiryDateLabel {
    return Intl.message(
      'Expiry Date (MM/YY)',
      name: 'expiryDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvvLabel {
    return Intl.message('CVV', name: 'cvvLabel', desc: '', args: []);
  }

  /// `Link Card`
  String get linkCard {
    return Intl.message('Link Card', name: 'linkCard', desc: '', args: []);
  }

  /// `Enter Card Number`
  String get enterCardNumber {
    return Intl.message(
      'Enter Card Number',
      name: 'enterCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Card number is too short`
  String get cardNumberTooShort {
    return Intl.message(
      'Card number is too short',
      name: 'cardNumberTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Invalid card number`
  String get invalidCardNumber {
    return Intl.message(
      'Invalid card number',
      name: 'invalidCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get fieldRequired {
    return Intl.message(
      'Field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format`
  String get invalidFormat {
    return Intl.message(
      'Invalid format',
      name: 'invalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Invalid CVV`
  String get invalidCvv {
    return Intl.message('Invalid CVV', name: 'invalidCvv', desc: '', args: []);
  }

  /// `Cards`
  String get cardsTitle {
    return Intl.message('Cards', name: 'cardsTitle', desc: '', args: []);
  }

  /// `No saved cards`
  String get noSavedCards {
    return Intl.message(
      'No saved cards',
      name: 'noSavedCards',
      desc: '',
      args: [],
    );
  }

  /// `New card (one-time)`
  String get oneTimeCard {
    return Intl.message(
      'New card (one-time)',
      name: 'oneTimeCard',
      desc: '',
      args: [],
    );
  }

  /// `Add card`
  String get addCard {
    return Intl.message('Add card', name: 'addCard', desc: '', args: []);
  }

  /// `Save card for future payments`
  String get saveCardForLater {
    return Intl.message(
      'Save card for future payments',
      name: 'saveCardForLater',
      desc: '',
      args: [],
    );
  }

  /// `Is your city {cityName}?`
  String confirm_city_title(Object cityName) {
    return Intl.message(
      'Is your city $cityName?',
      name: 'confirm_city_title',
      desc: '',
      args: [cityName],
    );
  }

  /// `Show events in this city?`
  String get confirm_city_content {
    return Intl.message(
      'Show events in this city?',
      name: 'confirm_city_content',
      desc: '',
      args: [],
    );
  }

  /// `Select a city`
  String get select_city_title {
    return Intl.message(
      'Select a city',
      name: 'select_city_title',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Go to`
  String get go_to_event {
    return Intl.message('Go to', name: 'go_to_event', desc: '', args: []);
  }

  /// `Enter promo code`
  String get enterPromoCodeTitle {
    return Intl.message(
      'Enter promo code',
      name: 'enterPromoCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Promo code`
  String get promoCodeHint {
    return Intl.message(
      'Promo code',
      name: 'promoCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get applyButton {
    return Intl.message('Apply', name: 'applyButton', desc: '', args: []);
  }

  /// `Enter promo code`
  String get enterPromoCodeButton {
    return Intl.message(
      'Enter promo code',
      name: 'enterPromoCodeButton',
      desc: '',
      args: [],
    );
  }

  /// `Promo code: {code}`
  String appliedPromoCodeLabel(Object code) {
    return Intl.message(
      'Promo code: $code',
      name: 'appliedPromoCodeLabel',
      desc: '',
      args: [code],
    );
  }

  /// `Promo code applied!`
  String get promoCodeSuccess {
    return Intl.message(
      'Promo code applied!',
      name: 'promoCodeSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Discount ({percent}%)`
  String discountLabel(Object percent) {
    return Intl.message(
      'Discount ($percent%)',
      name: 'discountLabel',
      desc: '',
      args: [percent],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
