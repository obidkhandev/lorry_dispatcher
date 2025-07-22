import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/widget_extantion.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_tile.dart';
import 'package:lorry_dispatcher/features/profile/data/models/profile_action_model.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<ProfileActionModel> actions;

  const ProfileSection({super.key, required this.title, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpace,
        Text(
          title,
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: actions.length,
          itemBuilder: (_, index) {
            final e = actions[index];
            return CustomTile(
              title: e.title ?? '',
              trailing: e.tralingWidget ?? SvgPicture.asset(
                AppIcons.arrowRight,
                color: context.theme.iconTheme.color?.withOpacity(0.7),
              ),
              leading: e.icon != null
                  ? IconButton.filled(
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        backgroundColor: AppColors.grey200,
                      ),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        e.icon ?? '',
                        width: 20.w,
                        height: 20.h,
                        color: AppColors.grey600,
                      ),
                    )
                  : null,
              onTap: e.onTap,
            ).paddingSymmetric(vertical: 4.h);
          },
          separatorBuilder: (_, __) {
            return Divider(
              color: AppColors.grey200,
              thickness: 1,
              height: 0,
            ).paddingOnly(top: 6.h);
          },
        ),
        // 6.verticalSpace,
        // Divider(color: AppColors.grey200, thickness: 1, height: 0),
      ],
    );
  }
}
