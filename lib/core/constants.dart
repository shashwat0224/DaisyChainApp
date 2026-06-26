import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary accent — clean blue
  static const primary     = Color(0xFF1A73E8);
  static const primaryLight = Color(0xFFE8F0FE);
  static const onPrimary   = Colors.white;

  // Neutrals
  static const background  = Color(0xFFFBDDB2);
  static const surface     = Colors.black;
  static const border      = Colors.black12;

  // Text
  static const textPrimary   = Color(0xFF1F1F1F);
  static const textSecondary = Color(0xFF5F6368);
  static const textHint      = Color(0xFF9AA0A6);

  // Semantic
  static const success = Color(0xFF34A853);
  static const warning = Color(0xFFFBBC04);
  static const error   = Color(0xFFEA4335);

  // Train card specific
  static const directCardBg      = Colors.white;
  static const indirectCardBg    = Colors.white;
  static const indirectCardBorder = Color(0xFF1A73E8);
}

class AppTextStyles {
  static const trainNo = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const trainName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const time = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const duration = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const badge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static final stationInput = GoogleFonts.permanentMarker(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final appBarTitle = GoogleFonts.bitcountGridDouble(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final stationName = GoogleFonts.bitcountSingle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
}

class AppSpacing {
  static const xs  = 4.0;
  static const sm  = 8.0;
  static const md  = 16.0;
  static const lg  = 24.0;
  static const xl  = 32.0;
}