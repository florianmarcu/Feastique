import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:feastique/screens/wrapper_home_page/wrapper_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesMap extends StatelessWidget {
  const PlacesMap({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var places = context.watch<DiscoverPageProvider>().places;
    var markers = context.watch<DiscoverPageProvider>().markers;
    var wrapperHomePageProvider = context.watch<WrapperHomePageProvider>();
    var mainCity = wrapperHomePageProvider.mainCity;
    return Container(
      child: GoogleMap(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        myLocationEnabled: false,
        initialCameraPosition: mainCity != null ?
        CameraPosition(target: LatLng(mainCity['location'].latitude, mainCity['location'].longitude), zoom: 14)
        : CameraPosition(target: LatLng(0,0)),
        markers: markers,
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}