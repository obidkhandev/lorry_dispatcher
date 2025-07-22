import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';


BottomNavigationBarItem buildBottomNavItem({
  required String title,
  required bool isSelected,
  required String icon,
  int? badgeCount,
}) {
  final bool showBadge = badgeCount != null && badgeCount > 0;
  final Color iconColor = isSelected ? AppColors.primaryColor : AppColors.grey600;

  // Create the icon widget once to avoid duplication
  Widget iconWidget = SvgPicture.asset(
    icon,
    height: 24.h,
    width: 24.h,
    color: iconColor,
  );

  // Create the badge widget once
  Widget badgedIcon = Badge(
    backgroundColor: showBadge ? AppColors.primaryOpacity : Colors.transparent,
    label: showBadge
        ? Text(
      badgeCount.toString(),
      style: AppTextStyles().body12w5.copyWith(
        color: AppColors.primaryColor,
      ),
    )
        : null,
    child: iconWidget,
  );

  return BottomNavigationBarItem(
    icon: badgedIcon,
    activeIcon: badgedIcon, // Same as icon since we handle selection via color
    label: title,
  );
}