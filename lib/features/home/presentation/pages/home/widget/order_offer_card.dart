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
              : AppColors.transparent,
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
                Text(DateTime.now().toDateAndTimeFormat(), style: context.theme.textTheme.titleSmall),
              ],
            ),

          ],
        ).paddingAll(14.sp),
      ),
    );
  }
}