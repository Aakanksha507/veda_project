import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myflutterapp/theme/theme_preference.dart'; // Make sure this contains `localeProvider`

class LanguageWidget extends ConsumerWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      onSelected: (Locale selectedLocale) {
        ref.read(localeProvider.notifier).state = selectedLocale;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Language changed to ${_getLangName(selectedLocale)}"),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        const PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Text('English'),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('ne'),
          child: Text('Nepali'),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('fr'),
          child: Text('French'),
        ),
      ],
    );
  }

  String _getLangName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ne':
        return 'Nepali';
      case 'fr':
        return 'French';
      default:
        return locale.languageCode;
    }
  }
}
