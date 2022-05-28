import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        padding: EdgeInsets.only(top: 50),
        myLocationEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(44.427466, 26.102500), zoom: 14)
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}