import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {

  final List<Map<String, dynamic>> products = [
    {
      "title": "Pizza Margherita",
      "content": "Pizza Margherita, cu blat subțire și diametru de 40 cm",
      "ingredients": ["aluat, sos de roșii, brânză mozzarella"],
      "alergens" : ["lactoză", "gluten"],
      "price": "29RON",
    },
    {
      "title": "Pizza Capricciosa",
      "content": "Pizza Capricciosa, cu blat subțire și diametru de 40 cm",
      "ingredients": ["aluat, sos de roșii, brânză mozzarella", "ciuperci"],
      "alergens" : ["lactoză", "gluten"],
      "price": "31RON",
    },
    {
      "title": "Pizza Suprema",
      "content": "Pizza Suprema, cu blat subțire și diametru de 40 cm",
      "ingredients": ["aluat, sos de roșii, brânză mozzarella", "ciuperci", "porumb", "prosciutto crudo"],
      "alergens" : ["lactoză", "gluten"],
      "price": "35RON",
    },
    {
      "title": "Spaghetti Carbonara",
      "content": "Spaghetti Carbonara după rețeta tradițională",
      "ingredients": ["ou, parmezan, brânză mozzarella", "spaghette"],
      "alergens" : ["lactoză", "gluten", "ou"],
      "weight" : "350g",
      "price": "33RON",
    },
    {
      "title": "Spaghetti Bolognese",
      "content": "Pizza Capricciosa, cu blat subțire și diametru de 40 cm",
      "ingredients": ["sos de roșii, carne de vită", "spaghetti", "morcovi"],
      "alergens" : ["gluten"],
      "price": "35RON",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0, 
        shape: ContinuousRectangleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          // showModalBottomSheet(
          //   context: context, 
          //   // elevation: 0,
          //   isScrollControlled: true,
          //   backgroundColor: Theme.of(context).primaryColor,
          //   barrierColor: Colors.black.withOpacity(0.35),
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          //   builder: (context) => ChangeNotifierProvider<NewReservationPopupProvider>(
          //     create:(context) => NewReservationPopupProvider(place),
          //     child: Container(
          //       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          //       child: Column( 
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(30),
          //             child: Container(height: 4, width: 40, margin: EdgeInsets.symmetric(vertical: 4), decoration: BoxDecoration(color: Theme.of(context).canvasColor,borderRadius: BorderRadius.circular(30),)),
          //           ),
          //           ClipRRect(
          //             borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          //             child: Container(
          //               color: Theme.of(context).canvasColor,
          //               child: NewReservationPopupPage(context)
          //             )
          //           ),
          //         ],
          //       ),
          //     )
          //   )
          // );
        },
        label: Container(
          width: MediaQuery.of(context).size.width,
          child: Text("Trimite comandă", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(210, 30), bottomRight: Radius.elliptical(210, 30))),
        title: Center(child: Text("Comandă", style: Theme.of(context).textTheme.headline4,)),
        // bottom: PreferredSize(
        //   preferredSize: Size(MediaQuery.of(context).size.width, 80),
        //   child: Row(children: [
            
        //   ],)
        // ),
        
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Image.network(
            "https://firebasestorage.googleapis.com/v0/b/feastique.appspot.com/o/places%2Fmartina_ristorante%2F0.jpg?alt=media&token=251f96d7-b724-415a-a2b6-a5bc5643bbbc"          )
          ,SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Martina Ristorante Pizzeria", style: Theme.of(context).textTheme.headline6,),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: (){},
            child: Text("Comenzi trecute")
          )
          ,SizedBox(height: 30),

          ListView(
            padding: EdgeInsets.only(left: 20,right: 20),
            shrinkWrap: true,
            children: products.map((product) =>
              ListTile(
                //selected: true,
                //selectedColor: Theme.of(context).primaryColor,
                title: Text(product['title'], style: Theme.of(context).textTheme.labelMedium,),
                subtitle: Text(product['ingredients'][0],  style: Theme.of(context).textTheme.overline),
                selectedTileColor: Theme.of(context).primaryColor,
                trailing: Container(
                  width: 102,
                  child: Row(
                    children: [
                      IconButton(icon: Text("-"), onPressed: (){}, color: Colors.black,),
                      Text("1"),
                      IconButton(icon: Text("+",), onPressed: (){}, color: Colors.black,)
                    ],
                  ),
                )
              ) 
            ).toList()
          )
        ],
      ),
    );
  }
}