import 'package:feastique/screens/place_page/place_provider.dart';
import 'package:flutter/material.dart';

class PlaceMenu extends StatelessWidget {
  const PlaceMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PlacePageProvider>();
    var place = provider.place;
    var categories;
    if(place.menu != null)
      categories = place.menu.keys.toList();
    return Container(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Menu",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) {
                return SizedBox(width: 15,);
              },
              itemBuilder: (context, index){
                return ChoiceChip(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                  backgroundColor:Colors.grey[200],
                  selectedColor: Theme.of(context).primaryColor,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                  selected: index == provider.selectedCategoryIndex,
                  label: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                       categories[index],
                      ),
                      // Text(
                      //   currentTime.add(Duration(days: index)).day.toString() 
                      //   + ' ' +
                      //   DateFormat('MMMM').format(currentTime.add(Duration(days: index))).substring(0,3),
                      // )
                    ],
                  ),
                  onSelected: (selected){
                    // provider.selectDay(index);
                    // _dayScrollController!.animateTo(
                    //   (index-1)*93.toDouble(),
                    //   duration: Duration(milliseconds: 500), 
                    //   curve: Curves.ease
                    // );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}