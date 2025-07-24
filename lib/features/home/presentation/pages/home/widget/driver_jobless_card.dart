import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_image_and_rating.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/location_stepper.dart';

class DriverJoblessCard extends StatelessWidget {
  final bool isActive;
  final Function() onTap;

  const DriverJoblessCard({super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
     onTap: onTap,
      child: DecoratedBox(
        decoration: AppDecoration.cardDecoration(context),
        child: Column(
          children: [
            DriverImageAndRating(isActive: isActive),
            12.verticalSpace,
            LocationStepper(
              startTitle: "From",
              startSubtitle: "Current location",
              destinationTitle: "To",
              destinationSubtitle: "Select destination",
              primaryColor: const Color(0xFF2ECC71),
              onStartTap: () {
                print("Green start tapped");
              },
              onDestinationTap: () {
                print("Green destination tapped");
              },
            ),
            12.verticalSpace,
            TitleWithIcon(
              title: "Ref Fure",
              icon: AppIcons.truckFast,
              iconSize: 24.sp,
            ).paddingOnly(left: 6.w),
            12.verticalSpace,
            if(isActive)
            CustomButton(
              text: "Taklif yuborish",
              icon: AppIcons.send,
              iconC: null,
            ),
          ],
        ).paddingAll(14.sp),
      ),
    );
  }
}

