import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/theme/theme_preference.dart';

class CutomToggleSwitchWidget extends ConsumerStatefulWidget{
  const CutomToggleSwitchWidget( {super.key});

  @override
  ConsumerState<CutomToggleSwitchWidget> createState() => _CutomToggleSwitchWidgetState();
}

class _CutomToggleSwitchWidgetState extends ConsumerState<CutomToggleSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    //check whether the app is currently in dark mode or light mode
      final themeMode = ref.watch(themeModeProvider);
      final isDark = themeMode == ThemeMode.dark;
    return IconButton(
      icon: Icon(
        isDark? Icons.dark_mode : Icons.light_mode,
        color: isDark ? AppColor.semantic3: AppColor.neutral4 ,
      ),
      onPressed:() async {
        final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
        ref.read(themeModeProvider.notifier).state = newMode;
      },
    );
  }
}