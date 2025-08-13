import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/theme/theme_preference.dart';

class CutomToggleSwitchWidget extends ConsumerStatefulWidget {
  final Color? darkbtn;
  final Color? lightbtn;
  const CutomToggleSwitchWidget({super.key, this.darkbtn, this.lightbtn});

  @override
  ConsumerState<CutomToggleSwitchWidget> createState() =>
      _CutomToggleSwitchWidgetState();
}

class _CutomToggleSwitchWidgetState
    extends ConsumerState<CutomToggleSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    //check whether the app is currently in dark mode or light mode
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;
    return SizedBox(
      height: 24.h,
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          iconSize: 20,
          icon: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color:
                isDark
                    ? widget.darkbtn ?? AppColor.semantic3
                    : widget.lightbtn ?? AppColor.neutral6,
          ),
          onPressed: () async {
            final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
            ref.read(themeModeProvider.notifier).state = newMode;
   
          },
          
        ),
      ),
    );
  }
}
