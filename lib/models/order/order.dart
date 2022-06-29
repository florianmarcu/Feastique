import 'package:feastique/models/models.dart';

class Order{
  String id;
  Reservation reservation;
  List items;
  DateTime dateCreated;
  String details;
  bool? accepted;
  bool canceled;

  Order({required this.id, required this.reservation, required this.items, required this.dateCreated, required this.details, required this.accepted, required this.canceled});
}

  Order orderDataToOrder(Reservation reservation, String id,  Map<String, dynamic> data){
    return Order(
      id: id, 
      reservation: reservation,
      items: data['items'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(data['date_created'].millisecondsSinceEpoch),
      details: data['details'],
      accepted: data['accepted'],
      canceled: data['canceled'] != true ? false : true
    );
  }