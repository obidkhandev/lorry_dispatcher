import 'package:lorry_dispatcher/features/common/widget/custom_network_image.dart';

import '../../../../../../export.dart';

class OrderCompletedCard extends StatelessWidget {
  const OrderCompletedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(Dimensions.commonBorderRadius14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Baxmal", style: context.theme.textTheme.bodyLarge),
              SvgPicture.asset(AppIcons.arrowRight),
              Text(
                "Oltinko'l",
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  // fontWeight: F
                ),
              ),
            ],
          ),
          10.verticalSpace,
          TitleWithIcon(title: 'Ref fura', icon: AppIcons.truckFast),
          6.verticalSpace,
          TitleWithIcon(
            title: 'Kafel bor, ertaga yuklanadi',
            icon: AppIcons.messageText,
          ),
          6.verticalSpace,
          Row(
            children: [
              Expanded(
                // flex: 2,
                child: TitleWithIcon(
                  title: '2 000 000',
                  icon: AppIcons.creditCard,
                ),
              ),
              CustomCachedNetworkImage(
                imageUrl: profileImage,
                height: 36,
                width: 36,
                radius: BorderRadius.circular(40),
                iconSize: 20,
              ),
              10.horizontalSpace,
              Expanded(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Muhammadqayum",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.star,width: 15.sp),
                        2.horizontalSpace,
                        Text("4.5", style: context.theme.textTheme.titleSmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("#955DA", style: context.theme.textTheme.titleSmall),
              Text(
                DateTime.now().toDateAndTimeFormat(),
                style: context.theme.textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ).paddingAll(Dimensions.commonPadding),
    );
  }
}
