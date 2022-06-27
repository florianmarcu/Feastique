import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceMapPage extends StatelessWidget {

  var location;

  PlaceMapPage(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 30
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude!, location.longitude!),
          zoom: 15
        ),
        myLocationEnabled: true,
        // ignore: sdk_version_set_literal
        markers: {
          Marker(
            markerId: MarkerId('0'),
            position: LatLng(location.latitude!,location.longitude!)
          ),
        },
      ),
    );
  }
}