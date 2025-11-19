// lib/screens/map/map_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_services.dart';
import '../../gen_l10n/app_localizations.dart';

class MapSelectionScreen extends StatefulWidget {
  final Function(String, double?, double?) onLocationSelected;
  final String? initialAddress;

  const MapSelectionScreen({
    super.key,
    required this.onLocationSelected,
    this.initialAddress,
  });

  @override
  State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  bool _isLoading = true;
  bool _isGettingAddress = false;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.5204, 74.3587), // Lahore coordinates
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    setState(() => _isLoading = true);

    // Try to get current location first
    final position = await MapService.getCurrentLocation();
    if (position != null) {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      await _getAddressFromPosition(_selectedLocation!);
    } else {
      // Use initial address if provided and current location fails
      if (widget.initialAddress != null && widget.initialAddress!.isNotEmpty) {
        final location = await MapService.getCoordinatesFromAddress(widget.initialAddress!);
        if (location != null) {
          _selectedLocation = LatLng(location.latitude, location.longitude);
          _selectedAddress = widget.initialAddress!;
        }
      }
    }

    setState(() => _isLoading = false);
  }

  Future<void> _getAddressFromPosition(LatLng position) async {
    setState(() => _isGettingAddress = true);

    final address = await MapService.getAddressFromLatLng(
        position.latitude,
        position.longitude
    );

    setState(() {
      _selectedAddress = address;
      _isGettingAddress = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_selectedLocation != null) {
      controller.animateCamera(
        CameraUpdate.newLatLng(_selectedLocation!),
      );
    }
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
    _getAddressFromPosition(position);
  }

  void _onCameraMove(CameraPosition position) {
    // You can implement dragging detection here if needed
  }

  void _confirmLocation() {
    if (_selectedLocation != null && _selectedAddress.isNotEmpty) {
      widget.onLocationSelected(
        _selectedAddress,
        _selectedLocation!.latitude,
        _selectedLocation!.longitude,
      );
      Navigator.pop(context);
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    final position = await MapService.getCurrentLocation();
    if (position != null) {
      _selectedLocation = LatLng(position.latitude, position.longitude);
      await _getAddressFromPosition(_selectedLocation!);

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_selectedLocation!),
        );
      }
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectLocation),
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
            tooltip: 'Current Location',
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            onTap: _onMapTap,
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: _selectedLocation != null
                ? {
              Marker(
                markerId: const MarkerId('selected_location'),
                position: _selectedLocation!,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              ),
            }
                : {},
          ),

          // Center marker
          const IgnorePointer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 48,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Current location button
          Positioned(
            bottom: 120,
            right: 16,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              mini: true,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.black),
            ),
          ),

          // Bottom address card
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectedLocation,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (_isGettingAddress)
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: const Color(0xFF7C3AED),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Getting address...',
                          style: TextStyle(
                            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      _selectedAddress.isNotEmpty
                          ? _selectedAddress
                          : l10n.tapOnMapToSelectLocation,
                      style: TextStyle(
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedLocation != null ? _confirmLocation : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        l10n.confirmLocation,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: const Color(0xFF7C3AED),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Loading map...',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}