import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'components/menu_item.dart';
export 'package:provider/provider.dart';

class OrderPageProvider with ChangeNotifier{
  
  Reservation reservation;
  List<Order>? pastOrders;
  List<Map<String,dynamic>>? items;
  Image? image;
  bool isLoading = false;

  PageController pageController = PageController();

  OrderPageProvider(this.reservation){
    getData();
    getImage(reservation.placeId);
  }

  Future<void> getData() async{
    _loading();

    await reservation.userReservationRef!.collection('orders')
    .get()
    .then((query){
      var orders = query.docs;
      pastOrders = orders.map((order) => orderDataToOrder(reservation, order.data())).toList();
    });

    await FirebaseFirestore.instance.collection("places").doc(reservation.placeId)
    .get()
    .then((doc){
      items = [];
      var menuItems = doc.data()!['menu']['items'];
      menuItems.forEach((item){
        items!.add(
          {
            "item":  menuItemDataToMenuItem(item),
            "count": 0
          }
        );
      });
    });

    _loading();

    notifyListeners();
  }

  void incrementItemCount(int index){

    items![index]['count'] += 1;

    notifyListeners();
  }

  void decrementItemCount(int index){

    if(items![index]["count"] >= 1)
      items![index]["count"] -= 1;

    notifyListeners();
  }

  void sendOrder() async{
    _loading();

    var userOrderRef = reservation.userReservationRef!.collection("orders").doc();
    var placeOrderRef = reservation.placeReservationRef!.collection("orders").doc(userOrderRef.id);
    var orderItems = List.from(items!);
    orderItems.removeWhere((item) => item['count'] == 0);
    var orderData = {
      'date_created' : FieldValue.serverTimestamp(),
      'details': "",
      'accepted': null,
      'items': orderItems.map((item) => {
        "count": item['count'],
        "item" : {
          "title": item['item'].title,
          "content": item['item'].content,
          "ingredients": item['item'].ingredients,
          "alergens": item['item'].alergens,
        }
      }).toList(),
    };

    await userOrderRef.set(orderData);
    await placeOrderRef.set(orderData);

    await getData();

    _loading();

    notifyListeners();
  }

  Future<void> getImage(String id) async{
    var image = await FirebaseStorage.instance.ref("places/$id/0.jpg")
    .getData();
    this.image = Image.memory(
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

    notifyListeners();
  }

  void _loading(){
    isLoading = !isLoading;

    notifyListeners();
  }
}