import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final BorderRadius? radius;
  final double iconSize;
  final String? title;
  final bool border;
  final BoxFit? fit;
  final String? errorIcon;
  final bool isLoading;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.radius,
    this.border = false,
    this.iconSize = 60,
    this.title,
    this.fit,
    this.errorIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          period: const Duration(milliseconds: 300),
          baseColor: AppColors.grey1,
          highlightColor: AppColors.secondary,
          child: CustomErrorWidget(
            height: height,
            width: width,
            border: border,
            iconSize: iconSize,
            title: title,
            errorIcon: errorIcon,
          ),
        ),
        errorWidget: (context, url, error) => CustomErrorWidget(
          height: height,
          width: width,
          border: border,
          iconSize: iconSize,
          radius: radius,
          title: title,
          errorIcon: errorIcon,
        ),
      ),
    );
  }
}

class CustomErrorWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool border;
  final double iconSize;
  final String? title;
  final String? errorIcon;
  final BorderRadius? radius;

  const CustomErrorWidget({
    super.key,
    required this.height,
    required this.width,
    this.border = false,
    this.iconSize = 60,
    this.title,
    this.errorIcon,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: radius ?? BorderRadius.circular(8),
        color: AppColors.secondary,
        border: border ? Border.all(color: AppColors.grey1) : null,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(errorIcon ?? AppIcons.icNoImg, height: iconSize.h),
            title == null
                ? const SizedBox.shrink()
                : Text(
                    title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ).paddingOnly(top: 8.h),
          ],
        ),
      ),
    );
  }
}
