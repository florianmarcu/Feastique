import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/config/constants.dart';
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
  /// The list of  all 'places', to be filtered everytime we apply filters
  List<Place> allPlaces = [];
  Set<Marker> markers = {};
  List<Place> placesList = [];
  String viewType = 'map';
  Map<String, dynamic> activeFilters = {};
  bool isLoading = false;
  BuildContext context;

  DiscoverPageProvider(this.context){
    /// Initialize the 'places' list with all the available places from Firestore
    getData();
  }
  
  /// Method that fetches all the places and information about them from the database
  Future<void> getData() async{
    _loading();
    /// Instantiate active filters with no 'false' for each field
    activeFilters = {
      "types": kFilters['types']!.map((e) => false).toList(),
      "ambiences": kFilters['ambiences']!.map((e) => false).toList(),
      "costs": kFilters['costs']!.map((e) => false).toList(),
    };
    /// Get all available places from Firestore
    await FirebaseFirestore.instance.collection('places').get()
    .then((query) => allPlaces = query.docs.map(docToPlace).toList());
    /// Instantiate displayed places with all places
    places = List.from(allPlaces);
    // places = allPlaces;
    /// Map displayed places to Markers
    markers = _mapPlacesToMarkers(places);

    // placesList = await FirebaseFirestore.instance.collection('places').limit(10).get()
    // .then((query) => places = query.docs.map(docToPlace).toList());
    
    notifyListeners();
    _loading();
  }

  // Future<void> getMoreData() async{
  //   var query = await FirebaseFirestore.instance.collection('places').get()
  //   .then((query) => places = query.docs.map(docToPlace).toList());
  // }

  void filter(Map<String, List<bool>> filters){
    _loading();

    activeFilters = Map<String, List<bool>>.from(filters);
    
    Map<String, List<String>> finalFilters = {"types" : [], "ambiences" : [], "costs": []};
    kFilters.forEach((key, list) {
      for(int i = 0; i < list.length; i++)
      if(filters[key]![i])
        finalFilters[key]!.add(list[i]);
    });
    print(finalFilters);
    
    print(places.length);
    print(allPlaces.length);
    // List.copyRange(places, 0, allPlaces);
    places = List.from(allPlaces);

    // places = allPlaces;

    places.forEach((element) {print(element.types);});
    
    filters.forEach((key, list) {
      for(int i = 0; i < list.length; i++){
        if(list[i]){
          var value = kFilters[key]![i];          
          switch(key){
            case "types":
              places.removeWhere((place) => !place.types!.contains(value));
            break;
            case "ambiences":
              places.removeWhere((place) => place.ambience != value);
            break;
            case "costs":
              places.removeWhere((place) => place.cost.toString() != value);
            break;
          }
        }
      }
    });
    print(allPlaces);

    markers = _mapPlacesToMarkers(places);

    notifyListeners();
    _loading();
  }

  void removeFilters(){
    _loading();
     /// Instantiate active filters with no 'false' for each field
    activeFilters = {
      "types": kFilters['types']!.map((e) => false).toList(),
      "ambiences": kFilters['ambiences']!.map((e) => false).toList(),
      "costs": kFilters['costs']!.map((e) => false).toList(),
    };
    /// Reinstantiate displayed places with all places
    ///     List.copyRange(places, 0, allPlaces);
    places = List.from(allPlaces);
    // places = allPlaces;
    /// Map displayed places to Markers
    print("LENGTH: ${allPlaces.last.name}");
    markers = _mapPlacesToMarkers(places);

    notifyListeners();
    _loading();
  }

  void changeViewType() async{
    _loading();
    if(viewType == "map")
      viewType = "list";
    else viewType = "map";
    notifyListeners();
    _loading();
  }

  Set<Marker> _mapPlacesToMarkers(List<Place> places){
    return places.map((place) => Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      markerId: MarkerId(place.name),
      position: LatLng(place.location.latitude, place.location.longitude), 
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
        ChangeNotifierProvider<PlaceProvider>(
          create: (context) => PlaceProvider(place),
          builder: (context, child) => PlacePage(context)
        )
      ))
    )).toSet();
  }

  /// Method called everytime a provider function is called to show a progress indicator
  void _loading(){
    isLoading = !isLoading;
    notifyListeners();
  }

}