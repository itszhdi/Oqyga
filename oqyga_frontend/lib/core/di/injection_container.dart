import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:oqyga_frontend/core/api/api_client.dart';

// Auth Feature
import 'package:oqyga_frontend/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:oqyga_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:oqyga_frontend/features/auth/data/repositories/auth_repository.dart';
import 'package:oqyga_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:oqyga_frontend/features/auth/domain/usecases/sign_in.dart';
import 'package:oqyga_frontend/features/auth/domain/usecases/sign_out.dart';
import 'package:oqyga_frontend/features/auth/domain/usecases/sign_up.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/cards/data/datasources/card_remote_data_source.dart';
import 'package:oqyga_frontend/features/cards/data/repositories/card_repository_impl.dart';
import 'package:oqyga_frontend/features/cards/domain/repositories/i_card_repository.dart';
import 'package:oqyga_frontend/features/cards/domain/usecases/add_card.dart';
import 'package:oqyga_frontend/features/cards/domain/usecases/delete_card.dart';
import 'package:oqyga_frontend/features/cards/domain/usecases/get_my_cards.dart';
import 'package:oqyga_frontend/features/cards/presentation/bloc/card_bloc.dart';

// Events Feature
import 'package:oqyga_frontend/features/events/data/datasources/event_remote_data_source.dart';
import 'package:oqyga_frontend/features/events/data/repositories/event_repository.dart';
import 'package:oqyga_frontend/features/events/domain/repositories/event_repository.dart';
import 'package:oqyga_frontend/features/events/domain/usecases/get_all_events.dart';
import 'package:oqyga_frontend/features/events/domain/usecases/get_event_by_id.dart';
import 'package:oqyga_frontend/features/events/presentation/bloc/event_detail/event_detail_bloc.dart';
import 'package:oqyga_frontend/features/events/presentation/bloc/event_list/event_list_bloc.dart';
import 'package:oqyga_frontend/features/languages/data/datasources/language_local_data_source.dart';
import 'package:oqyga_frontend/features/languages/data/repositories/language_repository_impl.dart';
import 'package:oqyga_frontend/features/languages/domain/repositories/language_repository.dart';
import 'package:oqyga_frontend/features/languages/domain/usecases/change_language.dart';
import 'package:oqyga_frontend/features/languages/domain/usecases/get_saved_language.dart';
import 'package:oqyga_frontend/features/languages/presentation/bloc/language_bloc.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/get_previous_venues.dart';

// Password Reset Feature
import 'package:oqyga_frontend/features/password_reset/data/datasources/password_reset_remote_data_source.dart';
import 'package:oqyga_frontend/features/password_reset/data/repositories/password_reset_repository.dart';
import 'package:oqyga_frontend/features/password_reset/domain/repositories/password_reset_repository.dart';
import 'package:oqyga_frontend/features/password_reset/domain/usecases/request_otp.dart';
import 'package:oqyga_frontend/features/password_reset/domain/usecases/reset_password.dart';
import 'package:oqyga_frontend/features/password_reset/domain/usecases/validate_otp.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/bloc/password_reset_bloc.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/validate_promocode.dart';

// User Feature
import 'package:oqyga_frontend/features/user/data/datasources/user_profile_remote_data_source.dart';
import 'package:oqyga_frontend/features/user/data/repositories/user_profile_repository.dart';
import 'package:oqyga_frontend/features/user/domain/repositories/user_profile_repository.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/change_password.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/get_user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/update_user_profile.dart';
import 'package:oqyga_frontend/features/user/domain/usecases/upload_profile_photo.dart';
import 'package:oqyga_frontend/features/user/presentation/bloc/profile_bloc.dart';

// Tickets Feature
import 'package:oqyga_frontend/features/tickets/data/datasources/ticket_remote_data_source.dart';
import 'package:oqyga_frontend/features/tickets/data/repositories/ticket_repository.dart';
import 'package:oqyga_frontend/features/tickets/domain/repositories/ticket_repository.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/get_my_tickets.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/get_ticket_details.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/get_ticket_qr_code.dart';
import 'package:oqyga_frontend/features/tickets/domain/usecases/purchase_tickets.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/my_tickets/my_tickets_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_detail/ticket_detail_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_purchase/ticket_purchase_bloc.dart';

// Organizer Feature
import 'package:oqyga_frontend/features/organizer/data/datasources/organizer_remote_data_source.dart';
import 'package:oqyga_frontend/features/organizer/data/repositories/organizer_repository.dart';
import 'package:oqyga_frontend/features/organizer/domain/repositories/organizer_repository.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/create_event.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/delete_event.dart';
import 'package:oqyga_frontend/features/organizer/domain/usecases/get_my_events.dart'
    as organizer_usecases;
import 'package:oqyga_frontend/features/organizer/domain/usecases/update_event.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/event_form/event_form_bloc.dart';
import 'package:oqyga_frontend/features/organizer/presentation/bloc/organizer_events/organizer_events_bloc.dart';

// Filters Feature
import 'package:oqyga_frontend/features/filters/data/datasources/filter_remote_data_source.dart';
import 'package:oqyga_frontend/features/filters/data/repositories/filter_repository.dart';
import 'package:oqyga_frontend/features/filters/domain/repositories/filter_repository.dart';
import 'package:oqyga_frontend/features/filters/domain/usecases/get_filter_options.dart';
import 'package:oqyga_frontend/features/filters/presentation/bloc/filter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Map Feature
import 'package:oqyga_frontend/features/map/data/datasources/map_remote_data_source.dart';


