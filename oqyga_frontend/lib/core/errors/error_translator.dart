import 'package:flutter/material.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

String translateErrorMessage(BuildContext context, String messageKey) {
  final s = S.of(context);
  switch (messageKey) {
    case 'unexpectedError':
      return s.unexpectedError;
    case 'invalidCredentialsError':
      return s.invalidCredentialsError;
    case 'signInFailedError':
      return s.signInFailedError;
    case 'signUpFailedError':
      return s.signUpFailedError;
    case 'tokenRefreshFailedError':
      return s.tokenRefreshFailedError;
    case 'failedToSendOtp':
      return s.failedToSendOtp;
    case 'invalidOtp':
      return s.invalidOtp;
    case 'failedToResetPassword':
      return s.failedToResetPassword;
    case 'failedToLoadCities':
      return s.failedToLoadCities;
    case 'failedToLoadCategories':
      return s.failedToLoadCategories;
    case 'failedToLoadAgeRestrictions':
      return s.failedToLoadAgeRestrictions;
    case 'failedToLoadFilterOptions':
      return s.failedToLoadFilterOptions;
    case 'errorLoadingTickets':
      return s.errorLoadingTickets;
    case 'errorLoadingTicketDetails':
      return s.errorLoadingTicketDetails;
    case 'errorLoadingQrCode':
      return s.errorLoadingQrCode;
    case 'errorPurchasingTicket':
      return s.errorPurchasingTicket;
    case 'noTicketPriceInfo':
      return s.noTicketPriceInfo;
    case 'userNotAuthorized':
      return s.userNotAuthorized;
    case 'seatsNotSelected':
      return s.seatsNotSelected;
    case 'errorLoadingProfile':
      return s.errorLoadingProfile;
    case 'errorUpdatingProfile':
      return s.errorUpdatingProfile;
    case 'errorChangingPassword':
      return s.errorChangingPassword;
    case 'errorUploadingPhoto':
      return s.errorUploadingPhoto;
    case 'errorLoadingEvents':
      return s.errorLoadingEvents;
    case 'errorCreatingEvent':
      return s.errorCreatingEvent;
    case 'errorUpdatingEvent':
      return s.errorUpdatingEvent;
    case 'errorDeletingEvent':
      return s.errorDeletingEvent;
    case 'errorLoadingVenues':
      return s.errorLoadingVenues;
    case 'failedToGetCards':
      return s.failedToGetCards;
    case 'failedToCreatePaymentMethod':
      return s.failedToCreatePaymentMethod;
    case 'cardAddedSuccess':
      return s.cardAddedSuccess;
    case 'invalidDateFormat':
      return s.invalidDateFormat;
    case 'errorAddingCard':
      return s.errorAddingCard;

    // Статусные сообщения (не ошибки)
    case 'uploadingPhoto':
      return s.uploadingPhoto;
    case 'savingChanges':
      return s.savingChanges;
    case 'changingPassword':
      return s.changingPassword;
    case 'photoUpdatedSuccess':
      return s.photoUpdatedSuccess;
    case 'profileUpdatedSuccess':
      return s.profileUpdatedSuccess;
    case 'passwordChangedSuccess':
      return s.passwordChangedSuccess;

    default:
      return messageKey;
  }
}
