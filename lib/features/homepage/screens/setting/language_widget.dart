import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/theme/theme_preference.dart'; 

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      surfaceTintColor: AppColor.neutral6,
      titlePadding: const EdgeInsets.only(left: 20, right: 8, top: 20, bottom: 0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Select Language'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageTile(context, ref, const Locale('en'), 'English'),
          _buildLanguageTile(context, ref, const Locale('ne'), 'Nepali'),
          _buildLanguageTile(context, ref, const Locale('fr'), 'French'),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    WidgetRef ref,
    Locale locale,

    String label,
  ) {
    return ListTile(
      title: Text(label),
      onTap: () {
        ref.read(localeProvider.notifier).state = locale;
       Navigator.pop(context); 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Language changed to $label'),
          duration: Duration(seconds: 1))
        );
      },
    );
  }
}
