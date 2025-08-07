import '../../../../../../export.dart';

class BalanceItemCard extends StatelessWidget {
  final String? title;
  final bool isIncome;

  const BalanceItemCard({super.key, this.title, this.isIncome = false});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: isIncome ? 0 : 3.19,
              child: SvgPicture.asset(AppIcons.lineArrow).paddingAll(4),
            ),
          ),
          10.horizontalSpace,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title ?? "Kirim\n",
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                TextSpan(
                  text: DateTime.now().toDateFormat(),
                  style: context.theme.textTheme.titleSmall?.copyWith(
                    fontSize: 14.sp,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "30 000 UZS",
            style: context.theme.textTheme.titleMedium?.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ).paddingAll(13.sp),
    );
  }
}
