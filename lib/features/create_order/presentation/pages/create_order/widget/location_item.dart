import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

import '../../../../../../export.dart';

class LocationItem extends StatelessWidget {
  final String title;
  final Color? color;
  final bool showDelete;
  final Function()? onDelete;

  const LocationItem({
    super.key,
    required this.title,
    this.color,
    this.onDelete,
    this.showDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(AppIcons.menuVertical),
            16.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles().body14w7.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
                Text(
                  "Yuk olish manzili",
                  style: AppTextStyles().body12w4.copyWith(
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: onDelete,
              child: SvgPicture.asset(AppIcons.delete, width: 20.w),
            ),
          ],
        ),
        8.verticalSpace,
        Divider(
          color: context.isDarkMode?
          AppColors.grey808080
              : AppColors.grey200,
          thickness: 1,
          height: 0,
        ),
        8.verticalSpace,
      ],
    );
  }
}
