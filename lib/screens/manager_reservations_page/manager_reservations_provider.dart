import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class ManagerReservationsProvider with ChangeNotifier{

  List<Reservation>? upcomingReservations;

  ManagerReservationsProvider(BuildContext context){
    _getData(context);
  }
  Future<void> _getData(BuildContext context) async{
    var user = Provider.of<UserProfile?>(context, listen: false);

    FirebaseFirestore.instance.collection("users").doc(user!.uid).collection("reservations")
    .where('date_start', isGreaterThan: Timestamp.fromDate(DateTime.now().add(Duration(minutes: -30)).toLocal()))
    .orderBy("date_start")
    .get()
    .then((query) => upcomingReservations = query.docs.map((doc) => reservationDataToReservation(doc.id, doc.data())).toList());

    notifyListeners();
  }

}