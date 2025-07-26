import 'package:flutter/cupertino.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';

String profileImage =  "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D";
String passport = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCv6r-M4hn90f4lhVOWGem2zwIaxEGl4Kjjg&s";

class Dimensions {
  static const commonPadding = 16.0;
  static const commonBorderRadius = 10;
  static const commonBorderRadius14 = 14.0;

  static const panelPadding = 10.0;

  static const commonSpacing = 10.0;

  static const outlinedButtonBorderWidth = 2.0;
}

class AppDecoration {
  // Fixed: Method instead of getter with parameter
  static BoxDecoration cardDecoration(BuildContext context) => BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 14,
            color: AppColors.black.withOpacity(0.16)
        )
      ]
  );

  // Card decoration with custom color
  static BoxDecoration cardDecorationWithColor(Color color) => BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 14,
            color: AppColors.black.withOpacity(0.16)
        )
      ]
  );

  // Card decoration with custom border radius
  static BoxDecoration cardDecorationWithRadius(BuildContext context, double radius) => BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 14,
            color: AppColors.black.withOpacity(0.16)
        )
      ]
  );

  // Elevated card decoration with stronger shadow
  static BoxDecoration elevatedCardDecoration(BuildContext context) => BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: AppColors.black.withOpacity(0.24)
        )
      ]
  );

  // Flat card decoration without shadow
  static BoxDecoration flatCardDecoration(BuildContext context) => BoxDecoration(
    color: context.theme.cardColor,
    borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14),
  );

  // Card decoration with border
  static BoxDecoration borderedCardDecoration(BuildContext context, {Color? borderColor}) => BoxDecoration(
      color: context.theme.cardColor,
      borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14),
      border: Border.all(
        color: borderColor ?? context.theme.dividerColor,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            color: AppColors.black.withOpacity(0.1)
        )
      ]
  );

  // Rounded container decoration
  static BoxDecoration roundedDecoration(Color color, double radius) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );

  // Circle decoration
  static BoxDecoration circleDecoration(Color color) => BoxDecoration(
    color: color,
    shape: BoxShape.circle,
  );

  // Gradient card decoration
  static BoxDecoration gradientCardDecoration(Gradient gradient) => BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 14,
            color: AppColors.black.withOpacity(0.16)
        )
      ]
  );

  // Custom decoration with all parameters
  static BoxDecoration customDecoration({
    Color? color,
    Gradient? gradient,
    double? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    BoxShape shape = BoxShape.rectangle,
  }) => BoxDecoration(
    color: gradient == null ? color : null,
    gradient: gradient,
    borderRadius: shape == BoxShape.rectangle
        ? BorderRadius.circular(borderRadius ?? Dimensions.commonBorderRadius14)
        : null,
    border: border,
    boxShadow: boxShadow,
    shape: shape,
  );
}