final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton<ApiClient>(
    () =>
        ApiClient(client: sl(), localDataSource: sl(), remoteDataSource: sl()),
  );

  // --- Featues ---
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerBlocs();
}

void _registerBlocs() {
  sl.registerSingleton<AuthBloc>(
    AuthBloc(authRepository: sl(), signIn: sl(), signUp: sl(), signOut: sl()),
  );
  sl.registerFactory(() => EventsListBloc(getAllEvents: sl()));
  sl.registerFactory(() => EventDetailBloc(getEventById: sl()));
  sl.registerFactory(
    () => PasswordResetBloc(
      requestOtp: sl(),
      validateOtp: sl(),
      resetPassword: sl(),
    ),
  );
  sl.registerSingleton<ProfileBloc>(
    ProfileBloc(
      getUserProfile: sl(),
      updateUserProfile: sl(),
      changePassword: sl(),
      uploadProfilePhoto: sl(),
    ),
  );
  sl.registerFactory(() => MyTicketsBloc(getMyTickets: sl()));
  sl.registerFactory(
    () => TicketDetailBloc(getTicketDetails: sl(), getTicketQrCode: sl()),
  );
  sl.registerFactory(
    () => TicketPurchaseBloc(
      purchaseTickets: sl(),
      validatePromocode: sl(),
      authBloc: sl(),
    ),
  );
  sl.registerFactory(
    () => OrganizerEventsBloc(getMyEvents: sl(), deleteEvent: sl()),
  );
  sl.registerFactory(
    () => EventFormBloc(
      createEvent: sl(),
      updateEvent: sl(),
      filterRepository: sl(),
      getPreviousVenues: sl(),
    ),
  );
  sl.registerFactory(
    () => FilterBloc(getFilterOptions: sl(), getPreviousVenues: sl()),
  );
  sl.registerFactory(
    () => LanguageBloc(
      getSavedLanguageUseCase: sl(),
      changeLanguageUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => CardBloc(
      getMyCards: sl(),
      addCard: sl(),
      deleteCardUseCase: sl(),
      remoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );
}

void _registerUseCases() {
  // Auth
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  // Events
  sl.registerLazySingleton(() => GetAllEvents(sl()));
  sl.registerLazySingleton(() => GetEventById(sl()));
  // Password Reset
  sl.registerLazySingleton(() => RequestOtp(sl()));
  sl.registerLazySingleton(() => ValidateOtp(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  // User
  sl.registerLazySingleton(() => GetUserProfile(sl()));
  sl.registerLazySingleton(() => UpdateUserProfile(sl()));
  sl.registerLazySingleton(() => ChangePassword(sl()));
  sl.registerLazySingleton(() => UploadProfilePhoto(sl()));
  // Tickets
  sl.registerLazySingleton(() => GetMyTickets(sl()));
  sl.registerLazySingleton(() => GetTicketDetails(sl()));
  sl.registerLazySingleton(() => GetTicketQrCode(sl()));
  sl.registerLazySingleton(() => PurchaseTickets(sl()));

  sl.registerLazySingleton(() => ValidatePromocode(sl()));
  // Organizer
  sl.registerLazySingleton(() => organizer_usecases.GetMyEvents(sl()));
  sl.registerLazySingleton(() => CreateEvent(sl()));
  sl.registerLazySingleton(() => UpdateEvent(sl()));
  sl.registerLazySingleton(() => DeleteEvent(sl()));
  sl.registerLazySingleton(() => GetPreviousVenues(sl()));
  // Filters
  sl.registerLazySingleton(() => GetFilterOptions(sl()));

  sl.registerLazySingleton(() => GetSavedLanguageUseCase(sl()));
  sl.registerLazySingleton(() => ChangeLanguageUseCase(sl()));

  sl.registerLazySingleton(() => GetMyCards(sl()));
  sl.registerLazySingleton(() => AddCard(sl()));
  sl.registerLazySingleton(() => DeleteCard(sl()));
}

void _registerRepositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PasswordResetRepository>(
    () => PasswordResetRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TicketRepository>(
    () => TicketRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<OrganizerRepository>(
    () => OrganizerRepositoryImpl(
      remoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<FilterRepository>(
    () => FilterRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LanguageRepository>(
    () => LanguageRepositoryImpl(languageLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CardRepository>(
    () => CardRepositoryImpl(remoteDataSource: sl(), authLocalDataSource: sl()),
  );
}

void _registerDataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(client: sl(), apiClient: sl()),
  );
  sl.registerLazySingleton<PasswordResetRemoteDataSource>(
    () => PasswordResetRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<UserProfileRemoteDataSource>(
    () => UserProfileRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<TicketRemoteDataSource>(
    () => TicketRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<FilterRemoteDataSource>(
    () => FilterRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<OrganizerRemoteDataSource>(
    () => OrganizerRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<CardRemoteDataSource>(
    () => CardRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<MapRemoteDataSource>(
    () => MapRemoteDataSourceImpl(apiClient: sl()),
  );
}
