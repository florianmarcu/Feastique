
import 'package:feastique/widgets/app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'components/components.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedScreenIndex = 0;
  List<Widget> _screens = <Widget>[
    DiscoverPage(),
    MapPage(),
    SearchPage()
  ];
  List<BottomNavigationBarItem> _screenLabels = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      label: "Descoperă",
      icon: Icon(Icons.remove_red_eye)
    ),
    BottomNavigationBarItem(
      label: "Hartă",
      icon: Icon(Icons.map)
    ),
    BottomNavigationBarItem(
      label: "Căutare",
      icon: Icon(Icons.search)
    ),
    // BottomNavigationBarItem(
    //   label: "Evenimente",
    //   icon: Icon(Icons.event)
    // ),
    // BottomNavigationBarItem(
    //   label: "Profil",
    //   icon: Icon(Icons.person)
    // ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        items: _screenLabels,
        onTap: (index) => setState(()=>_selectedScreenIndex = index),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(_screenLabels[_selectedScreenIndex].label!,)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(210, 30),
            bottomRight: Radius.elliptical(210, 30)
          )            
        ),
        toolbarHeight: 70,
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
