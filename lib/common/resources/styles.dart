import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';

class AppStyles {
  AppStyles._();
  static var heading1primary = GoogleFonts.poppins(
    color: AppColors.primary,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );
  static var heading1black = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );
  static var heading2primary = GoogleFonts.poppins(
    color: AppColors.primary,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );
  static var heading2black = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );
  static var subHeadingPrimary = GoogleFonts.poppins(
    color: AppColors.primary,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  static var subHeadingBlack = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  static var title = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );
  static var title2 = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
  static var subtitle = GoogleFonts.poppins(
    color: AppColors.textGrey,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );
  static var textField = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );
  static var hint = GoogleFonts.poppins(
    color: AppColors.textGrey,
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
  );
  static var body = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  static var smallLabel = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
  static var error = GoogleFonts.poppins(
    color: AppColors.error,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );
  static var extraSmallLabel = GoogleFonts.poppins(
    color: AppColors.black,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
  );
  static var button = GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    letterSpacing: 0.56,
  );
}
