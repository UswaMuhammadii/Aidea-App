// lib/screens/maps/map_services.dart
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class MapService {
  // Jeddah city bounds
  static const double jeddahMinLat = 21.3;
  static const double jeddahMaxLat = 21.8;
  static const double jeddahMinLng = 38.9;
  static const double jeddahMaxLng = 39.4;
  static const LatLng jeddahCenter = LatLng(21.5433, 39.1728);

  /// Check if location permissions are granted
  static Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  /// Get current location
  static Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await checkPermissions();
      if (!hasPermission) return null;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      debugPrint('Error getting location: $e');
      return null;
    }
  }

  /// Check if coordinates are within Jeddah
  static bool isInJeddah(double lat, double lng) {
    return lat >= jeddahMinLat &&
        lat <= jeddahMaxLat &&
        lng >= jeddahMinLng &&
        lng <= jeddahMaxLng;
  }

  /// Get address from coordinates using Nominatim (OpenStreetMap)
  static Future<String> getAddressFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = 'https://nominatim.openstreetmap.org/reverse?'
          'format=json&'
          'lat=$latitude&'
          'lon=$longitude&'
          'zoom=18&'
          'addressdetails=1';

      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'HandyManApp/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ??
            '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
      }
      return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
    } catch (e) {
      debugPrint('Error getting address: $e');
      return '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';
    }
  }

  /// Get coordinates from address using Nominatim (OpenStreetMap)
  static Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      // Search within Jeddah bounds
      final url = 'https://nominatim.openstreetmap.org/search?'
          'q=$address, Jeddah, Saudi Arabia&'
          'format=json&'
          'limit=1&'
          'viewbox=$jeddahMinLng,$jeddahMaxLat,$jeddahMaxLng,$jeddahMinLat&'
          'bounded=1';

      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'HandyManApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat'] as String);
          final lon = double.parse(data[0]['lon'] as String);

          return Position(
            latitude: lat,
            longitude: lon,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error getting coordinates: $e');
      return null;
    }
  }

  /// Search for locations in Jeddah
  static Future<List<Map<String, dynamic>>> searchLocations(
    String query,
  ) async {
    try {
      final url = 'https://nominatim.openstreetmap.org/search?'
          'q=$query, Jeddah, Saudi Arabia&'
          'format=json&'
          'limit=10&'
          'viewbox=$jeddahMinLng,$jeddahMaxLat,$jeddahMaxLng,$jeddahMinLat&'
          'bounded=1';

      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'HandyManApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => {
                  'name': item['display_name'] as String,
                  'lat': double.parse(item['lat'] as String),
                  'lon': double.parse(item['lon'] as String),
                })
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error searching locations: $e');
      return [];
    }
  }

  /// Calculate distance between two points in kilometers
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const Distance distance = Distance();
    return distance.as(
      LengthUnit.Kilometer,
      LatLng(lat1, lon1),
      LatLng(lat2, lon2),
    );
  }

  /// Get nearby landmarks in Jeddah
  static Future<List<Map<String, dynamic>>> getNearbyLandmarks(
    double latitude,
    double longitude, {
    int radius = 1000, // meters
  }) async {
    try {
      final url = 'https://nominatim.openstreetmap.org/search?'
          'format=json&'
          'limit=5&'
          'lat=$latitude&'
          'lon=$longitude&'
          'addressdetails=1';

      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'HandyManApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => {
                  'name': item['display_name'] as String,
                  'lat': double.parse(item['lat'] as String),
                  'lon': double.parse(item['lon'] as String),
                  'type': item['type'] as String?,
                })
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting landmarks: $e');
      return [];
    }
  }

  /// Validate if address is within Jeddah
  static Future<bool> validateJeddahAddress(String address) async {
    final position = await getCoordinatesFromAddress(address);
    if (position == null) return false;
    return isInJeddah(position.latitude, position.longitude);
  }
}
