import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/export.dart';


class CustomModalBottomSheet extends StatelessWidget {
  final String title;
  final Widget? content;

  const CustomModalBottomSheet({super.key, required this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: M
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: M,
          children: [
            const Spacer(),
            Text(
              title,
              style:  context.theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp
              ),
            ),
            const Spacer(),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: context.theme.cardColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon:  Icon(
                Icons.close,
                color: context.isDarkMode?
                AppColors.white
                    : AppColors.black,
                // color: context
              ),
            ),
          ],
        ).paddingSymmetric(
            horizontal: 16.w
        ),
        16.verticalSpace,
        customDivider,
        content?.paddingAll(20.sp) ?? const SizedBox.shrink(),
      ],
    ).paddingOnly(
      bottom: customButtonPadding - 20,
      top: 16.h,
    );
  }

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return this;
      },
    );
  }
}
