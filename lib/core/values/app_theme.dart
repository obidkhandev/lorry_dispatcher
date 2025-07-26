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
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      // Use a solid color instead of transparent for better visibility
      statusBarColor: AppColors.white, // Match the app bar background
      statusBarIconBrightness: Brightness.dark, // Dark icons for light background
      statusBarBrightness: Brightness.light, // iOS: light status bar background
      systemNavigationBarColor: AppColors.white, // Match app background
      systemNavigationBarIconBrightness: Brightness.dark, // Dark icons
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
    ),
    centerTitle: true,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles().body24wB.copyWith(color: AppColors.black),
    displayMedium: AppTextStyles().body14w5.copyWith(color: AppColors.textBrand),
    displaySmall: AppTextStyles().body10w5.copyWith(color: AppColors.textSecondary),
    headlineMedium: AppTextStyles().body24w5.copyWith(color: AppColors.black),
    headlineLarge: AppTextStyles().body18w6.copyWith(color: AppColors.black),
    headlineSmall: AppTextStyles().body16w4.copyWith(color: AppColors.black),
    titleLarge: AppTextStyles().body20w6.copyWith(color: AppColors.black),
    titleMedium: AppTextStyles().body16w5.copyWith(color: AppColors.black),
    titleSmall: AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
    bodyLarge: AppTextStyles().body16w6.copyWith(color: AppColors.black),
    bodyMedium: AppTextStyles().body16w6,
    bodySmall: AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
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
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      // Use a solid color instead of transparent for better visibility
      statusBarColor: AppColors.black, // Match the app bar background
      statusBarIconBrightness: Brightness.light, // Light icons for dark background
      statusBarBrightness: Brightness.dark, // iOS: dark status bar background
      systemNavigationBarColor: AppColors.black, // Match app background
      systemNavigationBarIconBrightness: Brightness.light, // Light icons
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
    ),
    centerTitle: true,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.darkBottomSheetBgColor,
  ),
  textTheme: TextTheme(
    displayLarge: AppTextStyles().body24wB.copyWith(color: AppColors.white),
    displayMedium: AppTextStyles().body14w5.copyWith(color: AppColors.textPrimaryLight),
    displaySmall: AppTextStyles().body10w5.copyWith(color: AppColors.textSecondary),
    headlineMedium: AppTextStyles().body24w5.copyWith(color: AppColors.white),
    headlineLarge: AppTextStyles().body18w6.copyWith(color: AppColors.white),
    headlineSmall: AppTextStyles().body16w4.copyWith(color: AppColors.white),
    titleLarge: AppTextStyles().body20w6.copyWith(color: AppColors.white),
    titleMedium: AppTextStyles().body16w5.copyWith(color: AppColors.white),
    titleSmall: AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
    bodyLarge: AppTextStyles().body16w6.copyWith(color: AppColors.white),
    bodyMedium: AppTextStyles().body16w6,
    bodySmall: AppTextStyles().body12w4.copyWith(color: AppColors.textSecondary),
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