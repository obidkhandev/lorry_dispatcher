import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationInfoBottomSheet extends StatelessWidget {
  final LocationItemModel location;
  final VoidCallback onContinue;
  final VoidCallback onBackToSearch;

  const LocationInfoBottomSheet({
    Key? key,
    required this.location,
    required this.onContinue,
    required this.onBackToSearch,
  }) : super(key: key);

  IconData _getLocationTypeIcon(SuggestItemType? type) {
    switch (type) {
      case SuggestItemType.toponym:
        return Icons.location_on;
      case SuggestItemType.business:
        return Icons.business;
      case SuggestItemType.transit:
        return Icons.directions_transit;
      case SuggestItemType.unknown:
      default:
        return Icons.place;
    }
  }

  Color _getLocationTypeColor(SuggestItemType? type) {
    switch (type) {
      case SuggestItemType.toponym:
        return Colors.green;
      case SuggestItemType.business:
        return Colors.blue;
      case SuggestItemType.transit:
        return Colors.orange;
      case SuggestItemType.unknown:
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tanlangan joy",
                style: context.theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onBackToSearch,
                child: Icon(Icons.close, color: Colors.grey[600]),
              ),
            ],
          ),

          12.verticalSpace,

          // DecoratedBox(
          //   decoration: BoxDecoration(
          //     color: _getLocationTypeColor(location.type).withOpacity(0.1),
          //     borderRadius: BorderRadius.circular(6.r),
          //   ),
          //   child: Icon(
          //     _getLocationTypeIcon(location.type),
          //     size: 16.sp,
          //     color: _getLocationTypeColor(location.type),
          //   ).paddingSymmetric(horizontal: 10.w, vertical: 6.h),
          // ),
          // 10.horizontalSpace,
          Text(
            location.title,
            style: context.theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          8.verticalSpace,

          // Location Description
          if (location.subtitle.isNotEmpty) ...[
            Text(
              location.subtitle,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            16.verticalSpace,
          ],

          CustomButton(
            onTap: onContinue,
            text: "Bu joyni tanlash",
          ).paddingOnly(bottom: customButtonPadding),
        ],
      ).paddingSymmetric(horizontal: 16.w),
    );
  }
}
