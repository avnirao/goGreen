import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // For Mapbox integration
import 'package:geolocator/geolocator.dart'; // To get current location
import 'package:http/http.dart' as http; // For API calls
import 'dart:convert';


class LocationsPage extends StatefulWidget {
  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late Position _currentPosition;
  bool _isLoading = true;
  List<dynamic> _dropOffLocations = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Function to fetch current location
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, ask the user to enable them
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions denied
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied
      return;
    }

    // Get the current location
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _fetchDropOffLocations(_currentPosition.latitude, _currentPosition.longitude);
  }

  // Function to fetch nearby drop-off locations
  void _fetchDropOffLocations(double latitude, double longitude) async {
    final String apiUrl = 'https://api.example.com/locations?lat=$latitude&lng=$longitude'; // Example API endpoint
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = json.decode(response.body);
      setState(() {
        _dropOffLocations = data['locations']; // Assuming the response has a 'locations' key
        _isLoading = false;
      });
    } else {
      // Handle the error
      print("Failed to load locations");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Drop-off Locations")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(_currentPosition.latitude, _currentPosition.longitude),
                      zoom: 12.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", // Replace with Mapbox URL if needed
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: _dropOffLocations.map((location) {
                          return Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(location['latitude'], location['longitude']),
                            builder: (ctx) => Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _dropOffLocations.length,
                    itemBuilder: (context, index) {
                      var location = _dropOffLocations[index];
                      return ListTile(
                        title: Text(location['name']),
                        subtitle: Text(location['address']),
                        trailing: IconButton(
                          icon: Icon(Icons.map),
                          onPressed: () {
                            // Open Google Maps or Apple Maps with the location coordinates
                            // You can implement this using url_launcher package
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
