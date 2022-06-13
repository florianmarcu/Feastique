import 'package:feastique/config/config.dart';
import 'package:feastique/screens/manager_orders_page/manager_orders_page.dart';
import 'package:feastique/screens/manager_orders_page/manager_orders_provider.dart';
import 'package:feastique/screens/manager_reservations_page/manager_reservations_provider.dart';
import 'package:feastique/widgets/app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';

class ManagerReservationsPage extends StatefulWidget {
  @override
  State<ManagerReservationsPage> createState() => _ManagerReservationsPageState();
}

class _ManagerReservationsPageState extends State<ManagerReservationsPage> {

  int _selectedScreenIndex = 1;
  List<Widget> _screens = <Widget>[
    ChangeNotifierProvider<ManagerReservationsProvider>(
      create: (context) => ManagerReservationsProvider(context),
      builder: (context, _) {
        return ManagerReservationsPage();
      }
    ),
    ChangeNotifierProvider<ManagerOrdersProvider>(
      create: (context) => ManagerOrdersProvider(),
      builder: (context, _) {
        return ManagerOrdersPage();
      }
    ),
  ];
  List<BottomNavigationBarItem> _screenLabels = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      label: "Rezervări",
      icon: Image.asset(asset('reservation'), width: 19,)
    ),
    BottomNavigationBarItem(
      label: "Comenzi",
      icon: Image.asset(asset('orders'), width: 19,)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
        items: _screenLabels,
        onTap: (index) => setState(()=>_selectedScreenIndex = index),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(210, 30), bottomRight: Radius.elliptical(210, 30))),
        title: Center(child: Text(_screenLabels[_selectedScreenIndex].label!, style: Theme.of(context).textTheme.headline4,)),
        // bottom: PreferredSize(
        //   preferredSize: Size(MediaQuery.of(context).size.width, 80),
        //   child: Row(children: [
            
        //   ],)
        // ),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: IndexedStack(
          children: _screens,
          index: _selectedScreenIndex
        )
      ),
    );
  }
}