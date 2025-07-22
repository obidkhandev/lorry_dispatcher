import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/widget_extantion.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_button.dart';


class AcceptOrderDialog extends StatelessWidget {
  const AcceptOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Buyurtmani qabul qilish",
                  style: context.theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: SvgPicture.asset(AppIcons.clockOutlined),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              "Yo'nalish",
              style: context.theme.textTheme.titleSmall?.copyWith(
                fontSize: 12.sp,
                height: 1,
              ),
            ),
            Text("Zomin → Chust", style: context.theme.textTheme.titleMedium),
            10.verticalSpace,
            Text(
              "Kelishilgan narx",
              style: context.theme.textTheme.titleSmall?.copyWith(
                fontSize: 12.sp,
                height: 1,
              ),
            ),
            Text("2 300 000 so'm", style: context.theme.textTheme.titleMedium),
            Row(
              spacing: 16.w,
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Ortga",
                    textColor: AppColors.primaryColor,
                    bgColor: AppColors.primaryOpacity,
                  ),
                ),
                Expanded(child: CustomButton(text: "Tasdiqlash")),
              ],
            ),
          ],
        ).paddingAll(16.sp),
      ),
    );
  }
}

showAcceptOrderDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AcceptOrderDialog();
    },
  );
}
