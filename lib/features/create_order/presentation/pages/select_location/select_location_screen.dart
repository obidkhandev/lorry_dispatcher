import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/services/location/location_service.dart';
import 'package:lorry_dispatcher/core/values/app_assets.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_bloc.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_event.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/select_location/widget/location_search_bottom_sheet.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/select_location/widget/location_info_bottom_sheet.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SelectLocationFromMapScreen extends StatefulWidget {
  final String title;

  const SelectLocationFromMapScreen({
    super.key,
    this.title = "Yuklash manzili",
  });

  @override
  State<SelectLocationFromMapScreen> createState() =>
      _SelectLocationFromMapScreenState();
}

class _SelectLocationFromMapScreenState
    extends State<SelectLocationFromMapScreen>
    with TickerProviderStateMixin {
  LocationItemModel? _selectedLocation;
  bool _isLocationSelected = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectLocation(LocationItemModel location) {
    setState(() {
      _selectedLocation = location;
      _isLocationSelected = true;
    });

    // Add selected location marker to map
    context.read<MapBloc>().add(
      AddSelectedLocationMarkerEvent(location: location),
    );

    // Start animation to show info bottom sheet
    _animationController.forward();
  }

  void _onContinue() {
    context.pop(_selectedLocation);
  }

  void _onBackToSearch() {
    setState(() {
      _selectedLocation = null;
      _isLocationSelected = false;
    });

    // Remove selected location marker
    context.read<MapBloc>().add(RemoveSelectedLocationMarkerEvent());

    // Animate back to search bottom sheet
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          final bloc = context.read<MapBloc>();
          return Stack(
            children: [
              // Yandex Map
              YandexMap(
                nightModeEnabled: context.isDarkMode,
                onMapCreated: (YandexMapController controller) {
                  bloc.add(InitializeMapEvent(controller));
                  controller.toggleUserLayer(visible: true);
                },
                onUserLocationAdded: (UserLocationView view) async {
                  return locationService.onUserLocationAdded(view, state);
                },
                mapObjects: locationService
                    .buildClusterizedPlacemarkCollection(state)
                    .placemarks,
                onCameraPositionChanged: (cameraPosition, _, isFinished) {
                  if (isFinished && !_isLocationSelected) {
                    bloc.add(
                      UpdateCameraPositionEvent(
                        latitude: cameraPosition.target.latitude,
                        longitude: cameraPosition.target.longitude,
                        zoom: cameraPosition.zoom,
                      ),
                    );
                  }
                },
              ),

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.52,
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset("assets/icons/map/map_building_ic.svg"),
              ),

              // Back button
              Positioned(
                top: 70.h,
                left: 16.w,
                child: FloatingActionButton(
                  heroTag: "back_button",
                  onPressed: () => context.pop(),
                  backgroundColor: context.theme.cardColor,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              // Control buttons (zoom in, zoom out, find me)
              Positioned(
                right: 16.w,
                bottom: MediaQuery.of(context).size.height * 0.5,
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
                right: 16.w,
                left: 16.w,
                bottom: MediaQuery.of(context).size.height * 0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: "history",
                      onPressed: () {
                        // context.push(AppRoutes);
                      },
                      backgroundColor: context.theme.cardColor,
                      child: Icon(Icons.history, color: AppColors.primaryColor),
                    ),

                  ],
                ),
              ),

              // Current location indicator (faqat location tanlanmaganda ko'rsatish)
              if (!_isLocationSelected)
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.46,
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset(AppIcons.currentLocation),
                ),

              // Animated Bottom Sheets Container
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: _selectedLocation != null
                      ? LocationInfoBottomSheet(
                          location: _selectedLocation!,
                          onContinue: _onContinue,
                          onBackToSearch: _onBackToSearch,
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: LocationSearchBottomSheet(
                            title: widget.title,
                            selectedLocation: _selectedLocation,
                            onLocationSelected: _selectLocation,
                            onContinue: _onContinue,
                            recentLocations: [],
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
