import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xFF76DE24);
  static const polygonColor = Color(0xFF04CFD9);
  static const primaryOpacity = Color.fromRGBO(1, 50, 131, 0.05);
  static const textSecondary = Color(0xFF8C919E);
  static const tertiary = Color(0xFFF3F3F3);
  static const darkCardColor = Color(0xFF242424);
  static const textBrand = Color(0xFF343434);
  static const brandElectric = Color(0xFF04CFD9);
  static const blueAccent = Color(0xFF94DCCA);
  static const textPrimaryDark = Color(0xFFF4F4F4);
  static const textPrimaryLight = Color(0xFFF4F4F4);
  static const c404040 = Color(0xFF404040);
  static const c909090 = Color(0xFF909090);
  static const darkBottomSheetBgColor = Color(0xff151515);

  static const white = Colors.white;
  static const black = Colors.black;
  static const scaffoldDarkBg = Color(0xff151515);
  static const transparent = Colors.transparent;
  static const grey3 = Color(0xFF898E96);
  static const grey600 = Color(0xFF8C919E);
  static const grey5 = Color(0xFF374957);
  static const grey2 = Color(0xFFCCCDCE);
  static const grey200 = Color(0xFFF1F1F1);
  static const grey1 = Color(0xFFE7E9EC);
  static const c343434 = Color(0xFF343434);
  static const grey100 = Color(0xFFF4F4F4);
  static const grey400 = Color(0xFFF1F5F7);
  static const gray = Color(0xffA6ADB9);
  static const cEEEE = Color(0xffEEEEEE);
  static const green = Color(0xff36D488);
  static const c185935 = Color(0xff185935);
  static const c096A34 = Color(0xff096A34);
  static const orange = Color(0xffFFA600);
  static const shimmerColor = Color(0xffF0F0F0);

  static const c30215A = Color(0xff30215A);
  static const grey4 = Color(0xFF393F48);
  static const dividerColor = Color(0xFFD7D8DD);
  static const secondary = Color(0xFFF1F1F1);
  static const borderSecondary = Color(0xFF8C919E);
  static const secondary2 = Color(0xFFF8F8FA);
  static const cff8989 = Color(0xFFFF8989);
  static const c964A4A = Color(0xFF964A4A);
  static const c065155 = Color(0xFF065155);
  static const c0F1A07 = Color(0xFF0F1A07);
  static const cE4FFCE = Color(0xFFE4FFCE);
  static const cF4F4F4 = Color(0xFFF4F4F4);
  static const deepYellow = Color(0xFFE8B200);
  static const secondRed = Color(0xFFE06363);
  static const violet = Color(0xFF8F00FF);

  static ColorFilter colorFilter(Color? color) => ColorFilter.mode(
        color ?? AppColors.white,
        BlendMode.srcIn,
      );
}
