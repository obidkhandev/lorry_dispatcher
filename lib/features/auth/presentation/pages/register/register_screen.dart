import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/formatters.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_app_bar.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        top: false,
        child: CustomButton(text: "Ro'yxatdan o'tish", onTap: () {
          context.pushNamed(AppRoutes.home);
        })
            .paddingOnly(
              left: 16.w,
              right: 16.w,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
      ),
      appBar: CustomAppBar(title: "Register"),
      backgroundColor: context.isDarkMode
          ? context.theme.scaffoldBackgroundColor
          : AppColors.white,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          20.verticalSpace,
          CustomTextField(
            fillColor: AppColors.grey100,
            labelText: "Ism",
            hintText: "Ism",
          ),
          12.verticalSpace,
          CustomTextField(
            fillColor: AppColors.grey100,
            labelText: "Familiya",
            hintText: "Familiya",
          ),
          12.verticalSpace,
          CustomTextField(
            fillColor: AppColors.grey100,
            labelText: "Telefon raqamingiz",
            hintText: "Telefon raqamingiz",
            leadingWidget: Text(
              "+998",
              style: context.theme.textTheme.titleMedium,
            ).paddingOnly(left: 10.w, top: 14.h),
            formatter: [Formatters.phoneFormatter],
          ),



        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
