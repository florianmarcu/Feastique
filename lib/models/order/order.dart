import 'package:feastique/models/models.dart';

class Order{
  Reservation reservation;
  List items;
  DateTime dateCreated;
  String details;
  bool? accepted;

  Order({required this.reservation, required this.items, required this.dateCreated, required this.details, required this.accepted});
}

  Order orderDataToOrder(Reservation reservation, Map<String, dynamic> data){
    return Order(
      reservation: reservation,
      items: data['items'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(data['date_created'].millisecondsSinceEpoch),
      details: data['details'],
      accepted: data['accepted']
    );
  }