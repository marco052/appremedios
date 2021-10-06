import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';

class AppTextStyles {
  static final interRegularTitle = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.title
  );

  static final interBoldTitle = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.title
  );

  static final interText = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.title
  );

  static final interTextArea = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.title
  );

  static final interSmall = GoogleFonts.inter(
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: AppColors.title
  );

  static final label = GoogleFonts.jost(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.text
  );

  static final textField = GoogleFonts.jost(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.buttonText
  );

  static final buttonText = GoogleFonts.jost(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.buttonText
  );

  static final linkColor = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primary
  );
}