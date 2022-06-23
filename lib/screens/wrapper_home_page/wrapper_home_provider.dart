import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/config/config.dart';
import 'package:feastique/models/models.dart';
import 'package:feastique/screens/discover_page/discover_page.dart';
import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:feastique/screens/home_page/home_page.dart';
import 'package:feastique/screens/home_page/home_provider.dart';
import 'package:feastique/screens/profile_page/profile_page.dart';
import 'package:feastique/screens/profile_page/profile_provider.dart';
import 'package:feastique/screens/reservations_page/reservations_page.dart';
import 'package:feastique/screens/reservations_page/reservations_provider.dart';
import 'package:flutter/material.dart';

class WrapperHomePageProvider with ChangeNotifier{
  
  /// Configuration data about the cities
  Map<String, dynamic>? configData;
  /// The cities available in the app
  List<Map<String, dynamic>>? cities;
  /// The main city selected in the app
  Map<String, dynamic>? mainCity;
  int selectedScreenIndex = 1;

  List<Widget> screens = <Widget>[
    ChangeNotifierProvider<HomePageProvider>(
      create: (context) => HomePageProvider(),
      builder: (context, _) {
        return HomePage();
      }
    ),
    ChangeNotifierProvider<DiscoverPageProvider>(
      create: (context) => DiscoverPageProvider(context),
      builder: (context, _) {
        return DiscoverPage(context);
      }
    ),
    ChangeNotifierProvider<ReservationsPageProvider>(
      create: (context) => ReservationsPageProvider(context),
      builder: (context, _) {
        return ReservationsPage();
      }
    ),
    ChangeNotifierProvider<ProfilePageProvider>(
      create: (context) => ProfilePageProvider(Provider.of<UserProfile>(context, listen: false), context),
      builder: (context, _) {
        return ProfilePage();
      }
    ),
  ];
  List<BottomNavigationBarItem> screenLabels = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      label: "Acasă",
      icon: Icon(Icons.home)
    ),
    BottomNavigationBarItem(
      label: "Descoperă",
      icon: Icon(Icons.search)
    ),
    BottomNavigationBarItem(
      label: "Rezervări",
      icon: Image.asset(asset('reservation'), width: 19,)
    ),
    BottomNavigationBarItem(
      label: "Profil",
      icon: Icon(Icons.person)
    ),
  ];


  WrapperHomePageProvider(){
    getData();
  }

  void getData() async{
    var query = FirebaseFirestore.instance.collection("config").doc("config");
    var doc = await query.get();
    configData = doc.data(); 
    mainCity = configData!['cities'][configData!['main_city']];

    notifyListeners();
  }

  void updateSelectedScreenIndex(int index){
    selectedScreenIndex = index;

    notifyListeners();
  }

  void updateMainCity(String city){
    mainCity = configData!['cities'][city];

    notifyListeners();
  }
}