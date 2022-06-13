import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesMap extends StatelessWidget {
  const PlacesMap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var places = context.watch<DiscoverPageProvider>().places;
    var markers = context.watch<DiscoverPageProvider>().markers;
    return Container(
      child: GoogleMap(
        padding: EdgeInsets.only(top: 200),
        myLocationEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(44.427466, 26.102500), zoom: 14),
        markers: markers,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}