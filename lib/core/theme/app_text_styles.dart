import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Dark Theme Styles
  static TextStyle headline = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600, // Slightly less than bold like Figma
    color: AppColors.textColor,
  );

  static TextStyle bodyText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  static TextStyle skipText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textColor,
  );

  // Light Theme (Auth) Styles
  static TextStyle authHeadline = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle authSubtitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimaryColor,
  );

  static TextStyle inputLabel = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSubtitleColor,
  );

  static TextStyle inputText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black54,
  );
}
