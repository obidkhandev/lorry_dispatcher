import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/features/map/presentation/bloc/driver_tracking/driver_tracking_bloc.dart';
import 'package:lorry_dispatcher/features/map/presentation/bloc/driver_tracking/driver_tracking_event.dart';
import 'package:lorry_dispatcher/features/map/presentation/bloc/driver_tracking/driver_tracking_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;

class DriverTrackingScreen extends StatefulWidget {
  final google.LatLng? startPoint;
  final google.LatLng? endPoint;

  const DriverTrackingScreen({this.startPoint, this.endPoint, super.key});

  @override
  _DriverTrackingScreenState createState() => _DriverTrackingScreenState();
}

class _DriverTrackingScreenState extends State<DriverTrackingScreen>
    with TickerProviderStateMixin {
  late google.GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(google.GoogleMapController controller) {
    _mapController = controller;
    context.read<DriverTrackingBloc>().add(SetMapController(_mapController));
    context.read<DriverTrackingBloc>().add(
      InitializeTracking(
        startPoint: widget.startPoint,
        endPoint: widget.endPoint,
      ),
    );
  }

  void _showRouteCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Route Completed'),
        content: const Text('The driver has reached the destination.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<DriverTrackingBloc>().add(ResetSimulation());
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverTrackingBloc, DriverTrackingState>(
      listener: (context, state) {
        if (state.status == TrackingStatus.completed) {
          _showRouteCompletedDialog();
        } else if (state.status == TrackingStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.errorMessage}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Driver Tracking'),
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => context.read<DriverTrackingBloc>().add(ResetSimulation()),
                tooltip: 'Restart Simulation',
              ),
              IconButton(
                icon: const Icon(Icons.center_focus_strong),
                onPressed: () => context.read<DriverTrackingBloc>().add(CenterOnDriver()),
                tooltip: 'Center on Driver',
              ),
              IconButton(
                icon: const Icon(Icons.map),
                onPressed: () => context.read<DriverTrackingBloc>().add(ShowFullRoute()),
                tooltip: 'Show Full Route',
              ),
            ],
          ),
          body: Stack(
            children: [
              google.GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const google.CameraPosition(
                  target: google.LatLng(25.234369457896325, 55.280222457968712),
                  zoom: 12,
                ),
                markers: state.placemarks != null ? Set<google.Marker>.from(state.placemarks!.values) : {},
                polylines: state.polylines != null ? Set<google.Polyline>.from(state.polylines!.values) : {},
                onCameraMove: (position) {},
              ),
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.blue),
                            const SizedBox(width: 8),
                            const Text(
                              'Current Position:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (state.currentDriverPosition != null)
                          Text(
                            'Lat: ${state.currentDriverPosition!.latitude.toStringAsFixed(6)}\n'
                                'Lng: ${state.currentDriverPosition!.longitude.toStringAsFixed(6)}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.grey[700],
                            ),
                          ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.route, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'Progress: ${state.currentPointIndex + 1}/${state.routePoints.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        if (state.status == TrackingStatus.loading)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Column(
                  children: [
                    FloatingActionButton(
                      onPressed: state.status == TrackingStatus.idle || state.status == TrackingStatus.completed
                          ? () => context.read<DriverTrackingBloc>().add(StartLocationSimulation())
                          : null,
                      child: const Icon(Icons.play_arrow),
                      tooltip: 'Start Simulation',
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      onPressed: state.status == TrackingStatus.running
                          ? () => context.read<DriverTrackingBloc>().add(StopLocationSimulation())
                          : null,
                      child: const Icon(Icons.stop),
                      tooltip: 'Stop Simulation',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}