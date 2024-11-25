import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider extends ChangeNotifier {
  double? latitude;
  double? longitude;
  bool positionKnown = false;
  String? errorMessage;
  Timer? _timer;

  static const double distanceFilter = 50.0; // 50 meters
  Position? lastKnownPosition;

  PositionProvider() {
    _startPositionUpdates();
  }

  void _startPositionUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      try {
        await _determinePosition();
      } catch (e) {
        _handleError('Error in timer callback: $e');
      }
    });
  }

  Future<void> _determinePosition() async {
    try {
      if (!await _checkLocationService()) return;

      final permission = await _getPermission();
      if (permission == null) return;

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _updatePositionIfNeeded(position);
    } catch (e) {
      _handleError('Error occurred while fetching position: $e');
    }
  }

  Future<bool> _checkLocationService() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _handleError('Location services are disabled.');
      return false;
    }
    return true;
  }

  Future<LocationPermission?> _getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      _handleError('Location permissions are denied');
      return null;
    }

    if (permission == LocationPermission.deniedForever) {
      _handleError('Location permissions are permanently denied.');
      return null;
    }

    return permission;
  }

  void _updatePositionIfNeeded(Position position) {
    if (lastKnownPosition == null ||
        Geolocator.distanceBetween(
              lastKnownPosition!.latitude,
              lastKnownPosition!.longitude,
              position.latitude,
              position.longitude,
            ) > distanceFilter) {
      if (latitude != position.latitude || longitude != position.longitude) {
        latitude = position.latitude;
        longitude = position.longitude;
        positionKnown = true;
        errorMessage = null; // Clear previous errors
        notifyListeners();
      }

      lastKnownPosition = position;
    }
  }

  void _handleError(String message) {
    if (errorMessage != message) {
      errorMessage = message;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
