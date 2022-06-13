
import 'package:feastique/config/config.dart';
import 'package:feastique/models/user/user.dart';
import 'package:feastique/screens/discover_page/discover_page.dart';
import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:feastique/screens/home_page/home_page.dart';
import 'package:feastique/screens/home_page/home_provider.dart';
import 'package:feastique/screens/profile_page/profile_page.dart';
import 'package:feastique/screens/profile_page/profile_provider.dart';
import 'package:feastique/screens/reservations_page/reservations_page.dart';
import 'package:feastique/screens/reservations_page/reservations_provider.dart';
import 'package:feastique/widgets/app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';


/// This Page is a Wrapper Page
/// It doesn't have a body of its own, but instead it wraps multiple different pages in a Navigation Bar manner
/// - Home Page
/// - Discover Page
/// - Profile Page
class WrapperHomePage extends StatefulWidget {
  WrapperHomePage({Key? key}) : super(key: key);
  @override
  _WrapperHomePageState createState() => _WrapperHomePageState();
}

class _WrapperHomePageState extends State<WrapperHomePage> {

  int _selectedScreenIndex = 1;
  List<Widget> _screens = <Widget>[
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
      create: (context) => ProfilePageProvider(Provider.of<UserProfile>(context, listen: false)),
      builder: (context, _) {
        return ProfilePage();
      }
    ),
  ];
  List<BottomNavigationBarItem> _screenLabels = <BottomNavigationBarItem>[
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
