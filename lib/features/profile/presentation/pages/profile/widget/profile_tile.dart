import 'package:lorry_dispatcher/features/common/widget/custom_list_tile_with_driver.dart';

import '../../../../../../export.dart';


class SettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Function()? onTap;
  final bool hasTrailingArrow;

  const SettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.hasTrailingArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWithDriver(
      title: title,
      onTap: onTap,
      titleStyle: context.theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      subtitle: subtitle,
      subtitleStyle: context.theme.textTheme.displayMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      trailingSvg: trailing == null
          ? hasTrailingArrow
          ? AppIcons.arrowRight
          : null
          : null,
      trailingColor: trailing == null
          ? context.isDarkMode
          ? AppColors.grey4
          : AppColors.black
          : null,
      trailingWidget: trailing,
    );
  }
}
