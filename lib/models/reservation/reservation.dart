import 'package:cloud_firestore/cloud_firestore.dart';

class Reservation{
  
  String id;
  bool? accepted;
  DateTime dateCreated;
  DateTime dateStart;
  String guestId;
  String guestName;
  String placeId;
  String placeName;
  String contactPhoneNumber;
  String contactName;
  String details;
  bool? claimed;
  int peopleNo;
  Map<String, dynamic>? deals;
  Map<String, dynamic>? discounts;

  DocumentReference? placeReservationRef;
  DocumentReference? userReservationRef;

  Reservation(
    {
      required this.id,
      required this.accepted,
      required this.dateCreated,
      required this.dateStart,
      required this.guestId,
      required this.guestName,
      required this.placeId,
      required this.placeName,
      required this.contactPhoneNumber,
      required this.contactName,
      required this.details,
      required this.claimed,
      required this.peopleNo,
      required this.deals,
      required this.discounts,
      required this.placeReservationRef,
      required this.userReservationRef
    }
  );
}

Reservation reservationDataToReservation(String id, Map<String, dynamic> data){
  return Reservation(
    id: id,
    accepted: data['accepted'],
    dateCreated: data['date_created'],
    dateStart: data['date_start'],
    guestId: data['guest_id'],
    guestName: data['guest_name'],
    placeId: data['place_id'],
    placeName: data['place_name'],
    contactPhoneNumber: data['contact_phone_number'],
    contactName: data['contact_name'],
    details: data['details'],
    claimed: data['guest_id'],
    peopleNo: data['guest_id'],
    discounts: data['guest_id'],
    deals: data['deals'],
    placeReservationRef: data['place_reservation_ref'],
    userReservationRef: data['user_reservation_ref']
  );
}