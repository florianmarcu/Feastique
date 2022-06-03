import 'package:feastique/config/constants.dart';
import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:flutter/material.dart';

class FiltersPopUpPage extends StatefulWidget {

  @override
  State<FiltersPopUpPage> createState() => _FiltersPopUpPageState();
}

class _FiltersPopUpPageState extends State<FiltersPopUpPage> {
  
  final _filters = kFilters;
  var _selectedTypes = kFilters['types']!.map((e) => false).toList();
  var _scrollPhysics = ScrollPhysics();
  
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DiscoverPageProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text("Filtrează", style: Theme.of(context).textTheme.headline6),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).highlightColor,
          child: IconButton(
            splashRadius: 28,
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: (){
              Navigator.pop(context);
            }
          ),
        ),
        actions: [
          TextButton(
            style: Theme.of(context).textButtonTheme.style!.copyWith(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).canvasColor)
            ),
            onPressed: (){},
            child: Text("Șterge filtre", style: Theme.of(context).textTheme.labelMedium!.copyWith(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.normal
            ),),
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            //shrinkWrap: true,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Text("Specific", style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Container(
                //color: Colors.red,
                height: 150,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 80,mainAxisExtent: 50), 
                  itemCount: _filters['types']!.length,
                  itemBuilder: (context, index){
                    return Container(
                      //width: 30,
                      // decoration: BoxDecoration(
                      // color: Colors.red,
                      //   borderRadius: BorderRadius.circular(30)
                      // ),
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).canvasColor,
                        labelStyle: Theme.of(context).textTheme.overline!,
                        label: Text(_filters['types']![index],),
                        selected: _selectedTypes[index],
                        onSelected: (selected){
                          setState(() {
                            _selectedTypes[index] = selected;
                          });
                        },
                        // value: index, 
                        // groupValue: index, 
                        // title: Text(_filters['types']![index], style: Theme.of(context).textTheme.overline,),
                        // onChanged: (index){
                          
                        // }
                      ),
                    );
                  }
                ),
              )
              // ToggleButtons(
              //   isSelected: _selectedTypes,
              //   children: _filters["types"]!.map<Widget>((type) =>  Container(
              //       child: Text("${type.toUpperCase()}")
              //     )
              //   ).toList(),
              // ),
            ],
          ),
        ),
      )
    );
  }
}


// class FiltersPopupPage extends PopupRoute {
  
//   DiscoverPageProvider _provider;
//   FiltersPopupPage(this._provider);

//   Widget build(BuildContext context) {

//     var provider = _provider;
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).canvasColor,
//         centerTitle: true,
//         title: Text("Filtrează", style: Theme.of(context).textTheme.headline6),
//         leading: CircleAvatar(
//           backgroundColor: Theme.of(context).highlightColor,
//           child: IconButton(
//             splashRadius: 28,
//             icon: Icon(Icons.arrow_back),
//             color: Colors.black,
//             onPressed: (){
//               Navigator.pop(context);
//             }
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Specific", style: Theme.of(context).textTheme.labelMedium,),
//             Wrap(),

//           ],
//         ),
//       )
//     );
//   }

//   @override
//   Color? get barrierColor => Colors.transparent;

//   @override
//   bool get barrierDismissible => false;

//   @override
//   String? get barrierLabel => "filters-popup";

//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//     return build(context);
//   }

//   @override
//   Duration get transitionDuration => Duration(milliseconds: 500);

//   @override
//   Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//     var _animation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
//     return SlideTransition(
//       child: child,
//       //child: ClipPath(child: child, clipper: _clipper,),
//       position: Tween<Offset>(
//         begin: Offset(0,-1),
//         end: Offset(0,0)
//       ).animate(_animation),
//     );
//   }
// }