import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';


class CustomTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? ball;
  final String? additionalBall;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const CustomTile({
    super.key,
    required this.title,
    this.subtitle,
    this.ball,
    this.additionalBall,
    this.onTap,
    this.leading,
    this.trailing, this.titleStyle, this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.primaryOpacity,
      highlightColor: AppColors.primaryOpacity,
      hoverColor: AppColors.primaryOpacity,
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            6.horizontalSpace,
          ],
          Expanded(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "$title ${subtitle != null ? '\n' : ''}",
                      style: titleStyle ?? context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      )),
                  if (subtitle != null)
                    TextSpan(
                      text: subtitle,
                      style: subtitleStyle ?? context.theme.textTheme.titleSmall?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (ball != null) ...[
            const Spacer(),
            RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                children: [
                  if (ball != null)
                    TextSpan(
                      text: "$ball${additionalBall != null ? '\n' : ''}",
                      style: context.theme.textTheme.titleMedium,
                    ),
                  if (additionalBall != null)
                    TextSpan(
                      text: additionalBall,
                      style: AppTextStyles().body14w5.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                ],
              ),
            ),
          ],
          if (trailing != null) ...[6.horizontalSpace, trailing!],
        ],
      ),
    );
  }
}
