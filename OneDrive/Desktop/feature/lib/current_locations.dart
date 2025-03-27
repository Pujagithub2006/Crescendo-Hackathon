import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'qr_scanner.dart';
//import 'package:permission_handler/permission_handler.dart';


class SafeRoutesScreen extends StatefulWidget {
  const SafeRoutesScreen({super.key});

  @override
  State<SafeRoutesScreen> createState() => _SafeRoutesScreenState();
}

class _SafeRoutesScreenState extends State<SafeRoutesScreen> {
  GoogleMapController? _mapController; // Google Map controller
  LatLng? _currentLocation; // current location

  @override
  void initState() {
    // initialize state
    super.initState();
    _getUserLocation(); // function to get current location
  }

  // get user location
  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // check if service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationError(
        'Location services are disabled. Please enable the GPS location',
      );
      return;
    }

    // check if permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationError('Location permissions are denied');
        return;
      }
    }

    // special case for Location services denied forever
    if (permission == LocationPermission.deniedForever) {
      _showLocationError(
        'Location services are denied forever. Please enable the GPS location',
      );
      return;
    }

    // fetch current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Update the UI with the fetched new location
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    // Move the map or camera to the current location
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation!, 15.0),
    );
  }

  // Show Error message if location is not shown on the map
  void _showLocationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: Text('Safe Routes'),
        backgroundColor: Colors.purple,
      ),

      // Body
      body:
          _currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                // Camera position
                initialCameraPosition: CameraPosition(
                  target: _currentLocation!,
                  zoom: 15.0,
                ),

                // Google Map controller
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),

      // Floating Action Button
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: _getUserLocation,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.my_location),
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRPage(),
                    ),
                );
              },

              backgroundColor: Colors.indigo,
              child: Icon(Icons.qr_code),
          )

        ],
      )

    );
  }
}
