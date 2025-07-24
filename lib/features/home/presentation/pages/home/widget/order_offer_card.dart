import '../../../../../../export.dart';

class OrderOfferCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback? onTap;

  const OrderOfferCard({
    super.key,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: AppDecoration.borderedCardDecoration(
          context,
          borderColor: isSelected
              ? AppColors.primaryColor
              : context.theme.dividerColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('Arnasoy', style: context.theme.textTheme.titleLarge),
                const Spacer(),
                SvgPicture.asset(AppIcons.arrowRight),
                const Spacer(),
                Text('Qarshi', style: context.theme.textTheme.titleLarge),
              ],
            ),
            12.verticalSpace,
            // Truck type
            TitleWithIcon(title: "Ref fura", icon: AppIcons.truckFast),
            8.verticalSpace,
            TitleWithIcon(
              title: "Kafel bor, ertaga yuklanadi Kafel bor, ertaga yuklanadi",
              icon: AppIcons.messageText,
            ),
            8.verticalSpace,
            TitleWithIcon(title: "2 000 000", icon: AppIcons.creditCard),
            10.verticalSpace,
            Row(
              children: [
                Text('#95SDA', style: context.theme.textTheme.titleSmall),
                const Spacer(),
                Text('18:25', style: context.theme.textTheme.titleSmall),
              ],
            ),
            // Selection indicator
            if (isSelected) ...[
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 16.sp,
                        ),
                        4.horizontalSpace,
                        Text(
                          'Tanlangan',
                          style: context.theme.textTheme.labelSmall?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ).paddingAll(14.sp),
      ),
    );
  }
}