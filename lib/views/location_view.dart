import 'package:flutter/material.dart';
import 'package:go_green/models/recycling_center.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_green/providers/position_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
class MapView extends StatelessWidget {
  final PositionProvider positionProvider;
  final List<RecyclingCenter> recyclingCenters; // List of recycling centers

  //creates a positionStream for currentLocation marker on map
  final _positionStream = LocationMarkerDataStreamFactory().fromGeolocatorPositionStream(
    stream: Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 50,
        timeLimit: Duration(minutes: 1),
      ),
    ),
  );

  MapView({
    required this.positionProvider,
    required this.recyclingCenters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          positionProvider.latitude ?? 0.0,
          positionProvider.longitude ?? 0.0,
        ),
        initialZoom: 15,
        maxZoom: 19,
        minZoom: 13,
      ),
      children: [
        mapBoxOverlay(),
        markerWithClusters(context),
        CurrentLocationLayer(
          positionStream: _positionStream,
        ),
        mapBoxAttribution(),
      ],
    );
  }

  TileLayer mapBoxOverlay() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/512/{z}/{x}/{y}@2x?access_token=$mapboxApiKey',
      userAgentPackageName: 'com.food_finder.app',
      tileProvider: CancellableNetworkTileProvider(),
    );
  }

  MarkerClusterLayerWidget markerWithClusters(BuildContext context) {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        disableClusteringAtZoom: 18,
        size: const Size(40, 40),
        zoomToBoundsOnClick: false,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(50),
        maxZoom: 15,
        markers: recyclingCenters
            .map(
              (venue) => Marker(
                point: LatLng(venue.latitude, venue.longitude),
                child: locationButton(context, venue),
              ),
            )
            .toList(),
        builder: (context, markers) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Center(
              child: Text(
                markers.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  DefaultTextStyle mapBoxAttribution() {
    return const DefaultTextStyle(
      style: TextStyle(fontSize: 15, color: Colors.black),
      child: RichAttributionWidget(
        attributions: [
          TextSourceAttribution('Mapbox, © OpenStreetMap'),
          TextSourceAttribution('Recycling Data from Google'),
        ],
      ),
    );
  }

  GestureDetector locationButton(BuildContext context, RecyclingCenter recyclingCenter) {
    return GestureDetector(
      onTapDown: (tapDetails) => openPlacePage(context, tapDetails, recyclingCenter),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            color: Colors.lightGreen.withOpacity(0.8),
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.lightGreen,
            )),
      ),
    );
  }

  void openPlacePage(
    BuildContext context,
    TapDownDetails tapDetails,
    RecyclingCenter recyclingCenter,
  ) {
    final offset = tapDetails.globalPosition;
    List<PopupMenuEntry<int>> menu = [];
    menu.add(PopupMenuItem(
      value: 1,
      child: Text(recyclingCenter.name, style: const TextStyle(fontSize: 15)),
    ));
    menu.add(const PopupMenuDivider(height: 2));

    var website = recyclingCenter.url;
    if (website != null && website.isNotEmpty) {
      menu.add(
        PopupMenuItem(
          onTap: () => launchUrl(Uri.parse(website)),
          child: const Text('Website'),
        ),
      );
    }

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: menu,
    );
  }
}
