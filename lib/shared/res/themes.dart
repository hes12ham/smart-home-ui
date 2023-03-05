import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'res.dart';
import 'package:flutter/scheduler.dart';


class SmartyThemeData {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: SmartyColors.primary,
    scaffoldBackgroundColor: SmartyColors.tertiary,
    splashColor: Colors.transparent,
    brightness: Brightness.light,
    highlightColor: Colors.transparent,
    dividerColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      backgroundColor: SmartyColors.tertiary,
      selectedItemColor: SmartyColors.primary,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(
        top: (1 * Decorators.fontSize),
        bottom: (1 * Decorators.fontSize),
        right: (1 * Decorators.fontSize),
        left: (1 * Decorators.fontSize),
      ),
      hintStyle: TextStyles.body.copyWith(color: SmartyColors.grey60),
      fillColor: SmartyColors.black,
      border: Decorators.defaultLightBorder,
      enabledBorder: Decorators.enabledLightBorder,
      focusedBorder: Decorators.focusedLightBorder,
      focusedErrorBorder: Decorators.focusedErrorLightBorder,
      disabledBorder: Decorators.disabledLightBorder,
    ),
    textTheme: TextTheme(
      headline1: TextStyles.headline1,
      bodyText1: TextStyles.body,
      bodyText2: TextStyles.body,
      button: TextStyles.body,
      caption: TextStyles.body,
      headline2: TextStyles.headline2,
      headline3: TextStyles.headline3,
      headline4: TextStyles.headline4,
      subtitle2: TextStyles.subtitle,
      subtitle1: TextStyles.subtitle,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: SmartyColors.primary,
    scaffoldBackgroundColor: SmartyColors.tertiary,
    splashColor: Colors.transparent,
    brightness: Brightness.dark,
    highlightColor: Colors.transparent,
    dividerColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      backgroundColor: SmartyColors.tertiary,
      selectedItemColor: SmartyColors.primary,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.only(
        top: (1 * Decorators.fontSize),
        bottom: (1 * Decorators.fontSize),
        right: (1 * Decorators.fontSize),
        left: (1 * Decorators.fontSize),
      ),
      hintStyle: TextStyles.body.copyWith(color: SmartyColors.grey60),
      fillColor: SmartyColors.black,
      border: Decorators.defaultLightBorder,
      enabledBorder: Decorators.enabledLightBorder,
      focusedBorder: Decorators.focusedLightBorder,
      focusedErrorBorder: Decorators.focusedErrorLightBorder,
      disabledBorder: Decorators.disabledLightBorder,
    ),
    textTheme: TextTheme(

      headline1: TextStyle(
        color: Colors.white,
        fontSize: 60,
        fontWeight: FontWeight.w400,
        height: 1.4,

      ),
      bodyText1: TextStyles.body,
      bodyText2: TextStyles.body,
      button: TextStyles.body,
      caption: TextStyles.body,
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.w400,
        height: 1.4,

      ),
      headline3: TextStyles.headline3,
      headline4: TextStyles.headline4,
      subtitle2: TextStyles.subtitle,
      subtitle1: TextStyles.subtitle,

    ),
  );
}



class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkThememode = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: SmartyColors.primary, opacity: 0.8),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: SmartyColors.primary,),

  );

  static final lightThememode = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: SmartyColors.primary, opacity: 0.8),

  );
}