import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqyga_frontend/features/languages/presentation/bloc/language_bloc.dart';
import 'package:oqyga_frontend/generated/l10n.dart'; 
import 'package:oqyga_frontend/shared/views/widgets/shadowed_button.dart';

String getLanguageName(String code) {
  switch (code) {
    case 'en':
      return 'English';
    case 'kk':
      return 'Qazaqşa';
    case 'ru':
    default:
      return 'Русский';
  }
}

class ChooseLanguageView extends StatelessWidget {
  const ChooseLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    final List<Map<String, dynamic>> languages = [
      {'code': 'ru', 'name': 'Русский', 'flag': 'assets/static/russian.png'},
      {'code': 'en', 'name': 'English', 'flag': 'assets/static/america.png'},
      {'code': 'kk', 'name': 'Qazaqşa', 'flag': 'assets/static/kazakh.png'},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShadowedBackButton(onPressed: () => context.pop()),
                  const SizedBox(width: 16),
                  Text(
                    s.language, // "Язык"
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                s.chooseLanguage, // "Выберите язык"
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  final currentLocaleCode =
                      state.locale?.languageCode ??
                      Localizations.localeOf(context).languageCode;

                  return Column(
                    children: languages
                        .map(
                          (language) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _LanguageOption(
                              languageName: language['name'],
                              flagPath: language['flag'],
                              languageCode: language['code'],
                              isSelected: currentLocaleCode == language['code'],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String languageName;
  final String flagPath;
  final String languageCode;
  final bool isSelected;

  const _LanguageOption({
    required this.languageName,
    required this.flagPath,
    required this.languageCode,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<LanguageBloc>().add(
          ChangeLanguageEvent(Locale(languageCode)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black,
            width: isSelected ? 2.0 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                flagPath,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 32,
                    height: 32,
                    color: Colors.grey[300],
                    child: const Icon(Icons.flag, size: 20),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                languageName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }
}
