import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class ManagerOrdersProvider with ChangeNotifier{
  List<Order>? orders;
  BuildContext context;

  ManagerOrdersProvider(this.context){
    getData();
  }

  void getData() async{

    var user = context.read<User?>();

    var place = (await FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("managed_places").get()).docs.first;

    var orders = [];

    await FirebaseFirestore.instance.collectionGroup("reservations")
    .where("active", isEqualTo: true)
    .where("place_id", isEqualTo: place.id)
    .get();
  }

}