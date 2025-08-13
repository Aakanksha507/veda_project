import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myflutterapp/features/auth/login/checking_login_status.dart';
import 'package:myflutterapp/theme/theme.dart';
import 'package:myflutterapp/theme/theme_preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() => runApp
(ScreenUtilInit(
    designSize: Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    ensureScreenSize: true,
    builder:(context, child)=> const ProviderScope(child:MyApp())));

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}
    final GlobalKey materialAppKey = GlobalKey();

class _MyAppState extends ConsumerState<MyApp> {
  
  @override
  Widget build(BuildContext context) {


    //ref is obj provided by riverpod that access and react to state provider.
    final themeMode = ref.watch(themeModeProvider);
    final appLocale = ref.watch(localeProvider);

    return MaterialApp(
      key: materialAppKey,
      theme: AppTheme.lighttheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,//ThemeMode.system, 
      debugShowCheckedModeBanner: false,
      locale: appLocale,  
      supportedLocales: const [
        Locale('en'), 
        Locale('fr'), 
        Locale('ne'), 
      ],
      localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
      ],
      home: CheckingLoginStatus(),
    );
  }
}


