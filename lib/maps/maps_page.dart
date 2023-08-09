import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapsPage({super.key, required this.latitude, required this.longitude});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;

  late final LatLng _center;
  final Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _center = LatLng(widget.latitude, widget.longitude);
    markers.add(
      Marker(
        markerId:
            MarkerId('ema lat:${widget.latitude} lon: ${widget.longitude}'),
        position: _center
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: markers,
          ),
        ),
      ),
    );
  }
}
