import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

int fontSize = 1;

double getFontSize(num size) {
  switch (fontSize) {
    case 0:
      return size - 3.sp;
    case 1:
      return size - 1.5.sp;
    case 2:
      return size.sp;
    case 3:
      return size + 1.5.sp;
    case 4:
      return size + 3.sp;
    case 5:
      return size + 4.5.sp;
    default:
      return size.sp;
  }
}

class AppTextStyles {
  static const String fontFamily = 'SF Pro Display';

  TextStyle body18w4 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: getFontSize(18.sp),
    color: AppColors.black,
  );
  //
  TextStyle body18w5 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: getFontSize(18.sp),
    color: AppColors.black,
  );

  TextStyle head30w7 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: getFontSize(30.sp),
    color: AppColors.black,
  );

  TextStyle body18w6 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: getFontSize(18.sp),
    color: AppColors.black,
  );

  TextStyle body16w7 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: getFontSize(16.sp),
    color: AppColors.black,
  );

  TextStyle body16w6 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16.sp,
    color: AppColors.black,
  );
  TextStyle body16wb = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: getFontSize(16.sp),
    color: AppColors.black,
  );

  TextStyle body10w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(10.sp),
      color: AppColors.black);
  TextStyle body10w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(10.sp),
      color: AppColors.black);
  TextStyle body10w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(10.sp),
      color: AppColors.black);
  TextStyle body10w7 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(10.sp),
      color: AppColors.black);
  TextStyle body37w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(37.sp),
      color: AppColors.black);

  TextStyle body16w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(16.sp),
      color: AppColors.black);

  TextStyle body12w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(12.sp),
      color: AppColors.black);
  TextStyle body12w7 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(12.sp),
      color: AppColors.black);
  //
  TextStyle body12w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(12.sp),
      color: AppColors.black);
  TextStyle body11w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(11.sp),
      color: AppColors.black);
  TextStyle body15w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(15.sp),
      color: AppColors.black);

  TextStyle body16w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(16.sp),
      color: AppColors.black);
  //
  TextStyle body15w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(15.sp),
      color: AppColors.black);
  TextStyle body13w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(13.sp),
      color: AppColors.black);
  TextStyle body13w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(13.sp),
      color: AppColors.black);
  TextStyle body14w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(14.sp),
      color: AppColors.black);
  TextStyle body14w7 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(14.sp),
      color: AppColors.black);
  //
  TextStyle body14w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(14.sp),
      color: AppColors.black);

  TextStyle body14w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(14.sp),
      color: AppColors.black);
  TextStyle body12w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(12.sp),
      color: AppColors.black);
  TextStyle body20w6 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(20.sp),
      color: AppColors.black);
  TextStyle body20w7 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(20.sp),
      color: AppColors.black);
  TextStyle body20w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(20.sp),
      color: AppColors.black);
  TextStyle body20wB = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(20.sp),
      color: AppColors.black);

  TextStyle body24wB = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(24.sp),
      color: AppColors.black);
  TextStyle body24w4 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(24.sp),
      color: AppColors.black);
  TextStyle body24w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(24.sp),
      color: AppColors.black);
  TextStyle body26w5 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      fontSize: getFontSize(26.sp),
      color: AppColors.black);
}
