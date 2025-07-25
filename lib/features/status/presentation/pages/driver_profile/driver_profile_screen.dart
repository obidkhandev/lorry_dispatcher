import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_network_image.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/home/widget/driver_image_and_rating.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar:

      appBar: CustomAppBar(
        toolbarHeight: 120.h,
        bottom: DriverImageAndRating(
          showStatus: false,
        ).paddingSymmetric(horizontal: 16.w, vertical: 20.h),
      ),
      body: ListView(
        children: [
          20.verticalSpace,
          Text(
            "Haydovchilik guvohnomasi",
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          16.verticalSpace,
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 10.h,
              mainAxisExtent: 160.h,
            ),
            itemBuilder: (_, index) {
              return Column(
                children: [
                  CustomCachedNetworkImage(
                    // imageUrl: passport,
                    height: 120.h,

                    imageUrl: '',
                    width: double.infinity,
                  ),
                  12.verticalSpace,
                  Text(
                    "Oldi",
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
          12.verticalSpace,
          Text(
            "Tex. passport",
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          16.verticalSpace,
          GridView.builder(
            shrinkWrap: true,
            itemCount: 2,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.w,
              crossAxisSpacing: 10.h,
              mainAxisExtent: 160.h,
            ),
            itemBuilder: (_, index) {
              return Column(
                children: [
                  CustomCachedNetworkImage(
                    // imageUrl: passport,
                    height: 120.h,

                    imageUrl: '',
                    width: double.infinity,
                  ),
                  12.verticalSpace,
                  Text(
                    "Oldi",
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
          Text(
            "Tirkama",
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          16.verticalSpace,

          Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomCachedNetworkImage(
                      // imageUrl: passport,
                      height: 120.h,
                      imageUrl: '',
                      width: double.infinity,
                    ),
                    16.verticalSpace,
                    Text(
                      "Oldi",
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CustomCachedNetworkImage(
                      // imageUrl: passport,
                      height: 120.h,
                      imageUrl: '',
                      width: double.infinity,
                    ),
                    16.verticalSpace,
                    Text(
                      "Oldi",
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: CustomButton(
                  text: "Yuklab olish",
                  bgColor: AppColors.primaryOpacity,
                  textColor: AppColors.primaryColor,
                  icon: AppIcons.download,
                ),
              ),
              Expanded(
                child: CustomButton(
                  bgColor: AppColors.primaryOpacity,
                  textColor: AppColors.primaryColor,
                  text: "Ulashish",
                  icon: AppIcons.share,
                ),
              ),
            ],
          ).paddingOnly(
            top: 20.h,
            bottom: customButtonPadding,
          ),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
