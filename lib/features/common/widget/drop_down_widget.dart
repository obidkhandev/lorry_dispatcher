import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';


class CustomDropDownWidget extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final String? initValue;
  final List<Widget>? leadingIcon;
  final TextStyle? hintStyle, textStyle;
  final Color? backgroundColor, borderColor, iconColor;
  final double? width;
  final Function(String? value)? onChanged;
  final String? label;
  final String? validator;
  final bool visibleClose;

  const CustomDropDownWidget({
    super.key,
    required this.items,
    this.hintText = 'select',
    this.onChanged,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.hintStyle,
    this.width,
    this.iconColor,
    this.initValue,
    this.validator,
    this.label,
    this.leadingIcon,
    this.visibleClose = true,
  });

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label!,
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    // fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: widget.validator != null ? " *" : "",
                  style: AppTextStyles().body14w5.copyWith(
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ),
          6.verticalSpace,
        ],
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            buttonStyleData: ButtonStyleData(
              height: 40.h,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? context.theme.cardColor,
                border: widget.borderColor == null
                    ? null
                    : Border.all(color: widget.borderColor ?? AppColors.transparent),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
            ),
            dropdownStyleData: DropdownStyleData(

              decoration: BoxDecoration(
                color: widget.backgroundColor ?? context.theme.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              width: widget.width ?? MediaQuery.of(context).size.width * 0.78,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            iconStyleData: IconStyleData(
              icon: Row(
                children: [
                  if (selectedValue != null && widget.visibleClose)
                    GestureDetector(
                      onTap: () {
                        selectedValue = null;
                        setState(() {});
                        widget.onChanged!(selectedValue);
                      },
                      child: SvgPicture.asset(
                        AppIcons.arrowLeft,
                        colorFilter: AppColors.colorFilter(AppColors.red),
                        height: 12,
                        width: 12,
                      ),
                    ),
                  8.horizontalSpace,
                  SvgPicture.asset(
                    AppIcons.arrowLeft,
                    width: 18,
                    color:
                        widget.iconColor ??
                        context.theme.textTheme.bodyMedium?.color,
                  ),
                ],
              ),
            ),
            value: selectedValue,
            hint: Text(
              widget.hintText,
              style:
                  widget.hintStyle ??
                  AppTextStyles().body16w4.copyWith(
                    color: AppColors.borderSecondary,
                  ),
            ),
            style:
                widget.textStyle ??
                context.theme.textTheme.bodyMedium?.copyWith(
                  // fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
            // dropdownColor: AppColors().white,
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,

                child: Row(
                  children: [
                    // if (widget.leadingIcon != null) ...?widget.leadingIcon[item.],
                    // 10.horizontalSpace,
                    Text(
                      item,
                      style:
                          widget.textStyle ??
                          context.theme.textTheme.bodyMedium?.copyWith(
                            // fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // customButton: p,
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
          ),
        ),
      ],
    );
  }
}
