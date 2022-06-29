import 'package:feastique/config/config.dart';
import 'package:feastique/screens/manager_orders_page/manager_orders_page.dart';
import 'package:feastique/screens/manager_orders_page/manager_orders_provider.dart';
import 'package:feastique/screens/manager_reservations_page/manager_reservations_page.dart';
import 'package:feastique/screens/manager_reservations_page/manager_reservations_provider.dart';
import 'package:flutter/material.dart';

class ManagerHomePageProvider with ChangeNotifier{
  int selectedScreenIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  
  List<Widget> screens = <Widget>[
    ChangeNotifierProvider<ManagerReservationsPageProvider>(
      create: (context) => ManagerReservationsPageProvider(context),
      builder: (context, _) {
        return ManagerReservationsPage();
      }
    ),
    ChangeNotifierProvider<ManagerOrdersPageProvider>(
      create: (context) => ManagerOrdersPageProvider(context),
      builder: (context, _) {
        return ManagerOrdersPage();
      }
    ),
  ];

  List<BottomNavigationBarItem> screenLabels = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      label: "Rezervări",
      icon: Image.asset(localAsset("reservation"), width: 20,)
    ),
    BottomNavigationBarItem(
      label: "Comenzi",
      icon: Image.asset(localAsset("orders"), width: 20,)
    ),
  ];
  void updateSelectedScreenIndex(int index){
    selectedScreenIndex = index;

    notifyListeners();
  }
}