import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/config/config.dart';
import 'package:feastique/models/models.dart';
import 'package:feastique/screens/manager_orders_page/manager_orders_provider.dart';
import 'package:flutter/material.dart';

class ManagerOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ManagerOrdersProvider>();
    return Scaffold(
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: provider.getReservation(),
        builder: (context,AsyncSnapshot<List<DocumentSnapshot>> ss) {
          print(ss.data!.length);
          if(!ss.hasData)
            return Container();
          else 
          return ListView(
            padding: EdgeInsets.all(20),
            children: ss.data!.map((doc){

              return Column(
                children: [
                  ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Theme.of(context).highlightColor,
                            //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            height: 100,
                            child: Row(
                              children: [
                                SizedBox(width: 20,),
                                // FutureProvider<Image?>.value(
                                //   value: provider.getImage(reservation.placeId),
                                //   initialData: null,
                                //   builder: (context, child){
                                //     var image = Provider.of<Image?>(context);
                                //     return SizedBox(
                                //       width: 100,
                                //       height: 100,
                                //       child: image != null 
                                //       ? AspectRatio(
                                //         aspectRatio: 1.5,
                                //         child: image,
                                //       )
                                //       : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), backgroundColor: Colors.transparent,)
                                //     );
                                //   },
                                // ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Comandă noua la ${formatDateToHourAndMinutes(DateTime.fromMillisecondsSinceEpoch(doc.data()!['date_created'].millisecondsSinceEpoch))}", style: Theme.of(context).textTheme.labelMedium),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //   children: [
                                      //     Text.rich( /// The Date
                                      //       TextSpan(
                                      //         children: [
                                      //           WidgetSpan(child: Image.asset(asset('calendar'), width: 18)),
                                      //           WidgetSpan(child: SizedBox(width: 10)),
                                      //           TextSpan(
                                      //             text: formatDateToDay(reservation.dateStart)
                                      //           ),
                                      //         ]
                                      //       )
                                      //     ),
                                      //     Text.rich( /// The Time 
                                      //       TextSpan(
                                      //         children: [
                                      //           WidgetSpan(child: Image.asset(asset('time'), width: 18)),
                                      //           WidgetSpan(child: SizedBox(width: 10)),
                                      //           TextSpan(
                                      //             text: formatDateToHourAndMinutes(reservation.dateStart)
                                      //           ),
                                      //         ]
                                      //       )
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ),
                        ),
                        Container(height: 20,)
                ],
              );
            }

            ).toList(),
          );
        }
      ),
    );
  }
}