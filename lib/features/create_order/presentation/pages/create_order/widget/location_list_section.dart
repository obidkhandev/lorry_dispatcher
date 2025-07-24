import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/country_region_model.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/create_order/widget/location_item.dart';
import '../../../../../../export.dart';

class LocationListSection extends StatefulWidget {
  final String title;
  final List<CountryRegionModel> locations;
  final VoidCallback onAddLocation;
  final Function(int) onRemoveLocation;

  const LocationListSection({
    super.key,
    required this.title,
    required this.locations,
    required this.onAddLocation,
    required this.onRemoveLocation,
  });

  @override
  State<LocationListSection> createState() => _LocationListSectionState();
}

class _LocationListSectionState extends State<LocationListSection> {
  late List<CountryRegionModel> locations;

  @override
  void initState() {
    super.initState();
    locations = List.from(widget.locations);
  }

  @override
  void didUpdateWidget(LocationListSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.locations != oldWidget.locations) {
      setState(() {
        locations = List.from(widget.locations);
      });
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = locations.removeAt(oldIndex);
      locations.insert(newIndex, item);
    });
  }

  void _removeLocation(int index) {
    setState(() {
      locations.removeAt(index);
    });
    widget.onRemoveLocation(index);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey2),
      ),
      child: Column(
        children: [
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            onReorder: _onReorder,
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return LocationItem(
                onDelete: () {
                  _removeLocation(index);
                },
                key: Key("${locations[index].name ?? 'unknown'}_$index"),
                color: AppColors.transparent,
                title: locations[index].name ?? 'Unknown',
              );
            },
          ),
          InkWell(
            onTap: widget.onAddLocation,
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.white),
              child: Row(
                children: [
                  const Icon(Icons.add),
                  Text(widget.title, style: AppTextStyles().body16w6),
                ],
              ),
            ),
          ).paddingSymmetric(vertical: 8.h),
        ],
      ).paddingAll(16.sp),
    );
  }
}
