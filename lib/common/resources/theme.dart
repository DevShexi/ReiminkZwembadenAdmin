import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';

class AppTheme {
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    headline1: GoogleFonts.poppins(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      color: AppColors.primary,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
    ),
    button: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.primary,
      letterSpacing: 0.56,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: AppColors.textGrey,
    ),
  );

  static ThemeData light() {
    final ThemeData theme = ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      canvasColor: AppColors.white,
      dividerColor: AppColors.primary,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: AppColors.white,
        titleTextStyle: TextStyle(
          fontSize: 18.0,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 1,
        backgroundColor: AppColors.primary,
      ),
      textTheme: darkTextTheme,
      listTileTheme: ListTileThemeData(
        iconColor: AppColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
      ),
    );

    theme.copyWith(
        colorScheme: theme.colorScheme
            .copyWith(primary: AppColors.primary, secondary: AppColors.accent));
    return theme;
  }
}
