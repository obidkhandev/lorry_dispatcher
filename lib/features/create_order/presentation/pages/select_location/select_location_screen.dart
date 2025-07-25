import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_bloc.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_event.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/map/map_state.dart';
import 'package:lorry_dispatcher/features/map/presentation/bloc/driver_tracking/driver_tracking_event.dart';

class SelectLocationFromMapScreen extends StatefulWidget {
  const SelectLocationFromMapScreen({super.key});

  @override
  State<SelectLocationFromMapScreen> createState() =>
      _SelectLocationFromMapScreenState();
}

class _SelectLocationFromMapScreenState
    extends State<SelectLocationFromMapScreen> {
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          final bloc = context.read<MapBloc>();
          // print("state error: ${state.error}");
          return Stack(
            children: [
              // Google Map
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  bloc.add(InitializeMapEvent(controller));
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(state.latitude, state.longitude),
                  zoom: state.zoom,
                ),
                onCameraMove: (CameraPosition position) {
                  context.read<MapBloc>().add(UpdateCameraPositionEvent(
                    latitude: position.target.latitude,
                    longitude: position.target.longitude,
                    zoom: position.zoom,
                  ));
                },
                markers: state.markers, // state.markers ishlatiladi
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),

              // Control buttons
              Positioned(
                right: 16,
                top: 100,
                child: Column(
                  children: [
                    // Find Me button
                    FloatingActionButton(
                      heroTag: "find_me",
                      onPressed: () {
                        context.read<MapBloc>().add(GetUserLocationEvent());
                      },
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.my_location, color: Colors.white),
                    ),
                    const SizedBox(height: 10),

                    // Zoom In button
                    FloatingActionButton.small(
                      heroTag: "zoom_in",
                      onPressed: () {
                        context.read<MapBloc>().add(ZoomInEvent());
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.add, color: Colors.black),
                    ),
                    const SizedBox(height: 10),

                    // Zoom Out button
                    FloatingActionButton.small(
                      heroTag: "zoom_out",
                      onPressed: () {
                        context.read<MapBloc>().add(ZoomOutEvent());
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.remove, color: Colors.black),
                    ),
                  ],
                ),
              ),

              // Center marker (for location selection)
              Center(child: SvgPicture.asset(AppIcons.currentLocation))

              // Confirm button
              // CustomButton(),
            ],
          );
        },
      ),
    );
  }



  void _updateUserLocationMarker(double latitude, double longitude) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: LatLng(latitude, longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });
  }

}