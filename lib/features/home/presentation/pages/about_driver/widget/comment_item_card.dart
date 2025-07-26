import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

import '../../../../../../export.dart';

class CommentItemCard extends StatelessWidget {
  const CommentItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryOpacity,
            child: Text(
              "X",
              style: AppTextStyles().body18w6.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          10.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingStars(
                  value: 2,
                  starColor: AppColors.yellow,
                  starSize: 14.sp,
                  starSpacing: 2,
                  valueLabelVisibility: false,
                ),
                6.verticalSpace,
                Text("Yakubjonov Xumoyunmirzo"),
                4.verticalSpace,
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  style: context.theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ).paddingAll(12.sp),
    );
  }
}
