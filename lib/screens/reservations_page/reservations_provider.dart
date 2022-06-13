import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class ReservationsPageProvider with ChangeNotifier{
  
  //List<Reservation>? reservations;
  List<Reservation>? pastReservations;
  List<Reservation>? upcomingReservations; 

  ReservationsPageProvider(BuildContext context){
    _getData(context);
  }
  
  Future<void> _getData(BuildContext context) async{
    var user = Provider.of<UserProfile?>(context, listen: false);
    
    FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("reservations")
    .where('date_start', isLessThan: Timestamp.fromDate(DateTime.now().add(Duration(minutes: -30)).toLocal()))
    .orderBy("date_start")
    .get()
    .then((query) => pastReservations = query.docs.map((doc) => reservationDataToReservation(doc.id, doc.data())).toList());

    FirebaseFirestore.instance.collection("users").doc(user.uid).collection("reservations")
    .where('date_start', isGreaterThan: Timestamp.fromDate(DateTime.now().add(Duration(minutes: -30)).toLocal()))
    .orderBy("date_start")
    .get()
    .then((query) => upcomingReservations = query.docs.map((doc) => reservationDataToReservation(doc.id, doc.data())).toList());

    notifyListeners();
  }

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
}