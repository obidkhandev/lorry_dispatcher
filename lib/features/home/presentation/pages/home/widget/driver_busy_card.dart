import 'package:flutter/cupertino.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_image_and_rating.dart';

class DriverBusyCard extends StatelessWidget {
  const DriverBusyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecoration.cardDecoration(context),
      child: Column(
        children: [
          DriverImageAndRating(isActive: false, showStatus: false),
          16.verticalSpace,
          TitleWithIcon(
            title: "Toshkent viloyati, Zangiota tumani",
            icon: AppIcons.location,
            iconSize: 20.sp,
          ),
          8.verticalSpace,
          TitleWithIcon(
            title: "Ref Fura",
            icon: AppIcons.truckFast,
            iconSize: 20.sp,
          ),
        ],
      ).paddingAll(14.sp),
    );
  }
}
