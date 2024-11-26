import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider extends ChangeNotifier {
  //the latitude and longitude of the current position
  double? latitude;
  double? longitude;
  
  // Flag to indicate if the position is known
  bool positionKnown = false;

  // Error message
  String? errorMessage;

  // Timer to update the position
  Timer? _timer;

  // Define a distance filter in meters
  static const double distanceFilter = 50.0; // 50 meters
  
  // Last known position
  Position? lastKnownPosition; 
  
  // Constructor
  PositionProvider() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      try {
        // Update position every 1 second
        await _determinePosition();
      } catch (e) {
        errorMessage = 'Error in timer callback: $e';
        notifyListeners();
      }
    });
  }

  Future<void> _determinePosition() async {
    try {
      // Check if location services are enabled
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (errorMessage != 'Location services are disabled.') {
          errorMessage = 'Location services are disabled.';
          notifyListeners(); 
        }
        return;
      }

      // Check for location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (errorMessage != 'Location permissions are denied') {
            errorMessage = 'Location permissions are denied';
            notifyListeners();
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (errorMessage != 'Location permissions are permanently denied.') {
          errorMessage = 'Location permissions are permanently denied.';
          notifyListeners();
        }
        return;
      }

      // Get current position
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Check if the distance moved exceeds the defined filter
      if (lastKnownPosition == null || 
          Geolocator.distanceBetween(
              lastKnownPosition!.latitude,
              lastKnownPosition!.longitude,
              position.latitude,
              position.longitude) > distanceFilter) {

        // Only notify listeners if the position has changed
        if (latitude != position.latitude || longitude != position.longitude) {
          latitude = position.latitude;
          longitude = position.longitude;
          positionKnown = true;
          errorMessage = null; 
          notifyListeners(); // Notify only if the position changes so that the UI can be rebuilt
        }

        // Update last known position
        lastKnownPosition = position;
      }

    } catch (e) {
      // Notify only if the error message changes
      if (errorMessage != 'Error occurred while fetching position: $e') {
        errorMessage = 'Error occurred while fetching position: $e';
        notifyListeners();
      }
    }
  }

  // Dispose the timer
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
