import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/core/router/go_router_refresh_stream.dart';
import 'package:oqyga_frontend/features/auth/domain/entities/user.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/auth/presentation/pages/sign_in_page.dart';
import 'package:oqyga_frontend/features/auth/presentation/pages/sign_up_page.dart';
import 'package:oqyga_frontend/features/auth/presentation/pages/splash_page.dart';
import 'package:oqyga_frontend/features/cards/presentation/bloc/card_bloc.dart';
import 'package:oqyga_frontend/features/cards/presentation/pages/my_cards_page.dart';
import 'package:oqyga_frontend/features/cards/presentation/pages/new_card_method_page.dart';
import 'package:oqyga_frontend/features/languages/presentation/pages/choose_language_page.dart';
import 'package:oqyga_frontend/features/map/presentation/pages/map_page.dart';
import 'package:oqyga_frontend/features/password_reset/presentation/pages/password_reset_page.dart';
import 'package:oqyga_frontend/features/events/domain/entities/event.dart'
    as event_entity;
import 'package:oqyga_frontend/features/events/presentation/pages/event_detail_page.dart';
import 'package:oqyga_frontend/features/events/presentation/pages/home.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/event_filters.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/organizer_filters.dart';
import 'package:oqyga_frontend/features/filters/presentation/pages/event_filters_page.dart';
import 'package:oqyga_frontend/features/filters/presentation/pages/organizer_filters_page.dart';
import 'package:oqyga_frontend/features/filters/presentation/pages/ticket_filters_page.dart';
import 'package:oqyga_frontend/features/filters/domain/entities/ticket_filters.dart';
import 'package:oqyga_frontend/features/organizer/presentation/pages/add_event_page.dart';
import 'package:oqyga_frontend/features/organizer/presentation/pages/edit_event_page.dart';
import 'package:oqyga_frontend/features/organizer/presentation/pages/organizer_events_page.dart';
import 'package:oqyga_frontend/features/tickets/presentation/bloc/ticket_purchase/ticket_purchase_bloc.dart';
import 'package:oqyga_frontend/features/tickets/presentation/pages/my_tickets_page.dart';
import 'package:oqyga_frontend/features/tickets/presentation/pages/pay_page.dart';
import 'package:oqyga_frontend/features/tickets/presentation/pages/ticket_booking_page.dart';
import 'package:oqyga_frontend/features/tickets/presentation/pages/ticket_detail_page.dart';
import 'package:oqyga_frontend/features/user/presentation/pages/edit_profile_page.dart';
import 'package:oqyga_frontend/features/user/presentation/pages/profile_page.dart';
import 'package:oqyga_frontend/features/organizer/presentation/pages/organizer_profile_page.dart';
import 'package:oqyga_frontend/features/organizer/presentation/pages/edit_organizer_page.dart';
import 'package:oqyga_frontend/shared/views/pages/main_shell.dart';
import 'package:oqyga_frontend/core/router/routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splashPage,
    refreshListenable: GoRouterRefreshStream(sl<AuthBloc>().stream),

    redirect: (BuildContext context, GoRouterState state) {
      final authState = sl<AuthBloc>().state;
      final location = state.matchedLocation;

      final isUnknown = authState.status == AuthStatus.unknown;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isUnauthenticated =
          authState.status == AuthStatus.unauthenticated ||
          authState.status == AuthStatus.error;

      final isPublicRoute =
          location == Routes.signInPage ||
          location == Routes.signUpPage ||
          location == Routes.forgotPassword ||
          location == Routes.validateOTP ||
          location == Routes.newPassword;

      if (isUnknown) {
        return null;
      }

      if (isUnauthenticated) {
        if (!isPublicRoute || location == Routes.splashPage) {
          return Routes.signInPage;
        }
      }
      if (isAuthenticated) {
        if (location == Routes.splashPage || isPublicRoute) {
          return Routes.homePage;
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: Routes.splashPage, builder: (c, s) => const SplashPage()),

      GoRoute(path: Routes.signInPage, builder: (c, s) => const SignInPage()),
      GoRoute(path: Routes.signUpPage, builder: (c, s) => const SignUpPage()),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (c, s) => const PasswordResetPage(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          // Вкладка 0: Home / Add Event
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.homePage,
                builder: (context, state) {
                  final role = sl<AuthBloc>().state.user.role;
                  return role == UserRole.organisator
                      ? const AddEventPage()
                      : const HomePage();
                },
              ),
            ],
          ),

          // Вкладка 1: Map / Organizer Events
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.organisatorEvents,
                builder: (context, state) {
                  final role = sl<AuthBloc>().state.user.role;
                  return role == UserRole.organisator
                      ? const OrganizerEventsPage()
                      : const MapPage();
                },
                routes: [
                  GoRoute(
                    path: Routes.editEvent,
                    builder: (context, state) {
                      final event = state.extra as event_entity.Event?;
                      if (event == null) {
                        return const Scaffold(
                          body: Center(child: Text('Ошибка!')),
                        );
                      }
                      return EditEventPage(eventData: event);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Вкладка 2: Tickets (только для пользователей)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.ticketPage,
                builder: (context, state) {
                  final role = sl<AuthBloc>().state.user.role;
                  // Для организатора показываем профиль вместо билетов
                  return role == UserRole.organisator
                      ? const ProfileOrganizerPage()
                      : const MyTicketsPage();
                },
                routes: [
                  // Подмаршрут редактирования профиля для организатора
                  GoRoute(
                    path: Routes.changeProfile,
                    name: 'edit-profile-organizer',
                    builder: (context, state) {
                      return const EditProfileOrganizerPage();
                    },
                  ),
                ],
              ),
            ],
          ),

          // Вкладка 3: Profile (только для пользователей)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profilePage,
                builder: (context, state) {
                  return const ProfilePage();
                },
                routes: [
                  GoRoute(
                    path: Routes.changeProfile,
                    name: 'edit-profile',
                    builder: (context, state) {
                      return const EditProfilePage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'event-detail',
        path: '/event/:id',
        builder: (context, state) =>
            EventDetailPage(eventId: state.pathParameters['id']!),
        routes: [
          GoRoute(
            path: 'confirm-place',
            name: 'confirm-place',
            builder: (context, state) {
              final event = state.extra;

              if (event is! event_entity.Event) {
                return const Scaffold(
                  body: Center(child: Text("Ошибка: неверные данные события!")),
                );
              }

              return TicketBookingPage(
                eventId: state.pathParameters['id']!,
                event: event,
              );
            },
          ),
          GoRoute(
            path: 'pay',
            name: 'pay',
            builder: (context, state) {
              final bloc = state.extra;
              if (bloc is! TicketPurchaseBloc) {
                return const Scaffold(
                  body: Center(child: Text("Ошибка при сохранении мест!")),
                );
              }
              return PayPage(ticketPurchaseBloc: bloc);
            },
          ),
        ],
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'ticket-detail',
        path: '/ticket/:id',
        builder: (context, state) =>
            TicketDetailPage(ticketId: state.pathParameters['id']!),
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'new-card',
        path: '/new-card',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          final bloc = extra?['bloc'] as CardBloc?;

          final isPurchaseFlow = extra?['isPurchaseFlow'] as bool? ?? false;

          return BlocProvider.value(
            value: bloc!,
            child: NewCardMethodPage(isPurchaseFlow: isPurchaseFlow),
          );
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'cards',
        path: '/my-cards',
        builder: (context, state) => MyCardsPage(),
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'language',
        path: '/language',
        builder: (context, state) => ChooseLanguagePage(),
      ),

      // Фильтры
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: Routes.eventFilterPage,
        builder: (c, s) =>
            EventFiltersPage(initialFilters: s.extra as EventFilters?),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: Routes.ticketFilterPage,
        builder: (c, s) =>
            TicketFiltersPage(initialFilters: s.extra as TicketFilters?),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: Routes.organizerFilterPage,
        builder: (c, s) =>
            OrganizerFiltersPage(initialFilters: s.extra as OrganizerFilters?),
      ),
    ],
  );
}
