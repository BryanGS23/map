import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/services/map_service.dart';
import '/models/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    List<Location> locations = await MapService.getLocations();
    setState(() {
      _markers.clear();
      for (var loc in locations) {
        _markers.add(Marker(
          markerId: MarkerId(loc.id),
          position: LatLng(loc.latitude, loc.longitude),
          infoWindow: InfoWindow(title: loc.name, snippet: loc.description),
        ));
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Locations')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target:
              LatLng(19.6327, -98.9801), // Coordinates for initial map center
          zoom: 10,
        ),
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Implement your functionality to add new locations
          // Show a dialog or navigate to a new screen to enter location details
        },
        child: Icon(Icons.add_location),
      ),
    );
  }
}
