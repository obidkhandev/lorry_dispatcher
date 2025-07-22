import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorry_dispatcher/core/utills/extensions.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';
import 'package:lorry_dispatcher/core/values/app_icons.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';

class CustomSearchableDropDownWidget extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final String? initValue;
  final TextStyle? hintStyle, textStyle;
  final Color? backgroundColor, borderColor, iconColor;
  final double? width;
  final Function(String? value)? onChanged;
  final String? label;
  final String? validator;
  final bool visibleClose;
  final String searchHintText;
  final bool enableSearch;

  const CustomSearchableDropDownWidget({
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
    this.visibleClose = true,
    this.searchHintText = 'Search...',
    this.enableSearch = true,
  });

  @override
  State<CustomSearchableDropDownWidget> createState() => _CustomSearchableDropDownWidgetState();
}

class _CustomSearchableDropDownWidgetState extends State<CustomSearchableDropDownWidget> {
  String? selectedValue;
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  List<String> filteredItems = [];
  bool isDropdownOpen = false;
  int hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initValue;
    if (selectedValue != null) {
      textController.text = selectedValue!;
    }
    filteredItems = List.from(widget.items);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _openDropdown();
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    _closeDropdown();
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
      hoveredIndex = -1;
    });
    _updateOverlay();
  }

  void _openDropdown() {
    if (isDropdownOpen) return;

    isDropdownOpen = true;
    overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(overlayEntry!);
  }

  void _closeDropdown() {
    if (!isDropdownOpen) return;

    isDropdownOpen = false;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void _updateOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.markNeedsBuild();
    }
  }

  void _selectItem(String item) {
    setState(() {
      selectedValue = item;
      textController.text = item;
    });
    _closeDropdown();
    focusNode.unfocus();
    if (widget.onChanged != null) {
      widget.onChanged!(item);
    }
  }

  void _clearSelection() {
    setState(() {
      selectedValue = null;
      textController.clear();
    });
    _filterItems('');
    if (widget.onChanged != null) {
      widget.onChanged!(null);
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _closeDropdown();
          focusNode.unfocus();
        },
        child: Stack(
          children: [
            // Invisible overlay to catch outside clicks
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            // Actual dropdown content
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 4,
              width: widget.width ?? size.width,
              child: GestureDetector(
                onTap: () {}, // Prevent closing when clicking inside dropdown
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8.r),
                  color: widget.backgroundColor ?? Theme.of(context).cardColor,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: widget.borderColor ?? AppColors.borderSecondary,
                      ),
                    ),
                    child: filteredItems.isEmpty
                        ? Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'No items found',
                        style: widget.textStyle ??
                            context.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.borderSecondary,
                            ),
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final isHovered = index == hoveredIndex;

                        return MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              hoveredIndex = index;
                            });
                            _updateOverlay();
                          },
                          onExit: (_) {
                            setState(() {
                              hoveredIndex = -1;
                            });
                            _updateOverlay();
                          },
                          child: InkWell(
                            onTap: () => _selectItem(item),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: isHovered
                                    ? (context.theme.primaryColor.withOpacity(0.1))
                                    : Colors.transparent,
                                border: index < filteredItems.length - 1
                                    ? Border(
                                  bottom: BorderSide(
                                    color: AppColors.borderSecondary.withOpacity(0.2),
                                    width: 1,
                                  ),
                                )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: widget.textStyle ??
                                          context.theme.textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: isHovered
                                                ? context.theme.primaryColor
                                                : null,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        CompositedTransformTarget(
          link: layerLink,
          child: Container(
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? context.theme.cardColor,
              border: widget.borderColor == null
                  ? Border.all(color: AppColors.borderSecondary)
                  : Border.all(color: widget.borderColor!),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    focusNode: focusNode,
                    style: widget.textStyle ??
                        context.theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    decoration: InputDecoration(
                      hintText: selectedValue == null ? widget.hintText : null,
                      hintStyle: widget.hintStyle ??
                          AppTextStyles().body16w4.copyWith(
                            color: AppColors.borderSecondary,
                          ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                    ),
                    onChanged: (value) {
                      if (widget.enableSearch) {
                        _filterItems(value);
                        if (!isDropdownOpen) {
                          _openDropdown();
                        }
                      }
                    },
                    onTap: () {
                      if (!isDropdownOpen) {
                        _openDropdown();
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    if (selectedValue != null && widget.visibleClose)
                      GestureDetector(
                        onTap: _clearSelection,
                        child: SvgPicture.asset(
                          AppIcons.cancel,
                          // height: 12,
                          // width: 12,
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        if (isDropdownOpen) {
                          _closeDropdown();
                          focusNode.unfocus();
                        } else {
                          focusNode.requestFocus();
                          _openDropdown();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: AnimatedRotation(
                          turns: isDropdownOpen ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: SvgPicture.asset(
                            AppIcons.arrowDown,
                            width: 18,
                            color: widget.iconColor ??
                                context.theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}