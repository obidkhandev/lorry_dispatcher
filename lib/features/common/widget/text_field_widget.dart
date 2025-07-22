// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/utills/widget_extantion.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:scale_button/scale_button.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.onChange,
    this.labelText,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscure = false,
    this.textInputAction,
    this.fillColor,
    this.initialValue,
    this.preIconColor,
    this.textEditingController,
    this.readOnly = false,
    this.onTap,
    this.formatter,
    this.textInputType,
    this.maxLength,
    this.focusNode,
    this.borderColor,
    this.onFieldSubmitted,
    this.hintText,
    this.leadingWidget,
    this.trailingWidget,
  });

  final TextEditingController? textEditingController;
  final Function(String value)? onChange;
  final String? labelText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool obscure;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? preIconColor;
  final Color? borderColor;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final TextInputType? textInputType;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? formatter;
  final String? hintText;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late ValueNotifier<bool> _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = ValueNotifier<bool>(widget.obscure);
  }

  @override
  void dispose() {
    _obscureText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(widget.labelText!,
              style: context.theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
          6.verticalSpace,
        ],
        ValueListenableBuilder<bool>(
          valueListenable: _obscureText,
          builder: (context, obscure, child) {
            return TextFormField(
              maxLines: widget.maxLines ?? 1,
              minLines: widget.minLines ?? 1,
              validator: widget.validator,
              readOnly: widget.readOnly,
              focusNode: widget.focusNode,
              inputFormatters: widget.formatter,
              onTap: widget.onTap,
              onFieldSubmitted: widget.onFieldSubmitted,
              initialValue: widget.initialValue,
              style: context.theme.textTheme.titleMedium,
              obscureText: obscure,
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              onChanged: widget.onChange,
              controller: widget.textEditingController,
              cursorColor: AppColors.primaryColor,
              maxLength: widget.maxLength,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: context.theme.textTheme.displayMedium?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.hintColor
                ),
                suffixIconConstraints:
                    const BoxConstraints(minHeight: 25, minWidth: 25),
                prefixIcon:  widget.prefixIcon == null
                    ? widget.leadingWidget
                    : SvgPicture.asset(
                        widget.prefixIcon!,
                        height: 20,
                      ).paddingAll(11),
                suffixIcon: widget.obscure
                    ? ScaleButton(
                        bound: 0.040,
                        onTap: () {
                          _obscureText.value = !_obscureText.value;
                        },
                        child: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: widget.preIconColor ?? AppColors.grey1,
                        ),
                      ).paddingAll(11)
                    : null,
                filled: true,
                fillColor: widget.fillColor ?? context.theme.cardColor,
                border:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: widget.borderColor ??  AppColors.transparent),
                ),
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: widget.borderColor ?? AppColors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.primaryColor,
                    width: 1.2,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.red),
                ),
                disabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: widget.borderColor ?? AppColors.transparent),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
