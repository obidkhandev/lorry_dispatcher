import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/formatters.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? context.theme.scaffoldBackgroundColor
          : AppColors.white,
      body: Column(
        children: [
          100.verticalSpace,
          SvgPicture.asset(AppIcons.logo),
          30.verticalSpace,
          CustomTextField(fillColor: AppColors.grey100,
            labelText: "Telefon raqamingiz",
            hintText: "Telefon raqamingiz",
            leadingWidget: Text(
              "+998",
              style: context.theme.textTheme.titleMedium,
            ).paddingOnly(left: 10.w, top: 14.h),
            formatter: [Formatters.phoneFormatter],
          ),
          Spacer(),
          CustomButton(
            text: "Kirish",
            onTap: () {
              context.pushNamed(AppRoutes.otpScreen);
            },
          ),
          customButtonPadding.verticalSpace,
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
