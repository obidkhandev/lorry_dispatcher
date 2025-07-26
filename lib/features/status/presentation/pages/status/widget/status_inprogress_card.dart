import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_busy_card.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_image_and_rating.dart';
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
          16.verticalSpace,
          DriverImageAndRating(
            onTap: () {
              context.push(AppRoutes.driverProfileScreen);
            },
            isActive: false,
            showStatus: false,
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

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {},
                  height: 42.h,
                  bgColor: AppColors.primaryOpacity,
                  textColor: AppColors.primaryColor,
                  text: status == 1
                      ? S.of(context).arrived
                      : status == 2
                      ? S.of(context).loaded
                      : status == 3
                      ? S.of(context).arrivedForUnloading
                      : S.of(context).unloaded,
                ),
              ),
              10.horizontalSpace,
              CustomIconWidget(
                icon: AppIcons.location,
                color: AppColors.primaryOpacity,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DriverTrackingScreen(
                        startPoint: google.LatLng(41.3000, 69.3100),
                        // Toshkent markazi
                        endPoint: google.LatLng(
                          41.2995,
                          69.2401,
                        ), // 6-8 km sharqda
                      ),
                      // builder: (_)=>GoogleMapScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          16.verticalSpace,
          // 6.verticalSpace,
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
      ).paddingAll(16.sp),
    );
  }
}
