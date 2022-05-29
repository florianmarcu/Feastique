import 'package:feastique/screens/home_page/components/map_page/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import "package:latlong2/latlong.dart" as latlng;


class MapPage extends StatefulWidget {
  const MapPage({ Key? key }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var places = context.watch<MapProvider>().places;
    return Container(
      child: GoogleMap(
        padding: EdgeInsets.only(top: 200),
        myLocationEnabled: false,
        initialCameraPosition: CameraPosition(target: LatLng(44.427466, 26.102500), zoom: 14)
      ),
      height: MediaQuery.of(context).size.height,
    );
    // return FlutterMap(
    //   options: MapOptions(
    //     center: LatLng(44.427466, 26.102500),
    //     zoom: 14,
    //     interactiveFlags: InteractiveFlag.doubleTapZoom | InteractiveFlag.drag | InteractiveFlag.pinchMove | InteractiveFlag.pinchZoom
    //   ),
    //   layers: [
    //     TileLayerOptions(
    //       urlTemplate: "https://mt0.google.com/vt/lyrs=m@221097413,traffic,transit,bike&x={x}&y={y}&z={z}",
    //       subdomains: ['a', 'b', 'c'],
    //       // attributionBuilder: (_) {
    //       //   return Text("© OpenStreetMap contributors");
    //       // },
    //       retinaMode: true
    //     ),
    //     MarkerLayerOptions(
    //       markers: [
    //         Marker(
    //           width: 80.0,
    //           height: 80.0,
    //           point: LatLng(44.427466, 26.102500),
    //           builder: (ctx) =>
    //           Container(
    //             child: FlutterLogo(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );

  }
}