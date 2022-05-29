import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Place{
  final int? score; // Dynamic (depends on the score of the category)
  final String? id; // Imported from the database
  final String? name; // Imported from the database
  final Future<Image>? image; // Imported from the database
  final String? description; // Imported from the database
  final GeoPoint? location; // Imported from the database
  final int? cost; // Imported from the database
  final int? capacity;
  final Map<String,dynamic>? discounts;
  //final Future<List<Uint8List>> images; // The Place images from Firebase Storage
  final Future<String>? address; // The Street&No of the Place
  /// A reference to the 'users/{usersId}/managed_place/{managed_place}' in the database
  /// Contains some data about the place, and the 'reservations' and 'scanned_codes' subcollections. 
  final DocumentReference? reference;
  final Map<String,dynamic>? schedule;
  final Map<String,dynamic>? deals;
  final String? menu; // A link to a webpage containing the Place's menu
  final bool? hasOpenspace;
  final bool? hasReservations;
  final bool? isPartner;
  final bool? preferPhone;
  final int? phoneNumber;
  final String? tipMessage;
  Image? finalImage;

  Place({
    this.cost,
    this.score, 
    this.id,
    this.name,
    this.image,
    this.description,
    this.location,
    this.capacity,
    this.discounts,
    //this.images,
    this.address,
    this.reference,
    this.schedule,
    this.deals,
    this.menu,
    this.hasOpenspace,
    this.hasReservations,
    this.isPartner,
    this.preferPhone,
    this.phoneNumber,
    this.tipMessage
  }){
    image!.then((image) => finalImage = image);
  }
}

Place docToPlace(DocumentSnapshot doc){
    Future<String>? address;
    var profileImage = _getImage(doc.id);
    var place = doc.data() as Map<String, dynamic>;
    return Place(
      cost: place['cost'],
      score: place['score'],
      id: doc.id,
      image: profileImage,
      name: place['name'],
      location:place['location'],
      description: place['description'],
      capacity: place['capacity'],
      discounts: place['discounts'],
      address: address,
      reference: place.containsKey('manager_reference') ? place['manager_reference']: null,
      schedule: place.containsKey('schedule') ? place['schedule']: null,
      deals: place.containsKey('deals') ? place['deals']: null,
      menu: place.containsKey('menu') ? place['menu']: null,
      hasOpenspace: place.containsKey('open_space') ? place['open_space']: null,
      hasReservations: place.containsKey('reservations') ? place['reservations']: null,
      isPartner: place.containsKey('partner') ? place['partner']: false,
      preferPhone: place.containsKey('prefer_phone') ? place['prefer_phone'] : null,
      phoneNumber: place.containsKey('phone_number') ? place['phone_number'] : null,
      tipMessage: place.containsKey('tip_message') ? place['tip_message'] : null,
    );
  }

  Future<Image> _getImage(String? fileName) async {
      Uint8List? imageFile;
      int maxSize = 10*1024*1024;
      String pathName = 'photos/europe/bucharest/$fileName';
      print(pathName);
      var storageRef = FirebaseStorage.instance.ref().child(pathName);
      imageFile = await storageRef.child('$fileName'+'_profile.jpg').getData(maxSize);
      return Image.memory(
        imageFile!,
        fit: BoxFit.fill,
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



