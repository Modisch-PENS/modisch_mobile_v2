// lib/constants/typography.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modisch/core/constants/colors.dart';

class AppTypography {
  static final TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static final TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static final TextStyle bodyText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static final TextStyle button = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final TextStyle navbar = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    // color: AppColors.fontActive,
  );
}
