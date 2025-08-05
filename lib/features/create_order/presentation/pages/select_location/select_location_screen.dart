import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/services/location/location_service.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';
import 'package:lorry_dispatcher/features/create_order/data/mock.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_bloc.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_event.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SelectLocationFromMapScreen extends StatefulWidget {
  const SelectLocationFromMapScreen({super.key});

  @override
  State<SelectLocationFromMapScreen> createState() =>
      _SelectLocationFromMapScreenState();
}

class _SelectLocationFromMapScreenState
    extends State<SelectLocationFromMapScreen> {
  final TextEditingController _searchController = TextEditingController();
  LocationItemModel? _selectedLocation;
  final LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectLocation(LocationItemModel location) {
    setState(() {
      _selectedLocation = location;
      _searchController.text = location.title;
    });

    context.read<MapBloc>().state.controller?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: location.latitude,
            longitude: location.longitude,
          ),
          zoom: 15,
        ),
      ),
    );

    // Update map position
    context.read<MapBloc>().add(
      UpdateCameraPositionEvent(
        latitude: location.latitude,
        longitude: location.longitude,
        zoom: 15.0,
      ),
    );
  }

  Widget _buildLocationItem(LocationItemModel location) {
    final isSelected = _selectedLocation?.title == location.title;

    return InkWell(
      onTap: () => _selectLocation(location),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          // border: isSelected
          //     ? Border.all(color: AppColors.primaryColor, width: 1)
          //     : null,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          final bloc = context.read<MapBloc>();
          return Stack(
            children: [
              YandexMap(
                nightModeEnabled: context.isDarkMode,
                onMapCreated: (YandexMapController controller) {
                  bloc.add(InitializeMapEvent(controller));
                  controller.toggleUserLayer(visible: true);
                },
                onUserLocationAdded: (UserLocationView view) async {
                  return locationService.onUserLocationAdded(view, state);
                },
                mapObjects: [
                  locationService.buildClusterizedPlacemarkCollection(state),
                ],
                onCameraPositionChanged: (cameraPosition, _, isFinished) {
                  if (isFinished) {
                    bloc.add(
                      UpdateCameraPositionEvent(
                        latitude: cameraPosition.target.latitude,
                        longitude: cameraPosition.target.longitude,
                        zoom: cameraPosition.zoom,
                      ),
                    );
                    bloc.add(
                      SearchByPointEvent(
                        point: cameraPosition.target,
                        onSuccess: (v) {
                          if (v.isNotEmpty) {
                            _searchController.text = v;
                          }
                        },
                      ),
                    );
                  }
                },
              ),

              Positioned(
                top: 70.h,
                left: 16.w,
                child: FloatingActionButton(
                  heroTag: "back_button",
                  onPressed: () {
                    context.pop();
                  },
                  backgroundColor: context.theme.cardColor,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              // Control buttons
              Positioned(
                right: 16.w,
                bottom: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: "zoom_in",
                      onPressed: () {
                        context.read<MapBloc>().add(ZoomInEvent());
                      },
                      backgroundColor: context.theme.cardColor,
                      child: Icon(
                        Icons.add,
                        size: 30.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    10.verticalSpace,
                    FloatingActionButton(
                      heroTag: "zoom_out",
                      onPressed: () {
                        context.read<MapBloc>().add(ZoomOutEvent());
                      },
                      backgroundColor: context.theme.cardColor,
                      child: Icon(
                        Icons.remove,
                        size: 30.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    10.verticalSpace,
                    FloatingActionButton(
                      heroTag: "find_me",
                      onPressed: () {
                        context.read<MapBloc>().add(GetUserLocationEvent());
                      },
                      backgroundColor: context.theme.cardColor,
                      child: Icon(
                        Icons.my_location,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.46,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(AppIcons.currentLocation),
              ),

              // Enhanced bottom sheet
              DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.35,
                maxChildSize: 0.8,
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
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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

                              16.verticalSpace,
                              Text(
                                "Yuklash manzili",
                                style: context.theme.textTheme.titleMedium,
                              ).paddingOnly(left: 16.w),
                              16.verticalSpace,
                              CustomTextField(
                                textEditingController: _searchController,
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
                                          _searchController.clear();
                                          _selectedLocation = null;
                                        },
                                        icon: state.isLoading
                                            ? CupertinoActivityIndicator(
                                                color: AppColors.primaryColor,
                                              )
                                            : Icon(
                                                Icons.clear,
                                                color: AppColors.grey2,
                                                size: 20.sp,
                                              ),
                                      )
                                    : null,
                              ).paddingSymmetric(horizontal: 16.w),

                              BlocBuilder<MapBloc, MapState>(
                                builder: (context, searchLocation) {
                                  if (searchLocation.suggestionItem.isEmpty) {
                                    return Center(
                                      child: Container(
                                        padding: EdgeInsets.all(32.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.search_off,
                                              size: 48.sp,
                                              color: AppColors.grey2,
                                            ),
                                            16.verticalSpace,
                                            Text(
                                              "Hech narsa topilmadi",
                                              style: context
                                                  .theme
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: AppColors.grey2,
                                                  ),
                                            ),
                                            8.verticalSpace,
                                            Text(
                                              "Boshqa so'z bilan qidiring",
                                              style: context
                                                  .theme
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: AppColors.grey2,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        searchLocation.suggestionItem.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          searchLocation.suggestionItem[index];

                                      return _buildLocationItem(
                                        LocationItemModel(
                                          title: item.title,
                                          subtitle: item.displayText,
                                          latitude: item.center?.latitude ?? 0,
                                          longitude:
                                              item.center?.longitude ?? 0,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (recentLocations.isNotEmpty) ...[
                                    _buildSectionHeader("Yaqinda qidirilgan"),
                                    ...recentLocations.map(
                                      (location) =>
                                          _buildLocationItem(location),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 16.w,
                          right: 16.w,
                          child: ColoredBox(
                            color: context.theme.cardColor,
                            child: CustomButton(
                              height: 55.h,
                              text: _selectedLocation != null
                                  ? "Tanlangan manzil bilan davom etish"
                                  : "Joriy joylashuv bilan davom etish",
                              onTap: () {
                                // Handle continue action
                                if (_selectedLocation != null) {
                                  // Use selected location
                                  print(
                                    "Selected: ${_selectedLocation!.title}",
                                  );
                                } else {
                                  // Use current map center location
                                  print("Using current map location");
                                }
                                context.pop(_selectedLocation);
                              },
                            ).paddingOnly(bottom: 30),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
