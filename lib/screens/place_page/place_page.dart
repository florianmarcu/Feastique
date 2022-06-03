import 'package:feastique/screens/place_page/components/tiles/detail.dart';
import 'package:feastique/screens/place_page/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatefulWidget {

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
    var place = context.watch<PlaceProvider>().place;
    return Scaffold(
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
                child: Wrap(children: [
                AmbienceDetailTile(place.ambience)
              ],)), 
              Container(height: 1000)
            ]
          ))
        ],
      )
    );
  }

  /// TODO: Delete this
  // Ambience _ambience(String ambience){
  //   switch (ambience){
  //     case "calm":
  //       return Ambience.intimate;
  //     default: return Ambience.social;
  //   }
  // }
}