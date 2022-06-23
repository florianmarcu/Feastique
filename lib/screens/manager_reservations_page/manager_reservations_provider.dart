import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    .collection("reservations").get();
    return query.docs;
  }

}