import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/features/common/widget/loading_widget.dart';

import 'package:scale_button/scale_button.dart';

import '../../../export.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.text = "",
    this.onTap,
    this.radius,
    this.bgColor,
    this.textColor,
    this.isLoading = false,
    this.paddingV,
    this.fontSize,
    this.colorL,
    this.icon,
    this.rightW,
    this.borderColor,
    this.fontW,
    this.iconC,
    this.height,
    this.isAnimation = false,
  });

  final String text;
  final Function()? onTap;
  final BorderRadius? radius;
  final double? paddingV;
  final double? fontSize;
  final FontWeight? fontW;

  final Color? colorL;
  final String? icon;
  final Color? bgColor;
  final Color? iconC;

  final Color? borderColor;
  final Color? textColor;
  final bool isLoading;
  final double? height;
  final Widget? rightW;
  final bool isAnimation;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {


  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: widget.radius ?? BorderRadius.circular(10),
      child: InkWell(
        onTap: widget.onTap,
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        borderRadius: widget.radius ?? BorderRadius.circular(10),
        child: Ink(
          height: widget.height ?? 45.h,
          padding: EdgeInsets.symmetric(
            vertical: widget.isLoading ? 8.h : widget.paddingV ?? 8.h,
            horizontal: 8.w,
          ),
          decoration: BoxDecoration(
            borderRadius: widget.radius ?? BorderRadius.circular(10.r),
            border: Border.all(
              color: widget.borderColor ?? AppColors.transparent,
              width: 3,
            ),
            color: widget.bgColor ?? AppColors.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isLoading
                  ? SizedBox(
                      height: 29.h,
                      width: 29.w,
                      child: Center(
                        child: LoadingWidget(
                          color: widget.colorL ?? AppColors.white,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.icon != null
                            ? SvgPicture.asset(
                                widget.icon ?? "",
                                colorFilter: ColorFilter.mode(
                                  widget.iconC ??
                                      widget.textColor ??
                                      AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ).paddingOnly(right: 8)
                            : const SizedBox.shrink(),
                        widget.rightW ?? const SizedBox.shrink(),
                        SizedBox(
                          child: Text(
                            widget.text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyles().body16w6.copyWith(
                              color: widget.textColor ?? AppColors.white,
                              fontSize: widget.fontSize ?? 14,
                              fontWeight: widget.fontW ?? FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 8),
            ],
          ),
        ),
      ),
    );
  }
}
