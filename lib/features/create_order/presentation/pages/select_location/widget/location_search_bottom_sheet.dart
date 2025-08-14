import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_bloc.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_event.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';

class LocationSearchBottomSheet extends StatefulWidget {
  final String title;
  final LocationItemModel? selectedLocation;
  final Function(LocationItemModel) onLocationSelected;
  final VoidCallback onContinue;
  final List<LocationItemModel> recentLocations;

  const LocationSearchBottomSheet({
    super.key,
    required this.title,
    this.selectedLocation,
    required this.onLocationSelected,
    required this.onContinue,
    this.recentLocations = const [],
  });

  @override
  State<LocationSearchBottomSheet> createState() =>
      _LocationSearchBottomSheetState();
}

class _LocationSearchBottomSheetState extends State<LocationSearchBottomSheet>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedLocation != null) {
      _searchController.text = widget.selectedLocation!.title;
    }

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: 0.3,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus && !_isExpanded) {
        _expandBottomSheet();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _expandBottomSheet() {
    setState(() {
      _isExpanded = true;
    });
    _animationController.forward();
  }

  void _collapseBottomSheet() {
    setState(() {
      _isExpanded = false;
    });
    _animationController.reverse();
    _searchFocusNode.unfocus();
  }

  Widget _buildLocationItem(LocationItemModel location) {
    final isSelected = widget.selectedLocation?.title == location.title;

    return InkWell(
      onTap: () => widget.onLocationSelected(location),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: location.isRecent
                    ? AppColors.primaryOpacity
                    : AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                location.isRecent ? Icons.history : Icons.location_on,
                color: location.isRecent
                    ? AppColors.black
                    : AppColors.primaryColor,
                size: 20.sp,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.title,
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isSelected ? AppColors.primaryColor : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Text(
                    location.subtitle,
                    style: context.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.grey2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 8.h),
      child: Text(
        title,
        style: context.theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptySearchResults() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48.sp,
              color: AppColors.grey2,
            ),
            16.verticalSpace,
            Text(
              "Hech narsa topilmadi",
              style: context.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.grey2,
              ),
            ),
            8.verticalSpace,
            Text(
              "Boshqa so'z bilan qidiring",
              style: context.theme.textTheme.bodySmall?.copyWith(
                color: AppColors.grey2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedContent() {
    return Column(
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 60.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),

        // Header
        16.verticalSpace,
        Text(
          widget.title,
          style: context.theme.textTheme.titleMedium,
        ).paddingOnly(left: 16.w),

        // Search field (collapsed state)
        16.verticalSpace,
        GestureDetector(
          onTap: _expandBottomSheet,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.grey2,
                  size: 20.sp,
                ),
                12.horizontalSpace,
                Text(
                  "Manzil qidiring...",
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey2,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_up,
                  color: AppColors.grey2,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // Continue button (collapsed state)
        Container(
          color: context.theme.cardColor,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 30.h),
          child: CustomButton(
            height: 55.h,
            text: widget.selectedLocation != null
                ? "Tanlangan manzil bilan davom etish"
                : "Joriy joylashuv bilan davom etish",
            onTap: widget.onContinue,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      children: [
        // Header with close button
        Container(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Row(
            children: [
              Text(
                widget.title,
                style: context.theme.textTheme.titleMedium,
              ),
              const Spacer(),
              GestureDetector(
                onTap: _collapseBottomSheet,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey2.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.grey2,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Search field (expanded state)
        16.verticalSpace,
        CustomTextField(
          textEditingController: _searchController,
          focusNode: _searchFocusNode,
          hintText: "Manzil qidiring...",
          borderColor: AppColors.grey2,
          onChange: (v) {
            context.read<MapBloc>().add(
              SearchByQueryEvent(v),
            );
          },
          leadingWidget: Icon(
            Icons.search,
            color: AppColors.grey2,
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            onPressed: () {
              setState(() {
                _searchController.clear();
              });
              context.read<MapBloc>().add(
                SearchByQueryEvent(''),
              );
            },
            icon: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return state.isLoading
                    ? CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                )
                    : Icon(
                  Icons.clear,
                  color: AppColors.grey2,
                  size: 20.sp,
                );
              },
            ),
          )
              : null,
        ).paddingSymmetric(horizontal: 16.w),

        // Content
        Expanded(
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search results
                BlocBuilder<MapBloc, MapState>(
                  builder: (context, searchLocation) {
                    if (_searchController.text.isEmpty) {
                      // Show recent locations when search is empty
                      if (widget.recentLocations.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader("Yaqinda qidirilgan"),
                            ...widget.recentLocations.map(
                                  (location) => _buildLocationItem(location),
                            ),
                          ],
                        );
                      }
                      return SizedBox(height: 100.h);
                    }

                    if (searchLocation.suggestionItem.isEmpty) {
                      return _buildEmptySearchResults();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchLocation.suggestionItem.length,
                      itemBuilder: (context, index) {
                        final item = searchLocation.suggestionItem[index];
                        return _buildLocationItem(
                          LocationItemModel(
                            type: item.type,
                            title: item.title,
                            subtitle: item.displayText,
                            latitude: item.center?.latitude ?? 0,
                            longitude: item.center?.longitude ?? 0,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),

        // Continue button (expanded state)
        Container(
          color: context.theme.cardColor,
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 30.h),
          child: CustomButton(
            height: 55.h,
            text: widget.selectedLocation != null
                ? "Tanlangan manzil bilan davom etish"
                : "Joriy joylashuv bilan davom etish",
            onTap: widget.onContinue,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return DraggableScrollableSheet(
          initialChildSize: _heightAnimation.value,
          minChildSize: _heightAnimation.value,
          maxChildSize: _heightAnimation.value,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: _isExpanded ? _buildExpandedContent() : _buildCollapsedContent(),
            );
          },
        );
      },
    );
  }
}