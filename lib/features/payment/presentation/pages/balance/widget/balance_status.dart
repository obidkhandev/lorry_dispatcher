import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/resources.dart';
import 'package:lorry_dispatcher/core/utills/widget_extantion.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';

class BalanceStatus extends StatelessWidget {
  final String title;
  final String balance;
  final Function() onTap;

  const BalanceStatus({
    super.key,
    required this.title,
    required this.balance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: AppDecoration.cardDecoration(context),
        child: Column(
          children: [
            Text(
              title,
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              balance,
              style: context.theme.textTheme.titleLarge?.copyWith(
                color: AppColors.brandElectric,
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 6.h),
      ),
    );
  }
}
