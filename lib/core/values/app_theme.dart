import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

/// Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  cardColor: AppColors.white,

  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.primaryColor,
    brightness: Brightness.light,
  ),
  fontFamily: "Inter",
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      // backgroundColor: AppColors.grey200,
      shape: const CircleBorder(),
    ),
  ),
  tabBarTheme: TabBarThemeData(
    dividerColor: AppColors.transparent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: AppColors.borderSecondary),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,

      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    ),
    centerTitle: true,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles().body24wB.copyWith(color: AppColors.black),
    displayMedium:
    AppTextStyles().body14w5.copyWith(color: AppColors.textBrand),
    displaySmall:
    AppTextStyles().body10w5.copyWith(color: AppColors.textSecondary),
    headlineMedium: AppTextStyles().body24w5.copyWith(color: AppColors.black),
    headlineLarge: AppTextStyles().body18w6.copyWith(color: AppColors.black),
    headlineSmall: AppTextStyles().body16w4.copyWith(color: AppColors.black),
    titleLarge: AppTextStyles().body20w6.copyWith(color: AppColors.black),
    titleMedium: AppTextStyles().body16w5.copyWith(color: AppColors.black),
    titleSmall:
    AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
    bodyLarge: AppTextStyles().body16w6.copyWith(color: AppColors.black),
    bodyMedium: AppTextStyles().body16w6,
    bodySmall:
    AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.white,
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.red,
  canvasColor: AppColors.white,
  primaryColor: AppColors.primaryColor,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
);

/// Dark Theme
final ThemeData darkTheme = ThemeData(
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      // backgroundColor: AppColors.tertiary,
      shape: const CircleBorder(),
    ),
  ),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: AppColors.primaryColor,
    brightness: Brightness.dark,
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: AppColors.borderSecondary),
  ),
  canvasColor: AppColors.c404040,
  fontFamily: "Inter",
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.black,
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    ),
    centerTitle: true,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.darkBottomSheetBgColor,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles().body24wB.copyWith(color: AppColors.white),
    displayMedium:
    AppTextStyles().body14w5.copyWith(color: AppColors.textPrimaryLight),
    displaySmall:
    AppTextStyles().body10w5.copyWith(color: AppColors.textSecondary),
    headlineMedium: AppTextStyles().body24w5.copyWith(color: AppColors.white),
    headlineLarge: AppTextStyles().body18w6.copyWith(color: AppColors.white),
    headlineSmall: AppTextStyles().body16w4.copyWith(color: AppColors.white),
    titleLarge: AppTextStyles().body20w6.copyWith(color: AppColors.white),
    titleMedium: AppTextStyles().body16w5.copyWith(color: AppColors.white),
    titleSmall:
    AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
    bodyLarge: AppTextStyles().body16w6.copyWith(color: AppColors.white),
    bodyMedium: AppTextStyles().body16w6,
    bodySmall:
    AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
  ),
  cardColor: AppColors.darkCardColor,
  scaffoldBackgroundColor: AppColors.black,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.red,
  primaryColor: AppColors.primaryColor,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  }),
);
