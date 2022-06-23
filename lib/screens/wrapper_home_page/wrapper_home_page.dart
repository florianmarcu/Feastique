import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:feastique/screens/order_page/order_page.dart';
import 'package:feastique/screens/order_page/order_provider.dart';
import 'package:feastique/screens/profile_page/profile_provider.dart';
import 'package:feastique/screens/reservations_page/reservations_provider.dart';
import 'package:feastique/screens/wrapper_home_page/wrapper_home_provider.dart';
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
  
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<WrapperHomePageProvider>();
    var selectedScreenIndex = provider.selectedScreenIndex; 

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedScreenIndex,
        items: provider.screenLabels,
        onTap: (index) => provider.updateSelectedScreenIndex(index),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(210, 30), bottomRight: Radius.elliptical(210, 30))),
        title: Center(child: Text(provider.screenLabels[selectedScreenIndex].label!, style: Theme.of(context).textTheme.headline4,)),
        // bottom: PreferredSize(
        //   preferredSize: Size(MediaQuery.of(context).size.width, 80),
        //   child: Row(children: [
            
        //   ],)
        // ),
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Align(
        alignment: Alignment(0,0.8),
        child: Container(
          height: 60,
          width: 250,
          child: FloatingActionButton.extended(
            //extendedPadding: EdgeInsets.symmetric(vertical: 10),
            // icon: Container(
            //   padding:EdgeInsets.symmetric(vertical: 10),
            //   width: 80,
            //   child: Image.network(
            //     "https://firebasestorage.googleapis.com/v0/b/feastique.appspot.com/o/places%2Fmartina_ristorante%2F0.jpg?alt=media&token=251f96d7-b724-415a-a2b6-a5bc5643bbbc"

            //   ),
            // ),
            label: Column(
              children: [
                Text("Martina Ristorante Pizzeria", style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0, fontSize: 13, color: Colors.black),),
                SizedBox(height: 10,),
                Text("Comandă", style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0),),
              ],
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => OrderPageProvider(),
                            child: OrderPage()
                          )
                        )),
          ),
        ),
      ), /// Added for orders
      body: Center(
        child: IndexedStack(
          children: provider.screens,
          index: selectedScreenIndex
        )
      ),
    );
  }
}
