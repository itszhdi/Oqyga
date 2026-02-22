// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(code) => "Промокод: ${code}";

  static String m1(cityName) => "Ваш город ${cityName}?";

  static String m2(itemName) =>
      "Вы действительно хотите удалить мероприятие \"${itemName}\"?";

  static String m3(percent) => "Скидка (${percent}%)";

  static String m4(field) => "Введите ${field}";

  static String m5(reason) => "Ошибка загрузки фото: ${reason}";

  static String m6(phoneNumber) =>
      "Мы отправили код на номер ${phoneNumber}.\nВведите его ниже.";

  static String m7(amount) => "Оплатить ${amount} ₸";

  static String m8(row, number) => "Ряд ${row}, Место ${number}";

  static String m9(row, number, price) =>
      "Ряд: ${row}, Место: ${number}, Цена: ${price} тг";

  static String m10(count, row, number) =>
      "${count} билет(ов): ${row} ряд, ${number} место...";

  static String m11(errorMessage) => "Ошибка входа: ${errorMessage}";

  static String m12(errorMessage) => "Ошибка регистрации: ${errorMessage}";

  static String m13(count, amount) => "${count} билет(ов): ${amount} тг";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addCard": MessageLookupByLibrary.simpleMessage("Добавить карту"),
    "addEventTitle": MessageLookupByLibrary.simpleMessage(
      "Добавить мероприятие",
    ),
    "addPoster": MessageLookupByLibrary.simpleMessage("Добавить афишу"),
    "addPosterAndTitleError": MessageLookupByLibrary.simpleMessage(
      "Добавьте афишу и заполните название",
    ),
    "addPriceCategoryButton": MessageLookupByLibrary.simpleMessage(
      "Добавить категорию цен",
    ),
    "addressNotSpecified": MessageLookupByLibrary.simpleMessage(
      "Адрес не указан",
    ),
    "ageRestrictionLabel": MessageLookupByLibrary.simpleMessage(
      "Возрастное ограничение",
    ),
    "alreadyHaveAccountLink": MessageLookupByLibrary.simpleMessage(
      "Уже есть аккаунт?",
    ),
    "appLanguageTitle": MessageLookupByLibrary.simpleMessage("Язык приложения"),
    "appliedPromoCodeLabel": m0,
    "applyButton": MessageLookupByLibrary.simpleMessage("Применить"),
    "basicInfoTitle": MessageLookupByLibrary.simpleMessage(
      "Основная информация",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Купить билет"),
    "cancelButton": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cardAddedSuccess": MessageLookupByLibrary.simpleMessage(
      "Карта успешно добавлена",
    ),
    "cardNumberHint": MessageLookupByLibrary.simpleMessage(
      "0000 0000 0000 0000",
    ),
    "cardNumberLabel": MessageLookupByLibrary.simpleMessage("Номер карты"),
    "cardNumberTooShort": MessageLookupByLibrary.simpleMessage(
      "Номер карты слишком короткий",
    ),
    "cardsTitle": MessageLookupByLibrary.simpleMessage("Карты"),
    "categoryHint": MessageLookupByLibrary.simpleMessage("Категория"),
    "categoryLabel": MessageLookupByLibrary.simpleMessage("Категория"),
    "changePasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Сменить пароль",
    ),
    "changePhotoLabel": MessageLookupByLibrary.simpleMessage("Изменить фото"),
    "changePoster": MessageLookupByLibrary.simpleMessage("Изменить афишу"),
    "changingPassword": MessageLookupByLibrary.simpleMessage("Смена пароля..."),
    "checkoutButton": MessageLookupByLibrary.simpleMessage("Оформить"),
    "chooseCityHint": MessageLookupByLibrary.simpleMessage("Выберите город"),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("Выберите язык"),
    "choosePaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите способ оплаты",
    ),
    "cityLabel": MessageLookupByLibrary.simpleMessage("Город"),
    "cityNotSpecified": MessageLookupByLibrary.simpleMessage("Город не указан"),
    "confirmButton": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirmPasswordEmpty": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirm_city_content": MessageLookupByLibrary.simpleMessage(
      "Показать мероприятия в этом городе?",
    ),
    "confirm_city_title": m1,
    "currentPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Текущий пароль",
    ),
    "cvvLabel": MessageLookupByLibrary.simpleMessage("CVV"),
    "dateHint": MessageLookupByLibrary.simpleMessage("Дата"),
    "dateRangeHint": MessageLookupByLibrary.simpleMessage("Дата - Дата"),
    "deleteButton": MessageLookupByLibrary.simpleMessage("Удалить"),
    "deleteCategoryTooltip": MessageLookupByLibrary.simpleMessage(
      "Удалить категорию",
    ),
    "deleteConfirmationTitle": MessageLookupByLibrary.simpleMessage(
      "Подтверждение удаления",
    ),
    "deleteEventConfirmation": m2,
    "descriptionTitle": MessageLookupByLibrary.simpleMessage("Описание"),
    "discountLabel": m3,
    "editEventTitle": MessageLookupByLibrary.simpleMessage(
      "Изменить мероприятие",
    ),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage("Изменить"),
    "emailLabel": MessageLookupByLibrary.simpleMessage("Почта"),
    "emptyError": m4,
    "enterCardNumber": MessageLookupByLibrary.simpleMessage(
      "Введите номер карты",
    ),
    "enterNewPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Введите ваш новый пароль",
    ),
    "enterOtpError": MessageLookupByLibrary.simpleMessage("Введите код"),
    "enterPhoneToResetDescription": MessageLookupByLibrary.simpleMessage(
      "Введите ваш номер телефона, чтобы получить код подтверждения.",
    ),
    "enterPromoCodeButton": MessageLookupByLibrary.simpleMessage(
      "Ввести промокод",
    ),
    "enterPromoCodeTitle": MessageLookupByLibrary.simpleMessage(
      "Введите промокод",
    ),
    "errorAddingCard": MessageLookupByLibrary.simpleMessage(
      "Ошибка при добавлении карты",
    ),
    "errorChangingPassword": MessageLookupByLibrary.simpleMessage(
      "Не удалось сменить пароль",
    ),
    "errorCreatingEvent": MessageLookupByLibrary.simpleMessage(
      "Ошибка при создании мероприятия",
    ),
    "errorDeletingEvent": MessageLookupByLibrary.simpleMessage(
      "Не удалось удалить мероприятие",
    ),
    "errorLoadingEvents": MessageLookupByLibrary.simpleMessage(
      "Ошибка при загрузке мероприятий!",
    ),
    "errorLoadingProfile": MessageLookupByLibrary.simpleMessage(
      "Ошибка загрузки профиля",
    ),
    "errorLoadingQrCode": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить QR-код",
    ),
    "errorLoadingTicketDetails": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить детали билета",
    ),
    "errorLoadingTickets": MessageLookupByLibrary.simpleMessage(
      "Ошибка загрузки билетов",
    ),
    "errorLoadingVenues": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить список мест",
    ),
    "errorPrefix": MessageLookupByLibrary.simpleMessage("Ошибка: "),
    "errorPurchasingTicket": MessageLookupByLibrary.simpleMessage(
      "Ошибка покупки билета",
    ),
    "errorUpdatingEvent": MessageLookupByLibrary.simpleMessage(
      "Ошибка при обновлении мероприятия",
    ),
    "errorUpdatingProfile": MessageLookupByLibrary.simpleMessage(
      "Ошибка обновления профиля",
    ),
    "errorUploadingPhoto": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить фото",
    ),
    "errorUploadingPhotoWithReason": m5,
    "eventCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Мероприятие успешно создано!",
    ),
    "eventDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Расскажите о мероприятии...",
    ),
    "eventFiltersTitle": MessageLookupByLibrary.simpleMessage(
      "Фильтры событий",
    ),
    "eventHasPassed": MessageLookupByLibrary.simpleMessage(
      "Мероприятие прошло",
    ),
    "eventListIsEmpty": MessageLookupByLibrary.simpleMessage(
      "Список мероприятий пуст",
    ),
    "eventNameHint": MessageLookupByLibrary.simpleMessage(
      "Название мероприятия",
    ),
    "eventNotFound": MessageLookupByLibrary.simpleMessage(
      "Мероприятие не найдено",
    ),
    "eventUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Мероприятие успешно обновлено!",
    ),
    "expiryDateLabel": MessageLookupByLibrary.simpleMessage(
      "Срок действия (MM/YY)",
    ),
    "failedToCreatePaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Не удалось добавить карту",
    ),
    "failedToGetCards": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить карты",
    ),
    "failedToGetEvent": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить мероприятие",
    ),
    "failedToGetEvents": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить мероприятия",
    ),
    "failedToLoadAgeRestrictions": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить возрастные ограничения",
    ),
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить категории",
    ),
    "failedToLoadCities": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить города",
    ),
    "failedToLoadFilterOptions": MessageLookupByLibrary.simpleMessage(
      "Не удалось загрузить опции фильтрации",
    ),
    "failedToLoadMyEvents": MessageLookupByLibrary.simpleMessage(
      "Ошибка загрузки ваших мероприятий",
    ),
    "failedToResetPassword": MessageLookupByLibrary.simpleMessage(
      "Не удалось сбросить пароль",
    ),
    "failedToSendOtp": MessageLookupByLibrary.simpleMessage(
      "Не удалось отправить код",
    ),
    "fieldCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Поле не может быть пустым",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Поле обязательно для заполнения",
    ),
    "fillAllTicketDataError": MessageLookupByLibrary.simpleMessage(
      "Заполните данные для всех категорий билетов",
    ),
    "filterButtonText": MessageLookupByLibrary.simpleMessage("Фильтровать"),
    "findYourEvent": MessageLookupByLibrary.simpleMessage(
      "Найдите своё событие",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
    "go_to_event": MessageLookupByLibrary.simpleMessage("Перейти"),
    "invalidCardNumber": MessageLookupByLibrary.simpleMessage(
      "Неверный номер карты",
    ),
    "invalidCredentialsError": MessageLookupByLibrary.simpleMessage(
      "Неверный логин или пароль",
    ),
    "invalidCvv": MessageLookupByLibrary.simpleMessage("Неверный CVV"),
    "invalidDateFormat": MessageLookupByLibrary.simpleMessage(
      "Неверный формат даты",
    ),
    "invalidEventId": MessageLookupByLibrary.simpleMessage(
      "Неверный ID мероприятия",
    ),
    "invalidFormat": MessageLookupByLibrary.simpleMessage("Неверный формат"),
    "invalidOtp": MessageLookupByLibrary.simpleMessage("Неверный код"),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "linkCard": MessageLookupByLibrary.simpleMessage("Привязать карту"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "logoutButton": MessageLookupByLibrary.simpleMessage("Выйти"),
    "logoutDialogTitle": MessageLookupByLibrary.simpleMessage(
      "Вы действительно хотите выйти?",
    ),
    "maxTicketCategoriesError": MessageLookupByLibrary.simpleMessage(
      "Максимум 5 ценовых категорий",
    ),
    "myCards": MessageLookupByLibrary.simpleMessage("Мои карты"),
    "myEventsTitle": MessageLookupByLibrary.simpleMessage("Мои мероприятия"),
    "myTicketTitle": MessageLookupByLibrary.simpleMessage("Мой билет"),
    "myTicketsTitle": MessageLookupByLibrary.simpleMessage("Мои билеты"),
    "networkError": MessageLookupByLibrary.simpleMessage("Ошибка сети"),
    "newCard": MessageLookupByLibrary.simpleMessage("Новая карта"),
    "newPasswordLabel": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "newPasswordTitle": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "no": MessageLookupByLibrary.simpleMessage("Нет"),
    "noAccountLink": MessageLookupByLibrary.simpleMessage("Нет аккаунта?"),
    "noButton": MessageLookupByLibrary.simpleMessage("Нет"),
    "noCreatedEvents": MessageLookupByLibrary.simpleMessage(
      "У вас пока нет созданных мероприятий",
    ),
    "noDataForTicket": MessageLookupByLibrary.simpleMessage(
      "Нет данных для отображения билета.",
    ),
    "noDescription": MessageLookupByLibrary.simpleMessage("Описания нет"),
    "noEventsFound": MessageLookupByLibrary.simpleMessage(
      "Мероприятия по запросу не найдены",
    ),
    "noEventsFoundForQuery": MessageLookupByLibrary.simpleMessage(
      "Мероприятий по вашему запросу не найдено",
    ),
    "noSavedCards": MessageLookupByLibrary.simpleMessage(
      "Нет сохраненных карт",
    ),
    "noTicketPriceInfo": MessageLookupByLibrary.simpleMessage(
      "Нет информации о ценах на билеты",
    ),
    "noTicketsFound": MessageLookupByLibrary.simpleMessage(
      "Билеты по вашему запросу не найдены",
    ),
    "noTicketsYet": MessageLookupByLibrary.simpleMessage(
      "У вас пока нет купленных билетов",
    ),
    "notSpecified": MessageLookupByLibrary.simpleMessage("Не указан"),
    "oneTimeCard": MessageLookupByLibrary.simpleMessage(
      "Новая карта (разовая)",
    ),
    "organizationNameLabel": MessageLookupByLibrary.simpleMessage(
      "Название организации",
    ),
    "organizerFiltersTitle": MessageLookupByLibrary.simpleMessage(
      "Фильтры мероприятий",
    ),
    "organizerTitle": MessageLookupByLibrary.simpleMessage("Организатор"),
    "otpLabel": MessageLookupByLibrary.simpleMessage("Код подтверждения"),
    "otpSentDescription": m6,
    "passwordChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "Пароль успешно изменен",
    ),
    "passwordEmpty": MessageLookupByLibrary.simpleMessage("Введите пароль"),
    "passwordError": MessageLookupByLibrary.simpleMessage(
      "Пароль должен быть не менее 8 символов",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Пароль"),
    "passwordLength": MessageLookupByLibrary.simpleMessage(
      "Пароль должен быть не менее 8 символов",
    ),
    "passwordResetSuccess": MessageLookupByLibrary.simpleMessage(
      "Пароль успешно изменен!",
    ),
    "passwordsDoNotMatchError": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают",
    ),
    "payButton": m7,
    "paymentMethodsTitle": MessageLookupByLibrary.simpleMessage(
      "Способы оплаты",
    ),
    "phoneEmpty": MessageLookupByLibrary.simpleMessage(
      "Введите номер телефона",
    ),
    "phoneFormat": MessageLookupByLibrary.simpleMessage("Формат: +77001234567"),
    "phoneHint": MessageLookupByLibrary.simpleMessage("+77001234567"),
    "phoneLabel": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "photoUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Фото успешно обновлено",
    ),
    "posterNotFound": MessageLookupByLibrary.simpleMessage("Постер\nне найден"),
    "priceFromHint": MessageLookupByLibrary.simpleMessage("От"),
    "priceHint": MessageLookupByLibrary.simpleMessage("Цена"),
    "priceLabel": MessageLookupByLibrary.simpleMessage("Цена"),
    "priceToHint": MessageLookupByLibrary.simpleMessage("До"),
    "pricesAndTicketsTitle": MessageLookupByLibrary.simpleMessage(
      "Цены и билеты",
    ),
    "processingPayment": MessageLookupByLibrary.simpleMessage("Обработка..."),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно обновлен",
    ),
    "promoCodeHint": MessageLookupByLibrary.simpleMessage("Промокод"),
    "promoCodeSuccess": MessageLookupByLibrary.simpleMessage(
      "Промокод применен!",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage("Сброс пароля"),
    "retryButton": MessageLookupByLibrary.simpleMessage("Повторить"),
    "saveButton": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "saveCardForLater": MessageLookupByLibrary.simpleMessage(
      "Сохранить карту для будущих оплат",
    ),
    "savingChanges": MessageLookupByLibrary.simpleMessage(
      "Сохранение изменений...",
    ),
    "search": MessageLookupByLibrary.simpleMessage("Поиск"),
    "seatBooked": MessageLookupByLibrary.simpleMessage("Забронировано"),
    "seatInHall": MessageLookupByLibrary.simpleMessage("Место в зале"),
    "seatRowAndNumber": m8,
    "seatSelected": MessageLookupByLibrary.simpleMessage("Выбрано"),
    "seatTooltip": m9,
    "seatsAmountHint": MessageLookupByLibrary.simpleMessage("Мест (шт)"),
    "seatsNotSelected": MessageLookupByLibrary.simpleMessage(
      "Не выбраны места",
    ),
    "seatsNotSelectedLabel": MessageLookupByLibrary.simpleMessage(
      "Места не выбраны",
    ),
    "selectAtLeastOneSeat": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите хотя бы одно место",
    ),
    "select_city_title": MessageLookupByLibrary.simpleMessage("Выберите город"),
    "selectedSeatsDescription": m10,
    "sendCodeButton": MessageLookupByLibrary.simpleMessage("Отправить код"),
    "serviceFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Работа сервиса (10%)",
    ),
    "showTicketToStaff": MessageLookupByLibrary.simpleMessage(
      "Покажите билет\nнашему сотруднику!",
    ),
    "signInButton": MessageLookupByLibrary.simpleMessage("Войти"),
    "signInError": m11,
    "signInFailedError": MessageLookupByLibrary.simpleMessage("Ошибка входа!"),
    "signInSuccess": MessageLookupByLibrary.simpleMessage(
      "Вход выполнен успешно!",
    ),
    "signUpButton": MessageLookupByLibrary.simpleMessage("Регистрация"),
    "signUpError": m12,
    "signUpFailedError": MessageLookupByLibrary.simpleMessage(
      "Ошибка регистрации",
    ),
    "signUpSuccess": MessageLookupByLibrary.simpleMessage(
      "Регистрация успешна!",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Билеты проданы"),
    "stageLabel": MessageLookupByLibrary.simpleMessage("СЦЕНА"),
    "standardTicketName": MessageLookupByLibrary.simpleMessage("Стандарт"),
    "statusActive": MessageLookupByLibrary.simpleMessage("Активен"),
    "statusInactive": MessageLookupByLibrary.simpleMessage("Неактивен"),
    "statusLabel": MessageLookupByLibrary.simpleMessage("Статус"),
    "ticketBookingTitle": MessageLookupByLibrary.simpleMessage(
      "Оформление билета",
    ),
    "ticketCount": MessageLookupByLibrary.simpleMessage("Кол-во билетов"),
    "ticketFiltersTitle": MessageLookupByLibrary.simpleMessage(
      "Фильтры билетов",
    ),
    "ticketNameHint": MessageLookupByLibrary.simpleMessage(
      "Название (напр. VIP, Входной)",
    ),
    "ticketStatusActive": MessageLookupByLibrary.simpleMessage("Активен"),
    "ticketTypeStandard": MessageLookupByLibrary.simpleMessage("Стандарт"),
    "timeHint": MessageLookupByLibrary.simpleMessage("Время"),
    "timeLabel": MessageLookupByLibrary.simpleMessage("Время"),
    "timeRangeHint": MessageLookupByLibrary.simpleMessage("Время - Время"),
    "tokenRefreshFailedError": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить токен",
    ),
    "totalPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Итоговая стоимость",
    ),
    "totalPriceWithCount": m13,
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "Произошла непредвиденная ошибка",
    ),
    "untitledEvent": MessageLookupByLibrary.simpleMessage("Без названия"),
    "uploadingPhoto": MessageLookupByLibrary.simpleMessage("Загрузка фото..."),
    "userNotAuthorized": MessageLookupByLibrary.simpleMessage(
      "Пользователь не авторизован",
    ),
    "usernameEmpty": MessageLookupByLibrary.simpleMessage(
      "Введите имя пользователя",
    ),
    "usernameLabel": MessageLookupByLibrary.simpleMessage("Имя пользователя"),
    "venueAddressHint": MessageLookupByLibrary.simpleMessage(
      "Адрес проведения",
    ),
    "venueLabel": MessageLookupByLibrary.simpleMessage("Место проведения"),
    "yes": MessageLookupByLibrary.simpleMessage("Да"),
    "yesLogoutButton": MessageLookupByLibrary.simpleMessage("Выйти"),
    "yourCards": MessageLookupByLibrary.simpleMessage("Ваши карты"),
    "yourDataTitle": MessageLookupByLibrary.simpleMessage("Ваши данные"),
    "yourOrganizationTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша организация",
    ),
  };
}
