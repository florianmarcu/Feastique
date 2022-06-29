import 'package:feastique/config/config.dart';
import 'package:feastique/screens/new_reservation_popup_page/new_reservation_popup_page.dart';
import 'package:feastique/screens/new_reservation_popup_page/new_reservation_popup_provider.dart';
import 'package:feastique/screens/place_page/components/tiles/detail.dart';
import 'package:feastique/screens/place_page/components/tiles/menu.dart';
import 'package:feastique/screens/place_page/components/tiles/place_map.dart';
import 'package:feastique/screens/place_page/place_provider.dart';
import 'package:feastique/screens/wrapper_home_page/wrapper_home_provider.dart';
import 'package:flutter/material.dart';

class PlacePage extends StatefulWidget {

  final BuildContext context;

  PlacePage(this.context);

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {

  var offset = 0.0;

  final _scrollController = ScrollController(
    keepScrollOffset: true,
    initialScrollOffset: 0
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PlacePageProvider>();
    var wrapperHomePageProvider = context.watch<WrapperHomePageProvider>();
    var place = provider.place;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0, 
        shape: ContinuousRectangleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            // elevation: 0,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).primaryColor,
            barrierColor: Colors.black.withOpacity(0.35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            builder: (context) => ChangeNotifierProvider<NewReservationPopupProvider>(
              create:(context) => NewReservationPopupProvider(place),
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column( 
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(height: 4, width: 40, margin: EdgeInsets.symmetric(vertical: 4), decoration: BoxDecoration(color: Theme.of(context).canvasColor,borderRadius: BorderRadius.circular(30),)),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                      child: Container(
                        color: Theme.of(context).canvasColor,
                        child: NewReservationPopupPage(context)
                      )
                    ),
                  ],
                ),
              )
            )
          );
        },
        label: Container(
          width: MediaQuery.of(context).size.width,
          child: Text("Rezervă o masă", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),),
        ),
      ),
      body:  CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.only( /// Creates a dynamic Padding for the title as the Page is scrolled
                left: MediaQuery.of(context).size.width*0.06 + offset/5 < MediaQuery.of(context).size.width*0.18
                ? MediaQuery.of(context).size.width*0.06 + offset/5
                : MediaQuery.of(context).size.width*0.18, 
                bottom: 14,
              ),
              title: Text(place.name, style: Theme.of(context).textTheme.headline3),
              background: Container(
                height: 280 + MediaQuery.of(context).padding.top,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    /// The Profile Image of the place
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(150,30), bottomRight: Radius.elliptical(200,50)),
                          child: Container(
                            height: 220 + MediaQuery.of(context).padding.top,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(150,30), bottomRight: Radius.elliptical(200,50)),
                          child: Container(
                            height: 200 + MediaQuery.of(context).padding.top,
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: FutureBuilder<Image>(
                                future: place.image,
                                builder: (context, image){  
                                  if(place.finalImage == null)
                                    return Container(
                                      width: 400,
                                      height: 200,
                                      color: Colors.transparent,
                                    );
                                  else 
                                    return place.finalImage!;
                                    
                                }
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 60,
                      color: Theme.of(context).canvasColor,
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Theme.of(context).canvasColor,
            pinned: true,
            //floating: true,
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).canvasColor,
              child: IconButton(
                splashRadius: 28,
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: (){
                  Navigator.pop(context);
                }
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AmbienceDetailTile(place.ambience),
                    CostDetailTile(place.cost)
                  ],
                )
              ), 
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: place.types!.map((type) => TypeDetailTile(type)).toList(),
                )
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    //width: 20,
                    child: TextButton.icon(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                        //backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20))
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(value: provider,),
                            ChangeNotifierProvider.value(value: wrapperHomePageProvider,)
                          ],
                          child: PlaceMapPage()
                        ))
                      ),
                      icon: Image.asset(localAsset("map"), width: 20,),
                      label: Text("Vezi pe hartă", style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 13),),
                    ),
                  ),
                  SizedBox(width: 30,),
                  SizedBox(
                    width: 80,
                    child: TextButton(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)
                      ),
                      onPressed: () => provider.launchUber(context, wrapperHomePageProvider.currentLocation),
                      //icon: Image.asset(asset("map"), width: 20,),
                      child: Text("Uber", style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 13),),
                    ),
                  ),
                  
                ],
              ),
              SizedBox(height: 30,),
              // place.schedule != null
              // ? Container( // The 'Schedule'
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: place.schedule!.keys.map((String? key) => Column(
              //         children: <Widget>[
              //           Container(
              //             margin: EdgeInsets.symmetric(vertical: 8),
              //             child: Text(place.schedule![key]!.substring(0,2))
              //           ),
              //           Text(
              //             place.schedule![key!.toLowerCase()].substring(0,5),
              //           ),
              //           Text(
              //             place.schedule![key.toLowerCase()].substring(6,11),
              //           )
              //         ],
              //       ),
              //     ).toList()
              //   )
              // )
              // : Container(),
              SizedBox(height: 20,),
              Image.network("https://firebasestorage.googleapis.com/v0/b/hyuga-app.appspot.com/o/photos%2Feurope%2Fbucharest%2Fmartina_ristorante%2Fmartina_ristorante_2.jpg?alt=media&token=add0f082-783d-4b83-9131-8553cf087987"),
              SizedBox(height: 30,),
              PlaceMenu()
              //,Container(height: 1000)
            ]
          ))
        ],
      )
    );
  }
}