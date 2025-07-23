import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';

class CustomIconWidget extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final bool? hasTitle;
  final String? title;
  final Color? textColor;
  final Color? iconColor;

  const CustomIconWidget({
    super.key,
    required this.icon,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.radius,
    this.hasTitle,
    this.title,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              iconColor ?? AppColors.primaryColor,
              BlendMode.srcIn,
            ),
            width: width ?? 22.w,
            height: height ?? 22.h,
          ),
        ),
      ),
    );
  }
}
