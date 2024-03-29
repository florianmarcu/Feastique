import 'package:feastique/screens/order_page/order_page.dart';
import 'package:feastique/screens/order_page/order_provider.dart';
import 'package:feastique/screens/wrapper_home_page/wrapper_home_provider.dart';
import 'package:feastique/widgets/app_drawer/app_drawer.dart';
import 'package:flutter/material.dart';


/// This Page is a Wrapper Page
/// It doesn't have a body of its own, but instead it wraps multiple different pages in a Navigation Bar manner
/// - Home Page
/// - Discover Page
/// - Reservations Page
/// - Profile Page
class WrapperHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<WrapperHomePageProvider>();
    var selectedScreenIndex = provider.selectedScreenIndex; 

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        // key: ,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedScreenIndex,
        items: provider.screenLabels,
        // onTap: (index) => provider.updateSelectedScreenIndex(index),
        onTap: (index) =>
        //  provider.updateSelectedScreenIndex(index)
        provider.pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn),

      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(210, 30), bottomRight: Radius.elliptical(210, 30))),
        title: Center(child: Text(provider.screenLabels[selectedScreenIndex].label!, style: Theme.of(context).textTheme.headline4,)),
      ),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: provider.activeReservation != null
      ? Align(
        alignment: Alignment(0,0.8),
        child: Container(
          height: 60,
          width: 250,
          child: FloatingActionButton.extended(
            label: Column(
              children: [
                Text(provider.activeReservation!.placeName, style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0, fontSize: 13, color: Colors.black),),
                SizedBox(height: 10,),
                Text("Comandă", style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 0),),
              ],
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderPageProvider(provider.activeReservation!),
                child: OrderPage()
              )
            )),
          ),
        ),
      )
      : Container(), /// Added for orders
      // body: Center(
      //   child: IndexedStack(
      //     children: provider.screens,
      //     index: selectedScreenIndex
      //   )
      // ),
      // body: provider.screens[selectedScreenIndex],
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: provider.pageController,
          onPageChanged: (index) => provider.updateSelectedScreenIndex(index),
          children: provider.screens
        ),
      ),
    );
  }
}
