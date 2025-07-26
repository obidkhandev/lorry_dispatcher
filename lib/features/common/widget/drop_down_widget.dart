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
  final String searchHintText;
  final bool enableSearch;
  final double? height;

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
    this.searchHintText = 'Search...',
    this.enableSearch = true,
    this.height,
  });

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  String? selectedValue;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
    filteredItems = List.from(widget.items);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = List.from(widget.items);
      } else {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _clearSearch() {
    searchController.clear();
    _filterItems('');
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
                  style: context.theme.textTheme.titleMedium?.copyWith(
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
              height: widget.height ?? 46.h,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? context.theme.cardColor,
                border: Border.all(
                        color: context.isDarkMode
                            ? widget.borderColor ?? AppColors.grey808080
                            : widget.borderColor ?? AppColors.grey2,
                      ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? context.theme.cardColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              width: widget.width ?? MediaQuery.of(context).size.width - 32,
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            dropdownSearchData: widget.enableSearch
                ? DropdownSearchData(
                    searchController: searchController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          hintText: widget.searchHintText,
                          hintStyle: AppTextStyles().body16w4.copyWith(
                            color: AppColors.borderSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color:
                                  widget.borderColor ??
                                  AppColors.borderSecondary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: context.theme.primaryColor,
                              width: 2,
                            ),
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: SvgPicture.asset(
                                    AppIcons.cancel,
                                    height: 12,
                                    width: 12,
                                  ),
                                  onPressed: _clearSearch,
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          _filterItems(value);
                        },
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return item.value?.toLowerCase().contains(
                            searchValue.toLowerCase(),
                          ) ??
                          false;
                    },
                  )
                : null,
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
                        AppIcons.cancel,
                        height: 16,
                        width: 16,
                      ),
                    ),
                  8.horizontalSpace,
                  SvgPicture.asset(
                    AppIcons.arrowDown,
                    width: 18,
                    color:
                        widget.iconColor ??
                        context.theme.textTheme.titleMedium?.color,
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
                  fontWeight: FontWeight.w500,
                ),
            items: widget.items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Row(
                  children: [
                    Text(
                      item,
                      style:
                          widget.textStyle ??
                          context.theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
              // Clear search when item is selected
              _clearSearch();
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                // Clear search when dropdown closes
                _clearSearch();
              }
            },
          ),
        ),
      ],
    );
  }
}
