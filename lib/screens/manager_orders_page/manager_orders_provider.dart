import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class ManagerOrdersProvider with ChangeNotifier{
  Future<Image> getImage(String id) async{
    var image = await FirebaseStorage.instance.ref("places/$id/0.jpg")
    .getData();
    return Image.memory(
      image!,
      alignment: FractionalOffset.topCenter,
      fit: BoxFit.cover,
      frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    );
  }

  Future<List<DocumentSnapshot>> getReservation()async{
    var query = await FirebaseFirestore.instance.collection('users').doc("kosUWxVf20hAa0AgD0SJRudtVd82").collection("managed_places").doc("martina_ristorante")
    .collection("reservations").doc("vldxskkwDnsjcFpFXEaI").collection("orders").get();
    return query.docs;
  }
}