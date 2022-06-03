import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';

class AppStyles {
  AppStyles._();
  static var title = GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );
  static var subtitle1 = GoogleFonts.poppins(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrey,
  );
}
