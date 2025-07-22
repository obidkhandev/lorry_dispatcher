import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

import '../../../export.dart';



class CustomMultiSelectDropDownWidget extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final List<String>? initValues;
  final TextStyle? hintStyle, textStyle;
  final Color? backgroundColor, borderColor, iconColor;
  final double? width;
  final Function(List<String> selectedValues)? onChanged;
  final String? label;
  final String? validator;
  final int? maxSelections; // Optional limit on selections
  final String? separatorText; // Text to show between selected items
  final bool enableSearch; // Enable/disable search functionality
  final String? searchHintText; // Search hint text

  const CustomMultiSelectDropDownWidget({
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
    this.initValues,
    this.validator,
    this.label,
    this.maxSelections,
    this.separatorText = ', ',
    this.enableSearch = false,
    this.searchHintText = 'Search...',
  });

  @override
  State<CustomMultiSelectDropDownWidget> createState() =>
      _CustomMultiSelectDropDownWidgetState();
}

class _CustomMultiSelectDropDownWidgetState
    extends State<CustomMultiSelectDropDownWidget> {
  List<String> selectedValues = [];
  List<String> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initValues ?? [];
    filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredItems = widget.items;
      } else {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  String get displayText {
    if (selectedValues.isEmpty) {
      return widget.hintText;
    }

    // If too many selections, show count
    if (selectedValues.length > 3) {
      return '${selectedValues.length} ta tanlandi';
    }

    // Show selected items separated by comma
    return selectedValues.join(widget.separatorText ?? ', ');
  }

  void _toggleSelection(String item) {
    setState(() {
      if (selectedValues.contains(item)) {
        selectedValues.remove(item);
      } else {
        // Check max selections limit
        if (widget.maxSelections == null ||
            selectedValues.length < widget.maxSelections!) {
          selectedValues.add(item);
        }
      }
    });

    if (widget.onChanged != null) {
      widget.onChanged!(selectedValues);
    }
  }

  void _clearSelections() {
    setState(() {
      selectedValues.clear();
    });

    if (widget.onChanged != null) {
      widget.onChanged!(selectedValues);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      filteredItems = widget.items;
    });
  }

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.theme.cardColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey3.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 18.w,
            color: AppColors.grey2,
          ),
          8.horizontalSpace,
          Expanded(
            child: TextField(
              controller: _searchController,
              style: widget.textStyle ?? AppTextStyles().body16w4,
              decoration: InputDecoration(
                hintText: widget.searchHintText,
                hintStyle: widget.hintStyle ??
                    AppTextStyles()
                        .body16w4
                        .copyWith(color: AppColors.hintColor),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty) ...[
            8.horizontalSpace,
            GestureDetector(
              onTap: _clearSearch,
              child: Icon(
                Icons.clear,
                size: 18.w,
                color: AppColors.grey2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNoResultsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            size: 32.w,
            color: AppColors.grey3,
          ),
          8.verticalSpace,
          Text(
            'No results found',
            style: AppTextStyles().body14w5.copyWith(color: AppColors.grey3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.label!,
                  style: context.theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                ),
                TextSpan(
                  text: widget.validator != null ? " *" : "",
                  style:
                      AppTextStyles().body14w5.copyWith(color: AppColors.red),
                )
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
                    : Border.all(color: widget.borderColor ?? AppColors.grey3),
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
                  if (selectedValues.isNotEmpty)
                    GestureDetector(
                      onTap: _clearSelections,
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
                    color: widget.iconColor ??
                        context.theme.textTheme.bodyMedium?.color,
                  ),
                ],
              ),
            ),
            // We don't use value for multi-select, so it's always null
            value: null,
            hint: Text(
              displayText,
              style: selectedValues.isEmpty
                  ? (widget.hintStyle ??
                      AppTextStyles()
                          .body16w4
                          .copyWith(color: AppColors.hintColor))
                  : (widget.textStyle ??
                      AppTextStyles().body16w4.copyWith(
                          color: context.theme.textTheme.bodyMedium?.color)),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            items: _buildDropdownItems(),
            onChanged: (String? value) {
              // This is required by DropdownButton2 but we handle selection in InkWell
              // Don't handle selection here to avoid conflicts
            },
            // Custom dropdown search
            dropdownSearchData: widget.enableSearch
                ? DropdownSearchData<String>(
                    searchController: _searchController,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: _buildSearchField(),
                    searchMatchFn: (item, searchValue) {
                      return item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue.toLowerCase());
                    },
                  )
                : null,
            // Prevent dropdown from closing on selection
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                // Clear search when dropdown closes
                _clearSearch();
              }
            },
          ),
        ),

        // Show selected items as chips (optional)
        if (selectedValues.isNotEmpty && selectedValues.length <= 4) ...[
          8.verticalSpace,
          Wrap(
            spacing: 6.w,
            runSpacing: 4.h,
            children: selectedValues.map((value) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border:
                      Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value,
                      style: context.theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    4.horizontalSpace,
                    GestureDetector(
                      onTap: () => _toggleSelection(value),
                      child: Icon(
                        Icons.close,
                        size: 14.w,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    // Use the built-in search functionality of DropdownButton2
    if (widget.enableSearch) {
      return widget.items.map((String item) {
        return _buildDropdownItem(item);
      }).toList();
    }

    // Use manual filtering if search is disabled
    return filteredItems.map((String item) {
      return _buildDropdownItem(item);
    }).toList();
  }

  DropdownMenuItem<String> _buildDropdownItem(String item) {
    return DropdownMenuItem<String>(
      value: item,
      enabled: true, // Always keep enabled to handle taps properly
      child: StatefulBuilder(
        builder: (context, menuSetState) {
          // Check selection state each time the builder runs
          final currentlySelected = selectedValues.contains(item);
          final currentlyDisabled = widget.maxSelections != null &&
              selectedValues.length >= widget.maxSelections! &&
              !currentlySelected;

          return InkWell(
            onTap: currentlyDisabled
                ? null
                : () {
                    _toggleSelection(item);
                    // Update the dropdown menu state to reflect changes
                    menuSetState(() {});
                  },
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  // Checkbox
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: currentlySelected
                            ? AppColors.primaryColor
                            : (currentlyDisabled
                                ? AppColors.grey3
                                : AppColors.grey2),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                      color: currentlySelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                    child: currentlySelected
                        ? Icon(
                            Icons.check,
                            size: 14.w,
                            color: AppColors.white,
                          )
                        : null,
                  ),
                  12.horizontalSpace,
                  // Text
                  Expanded(
                    child: Text(
                      item,
                      style: (widget.textStyle ?? AppTextStyles().body16w4)
                          .copyWith(
                        color: currentlyDisabled
                            ? AppColors.grey3
                            : (currentlySelected
                                ? AppColors.primaryColor
                                : null),
                        fontWeight: currentlySelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
