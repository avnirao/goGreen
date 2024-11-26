import 'package:flutter/material.dart';
import 'package:go_green/models/recycling_center.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_green/models/recycling_center_db.dart';
import 'package:go_green/providers/position_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapView extends StatefulWidget {
  final PositionProvider positionProvider;
  final RecyclingCentersDB recyclingCenters;

  const MapView({
    required this.positionProvider,
    required this.recyclingCenters,
    super.key,
  });

  @override
  MapViewState createState() => MapViewState();
}
class MapViewState extends State<MapView> {
  int _currentIndex = 0;
  late final PositionProvider positionProvider;
  late final RecyclingCentersDB recyclingCenters;

  final _positionStream = const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream(
    stream: Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 50,
        timeLimit: Duration(minutes: 1),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    positionProvider = widget.positionProvider;
    recyclingCenters = widget.recyclingCenters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E8CF),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                'Recycling Centers Near Me',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF386641),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final position = snapshot.data!;
                    return FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(position.latitude, position.longitude),
                        initialZoom: 15,
                        maxZoom: 19,
                        minZoom: 5,
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
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF2E8CF),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            if (index == 1) {
              Navigator.pushNamed(context, '/history');
            } else if (index == 0) {
              Navigator.pushNamed(context, '/');
            } 
          },
          backgroundColor: const Color(0xFFF2E8CF),
          selectedItemColor: const Color(0xFFBC4749),
          unselectedItemColor: const Color(0xFF386641),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
        ),
      ),
    );
  }

  TileLayer mapBoxOverlay() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/512/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXZuaXJhbyIsImEiOiJjbTN4cHl4cmYxZ2xoMmxwdTEwdXM3YXdnIn0.KTv-MpYEgAi9Gf4VHS-Enw',
      userAgentPackageName: 'com.recycling.goGreen',
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
        markers: recyclingCenters.all
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
                  color: Color(0xFFF2E8CF),
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
    child: const Icon(
      Icons.travel_explore, // tree icon
      size: 30.0, // size of the icon
      color: Color(0xFFBC4749), // red color
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
      child: Text(recyclingCenter.name, style: const TextStyle(fontSize: 15, color: Color(0xFF386641), decoration: TextDecoration.none,), textAlign: TextAlign.center,),
    ));
    menu.add(const PopupMenuDivider(height: 2));

    var website = recyclingCenter.url;
    if (website.isNotEmpty) {
      menu.add(
        PopupMenuItem(
          onTap: () async {
            if (await canLaunchUrl(Uri.parse(website))) {
              await launchUrl(Uri.parse(website));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Could not open the website")),
              );
            }
          },
          child: const Text('Website', style: TextStyle(fontSize: 15, color: Colors.black, decoration: TextDecoration.none,), textAlign: TextAlign.center,),
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
