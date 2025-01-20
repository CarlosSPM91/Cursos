import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_ratting_app/app/presentation/global/colors.dart';

ThemeData getTheme(bool darkMode) {
  if (darkMode) {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppColors.darkLight,
      canvasColor: AppColors.dark,
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(AppColors.dark),
        trackColor: WidgetStateProperty.all(AppColors.light),
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.light,
        ),
        backgroundColor: AppColors.dark,
        elevation: 0,
      ),
      textTheme: GoogleFonts.robotoTextTheme(
        ThemeData.dark().textTheme.copyWith(
              bodyMedium: const TextStyle(
                color: AppColors.light
              ),
            ),
      ),
    );
  }
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.white,
      iconTheme: IconThemeData(
        color: AppColors.dark,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.dark,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.dark,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.light),
      trackColor: WidgetStateProperty.all(AppColors.dark),
    ),
    textTheme: GoogleFonts.robotoTextTheme(),
  );
}
