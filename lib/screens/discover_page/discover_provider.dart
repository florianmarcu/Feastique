import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:feastique/screens/place_page/place_page.dart';
import 'package:feastique/screens/place_page/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class DiscoverPageProvider with ChangeNotifier{
  /// The 'places' to be displayed on the Map
  /// They will change according to the filters applied by the users
  List<Place> places = [];
  Set<Marker> markers = {};
  List<Place> placesList = [];
  String viewType = 'map';
  Map<String, dynamic> activeFilters = {};
  BuildContext context;

  DiscoverPageProvider(this.context){
    /// Initialize the 'places' list with all the available places from Firestore
    getData();
    _mapPlacesToMarkers(places);
  }
  
  /// Method that fetches all the places and information about them from the database
  Future<void> getData() async{
    places = await FirebaseFirestore.instance.collection('places').get()
    .then((query) => places = query.docs.map(docToPlace).toList());
    markers = _mapPlacesToMarkers(places);

    // placesList = await FirebaseFirestore.instance.collection('places').limit(10).get()
    // .then((query) => places = query.docs.map(docToPlace).toList());
    
    notifyListeners();
  }

  // Future<void> getMoreData() async{
  //   var query = await FirebaseFirestore.instance.collection('places').get()
  //   .then((query) => places = query.docs.map(docToPlace).toList());
  // }

  ///TODO
  void filterByAmbiance(String ambiance) async{
    
  }

  void filter(String key){

  }

  void changeViewType() async{
    if(viewType == "map")
      viewType = "list";
    else viewType = "map";
    notifyListeners();
  }

  Set<Marker> _mapPlacesToMarkers(List<Place> places){
    return places.map((place) => Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      markerId: MarkerId(place.name),
      position: LatLng(place.location.latitude, place.location.longitude), 
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
        ChangeNotifierProvider<PlaceProvider>(
          create: (context) => PlaceProvider(place),
          builder: (context, child) => PlacePage()
        )
      ))
    )).toSet();
  }

}