import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/export.dart';

class LocationStepper extends StatelessWidget {
  final String startTitle;
  final String destinationTitle;
  final String? startSubtitle;
  final String? destinationSubtitle;
  final Color primaryColor;
  final Color backgroundColor;
  final VoidCallback? onStartTap;
  final VoidCallback? onDestinationTap;

  const LocationStepper({
    Key? key,
    required this.startTitle,
    required this.destinationTitle,
    this.startSubtitle,
    this.destinationSubtitle,
    this.primaryColor = const Color(0xFF4A90E2),
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.onStartTap,
    this.onDestinationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stepper icons va line
        Column(
          children: [
            // Start icon
            GestureDetector(
              onTap: onStartTap,
              child: Container(
                width: 35.h,
                height: 35.h,

                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child:  Icon(
                  Icons.my_location,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),

            // Connecting line
            Container(
              width: 2.w,
              height: 20.h,
              margin: EdgeInsets.symmetric(vertical: 6.h),
              color: primaryColor.withOpacity(0.3),
            ),

            // Destination icon
            GestureDetector(
              onTap: onDestinationTap,
              child: Container(
                width: 35.h,
                height: 35.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppIcons.location,
                  colorFilter: AppColors.colorFilter(AppColors.white),
                ).paddingAll(10.sp),
              ),
            ),
          ],
        ),

        SizedBox(width: 12.w),

        // Titles va subtitles
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Start location
              GestureDetector(
                onTap: onStartTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      startTitle,
                      style: context.theme.textTheme.titleSmall,
                    ),
                    if (startSubtitle != null) ...[
                      Text(
                        startSubtitle!,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

               SizedBox(height: 26.h),

              // Destination location
              GestureDetector(
                onTap: onDestinationTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationTitle,
                      style: context.theme.textTheme.titleSmall?.copyWith(
                        // fontSize: 12.sp,
                      ),
                    ),
                    if (destinationSubtitle != null) ...[
                      Text(
                        destinationSubtitle!,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                        )
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
