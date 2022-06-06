import 'package:feastique/config/constants.dart';
import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:flutter/material.dart';

class FiltersPopUpPage extends StatefulWidget {

  @override
  State<FiltersPopUpPage> createState() => _FiltersPopUpPageState();
}

class _FiltersPopUpPageState extends State<FiltersPopUpPage> {
  
  final _filters = kFilters;
  // var _selectedTypes = kFilters['types']!.map((e) => false).toList();
  // var _selectedAmbiences = kFilters['ambiences']!.map((e) => false).toList();
  // var _selectedCosts = kFilters['costs']!.map((e) => false).toList();
  List<bool> _selectedTypes = [];
  List<bool> _selectedAmbiences = [];
  List<bool> _selectedCosts = [];
  var _filtersSelected = false;
  
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DiscoverPageProvider>();
    var selectedFilters = context.watch<DiscoverPageProvider>().activeFilters;
    _selectedTypes = selectedFilters['types'];
    _selectedAmbiences = selectedFilters['ambiences'];
    _selectedCosts = selectedFilters['costs'];
    _filtersSelected = _selectedTypes.fold(false, (prev, curr) => prev || curr) || _selectedAmbiences.fold(false, (prev, curr) => prev || curr) || _selectedCosts.fold(false, (prev, curr) => prev || curr);
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        shape: ContinuousRectangleBorder(),
        backgroundColor: _filtersSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColor.withOpacity(0.6),
        onPressed: _filtersSelected 
        ? () {
          provider.filter({"types": _selectedTypes, "ambiences" : _selectedAmbiences, "costs": _selectedCosts});
          Navigator.pop(context);
        } 
        : null,
        label: Container(
          width: MediaQuery.of(context).size.width,
          child: Text("Aplică", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4,),
        ),
      ),
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
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Text("Specific", style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Container(
                height: 150,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 80,mainAxisExtent: 50), 
                  itemCount: _filters['types']!.length,
                  itemBuilder: (context, index){
                    return Container(
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                        pressElevation: 0,
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
                      ),
                    );
                  }
                ),
              ),
              Text("Atmosferă", style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Container(
                height: 150,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 80,mainAxisExtent: 50), 
                  itemCount: _filters['ambiences']!.length,
                  itemBuilder: (context, index){
                    return Container(
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                        pressElevation: 0,
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Theme.of(context).canvasColor,
                        labelStyle: Theme.of(context).textTheme.overline!,
                        label: Text(kAmbiences[_filters['ambiences']![index]]!,),
                        selected: _selectedAmbiences[index],
                        onSelected: (selected){
                          setState(() {
                            _selectedAmbiences[index] = selected;
                          });
                        },
                      ),
                    );
                  }
                ),
              ),
              Text("Preț", style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Container(
                height: 150,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 80,mainAxisExtent: 50), 
                  itemCount: _filters['costs']!.length,
                  itemBuilder: (context, index){
                    return ChoiceChip(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                      pressElevation: 0,
                      selectedColor: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).canvasColor,
                      labelStyle: Theme.of(context).textTheme.overline!,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(int.parse(_filters['costs']![index]), (index) => 
                        Container(
                          child: Text('\$', textAlign: TextAlign.center),
                        )
                      )),
                      selected: _selectedCosts[index],
                      onSelected: (selected){
                        setState(() {
                          _selectedCosts[index] = selected;
                        });
                      },
                    );
                  }
                ),
              )
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