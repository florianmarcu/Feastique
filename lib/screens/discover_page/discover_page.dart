import 'package:feastique/config/paths.dart';
import 'package:feastique/screens/discover_page/components/filters_popup.dart';
import 'package:feastique/screens/discover_page/components/places_list.dart';
import 'package:feastique/screens/discover_page/components/places_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'discover_provider.dart';

class DiscoverPage extends StatefulWidget {
  
  final BuildContext context;
  
  DiscoverPage(this.context);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DiscoverPageProvider>();
    var viewType = provider.viewType;
    var viewTypeText = viewType == "map" ? "Listă" : "Hartă";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Container(height: MediaQuery.of(context).padding.top),
            Container(
              alignment: Alignment(0,0),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row( /// The 'Row' of options buttons
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10, vertical: 0))),
                    label: Text("Filtre", style: Theme.of(context).textTheme.caption,),
                    icon: Image.asset(asset('filter'), width: 15, color: Theme.of(context).highlightColor,),
                    onPressed: (){
                      showGeneralDialog(
                        context: context,
                        transitionDuration: Duration(milliseconds: 300),
                        transitionBuilder: (context, animation, secondAnimation, child){
                          var _animation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
                          return SlideTransition(
                            child: child,
                            //child: ClipPath(child: child, clipper: _clipper,),
                            position: Tween<Offset>(
                              begin: Offset(0,-1),
                              end: Offset(0,0)
                            ).animate(_animation),
                          );
                        },
                        pageBuilder: ((context, animation, secondaryAnimation) => ChangeNotifierProvider.value(
                          value: provider,
                          builder: (context, child) => FiltersPopUpPage()
                        )
                      ));
                      // showGeneralDialog(
                      //   context: context,
                      //   transitionDuration: Duration(milliseconds: ),
                      //   transitionBuilder: (context, animation, secondAnimation, child){
                      //     var _animation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
                      //     return SlideTransition(
                      //       child: child,
                      //       //child: ClipPath(child: child, clipper: _clipper,),
                      //       position: Tween<Offset>(
                      //         begin: Offset(0,-1),
                      //         end: Offset(0,0)
                      //       ).animate(_animation),
                      //     );
                      //   },
                      //   pageBuilder: ((context, animation, secondaryAnimation) => ChangeNotifierProvider(
                      //     create: (context) => context.read<DiscoverPageProvider>(),
                      //     builder:( context, child) => FiltersPopupPage()
                      //   )
                      // ));
                    },
                  ),
                  SizedBox(width: 10),
                  TextButton.icon(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 10, vertical: 0))),
                    label: Text(viewTypeText, style: Theme.of(context).textTheme.caption,),
                    icon: Image.asset(asset('list'), width: 15, color: Theme.of(context).highlightColor,),
                    onPressed: () => provider.changeViewType()
                  ),
                ],
              ),
            ),
          ],
        )
      ),
      body: viewType == "map" 
      ? PlacesMap()
      : PlacesList()
      
    );
    // return FlutterMap(
    //   options: MapOptions(
    //     center: LatLng(44.427466, 26.102500),
    //     zoom: 14,
    //     interactiveFlags: InteractiveFlag.doubleTapZoom | InteractiveFlag.drag | InteractiveFlag.pinchMove | InteractiveFlag.pinchZoom
    //   ),
    //   layers: [
    //     TileLayerOptions(
    //       urlTemplate: "https://mt0.google.com/vt/lyrs=m@221097413,traffic,transit,bike&x={x}&y={y}&z={z}",
    //       subdomains: ['a', 'b', 'c'],
    //       // attributionBuilder: (_) {
    //       //   return Text("© OpenStreetMap contributors");
    //       // },
    //       retinaMode: true
    //     ),
    //     MarkerLayerOptions(
    //       markers: [
    //         Marker(
    //           width: 80.0,
    //           height: 80.0,
    //           point: LatLng(44.427466, 26.102500),
    //           builder: (ctx) =>
    //           Container(
    //             child: FlutterLogo(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );

  }
}