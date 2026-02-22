import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqyga_frontend/core/di/injection_container.dart';
import 'package:oqyga_frontend/core/router/router.dart';
import 'package:oqyga_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:oqyga_frontend/features/languages/presentation/bloc/language_bloc.dart';
import 'package:oqyga_frontend/shared/themes/theme.dart';
import 'package:oqyga_frontend/generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(
          create: (_) => sl<LanguageBloc>()..add(LoadSavedLanguageEvent()),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, languageState) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Oqiga!',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightThemeMode,
            locale: languageState.locale,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
