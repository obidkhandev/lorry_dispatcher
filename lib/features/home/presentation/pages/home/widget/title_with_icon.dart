import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/export.dart';

class TitleWithIcon extends StatelessWidget {
  final String title;
  final String icon;
  final Color? icColor;
  final MainAxisAlignment? mainAxisAlignment;

  const TitleWithIcon({
    super.key,
    required this.title,
    required this.icon,
    this.mainAxisAlignment, this.icColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          width: 18.w,
          height: 18.h,
          colorFilter: AppColors.colorFilter(icColor ?? AppColors.grey600),
        ),
        8.horizontalSpace,
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
