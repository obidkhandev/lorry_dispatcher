import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_image_and_rating.dart';

class DriverJoblessCard extends StatelessWidget {
  final bool isActive;
  final Function() onTap;

  const DriverJoblessCard({
    super.key,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecoration.cardDecoration(context),
      child: Column(
        spacing: 12,
        children: [
          DriverImageAndRating(isActive: isActive),
          TitleWithIcon(
            title: "Toshkent",
            icon: AppIcons.location,
            subtitle: "Qayerdan",
          ),
          TitleWithIcon(
            title: "Namangan sergili",
            icon: AppIcons.location,
            subtitle: "Qayerga",
          ),
          TitleWithIcon(
            title: "Ref Fure",
            icon: AppIcons.truckFast,
            // iconSize: 20.sp,
          ),
          if (isActive)
            CustomButton(
              text: S.of(context).sendOffer,
              icon: AppIcons.send2,
              onTap: onTap,
              textColor: AppColors.primaryColor,
              bgColor: AppColors.primaryOpacity,
              iconC: AppColors.primaryColor,
            ),
        ],
      ).paddingAll(14.sp),
    );
  }
}
