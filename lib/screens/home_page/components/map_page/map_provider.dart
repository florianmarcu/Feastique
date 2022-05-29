import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapProvider with ChangeNotifier{
  List<Place> places = [];

  MapProvider(){
    getData();
  }
  
  /// Method that fetches all the places and information about them from the database
  Future<void> getData() async{
    places = await FirebaseFirestore.instance
    .collection('places')
    .get()
    .then((query) => places = query.docs.map(docToPlace).toList());
    notifyListeners();
  }

  ///TODO
  ///Filter by ambiance
  Future<void> filterByAmbiance(String ambiance) async{
    
  }
}