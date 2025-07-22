import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
             color: color ?? AppColors.white,
              strokeWidth: 2.5.w,
              backgroundColor: AppColors.black.withOpacity(.1),)
          : CupertinoActivityIndicator(color: color ?? AppColors.primaryColor),
    );
  }
}
