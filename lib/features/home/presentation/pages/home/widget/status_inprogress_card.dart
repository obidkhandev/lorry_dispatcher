

import 'package:lorry_dispatcher/core/utills/date_extension.dart';
import 'package:lorry_dispatcher/core/utills/resources.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/title_with_icon.dart';

import '../../../../../../export.dart';

class OrderInprogressCard extends StatelessWidget {
  final int status;

  const OrderInprogressCard({super.key, required this.status});

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
              Text("Oltinko'l", style: context.theme.textTheme.bodyLarge),
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
          TitleWithIcon(title: '2 000 000', icon: AppIcons.creditCard),
          12.verticalSpace,
          CustomButton(
            onTap: () {},
            bgColor: AppColors.primaryOpacity,
            textColor: AppColors.primaryColor,
            text: status == 1
                ? "Yetib keldim"
                : status == 2
                ? "Yuklab chiqdim"
                : status == 3
                ? "Yuk tushurish uchun yetib keldim"
                : "Yuk tushurib chiqdim",
          ),
          16.verticalSpace,
          // 6.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("#955DA", style: context.theme.textTheme.titleSmall),
              Text(
                DateTime.now().toTimeFormat(),
                style: context.theme.textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ).paddingAll(16.sp),
    );
  }
}
