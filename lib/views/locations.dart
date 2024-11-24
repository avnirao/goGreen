import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<LatLng> locations = [];  // Store dynamically added locations

  final _positionStream =
      const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream(
    stream: Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 50,
        timeLimit: Duration(minutes: 1),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Map'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(51.509364, -0.128928),
                initialZoom: 15,
                maxZoom: 19,
                minZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/512/{z}/{x}/{y}@2x?access_token=YOUR_ACCESS_TOKEN',
                  userAgentPackageName: 'com.yourapp.app',
                ),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    markers: locations
                        .map(
                          (location) => Marker(
                            point: location,
                            builder: (ctx) => const Icon(
                              Icons.pin_drop,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                CurrentLocationLayer(
                  positionStream: _positionStream,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _addLocation,
              child: const Text('Add Random Location'),
            ),
          ),
        ],
      ),
    );
  }

  // Adds a random location to the map
  void _addLocation() {
    setState(() {
      // For now, we're adding a random location nearby the initial center
      locations.add(LatLng(51.509364 + 0.01, -0.128928 + 0.01));
    });
  }
}
