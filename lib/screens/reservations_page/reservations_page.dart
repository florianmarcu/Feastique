import 'package:feastique/config/config.dart';
import 'package:feastique/screens/reservations_page/reservations_provider.dart';
import 'package:flutter/material.dart';

class ReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ReservationsPageProvider>();
    var pastReservations = provider.pastReservations;
    var upcomingReservations = provider.upcomingReservations;
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 25, right: 25),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Rezervări viitoare",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: upcomingReservations == null ? 1 : upcomingReservations.length,
            itemBuilder: (context, index){
              print(upcomingReservations.toString() + " REZERVARI");
              if(upcomingReservations == null)
                return Container(
                  padding: EdgeInsets.only(top: 95),
                  height: 5,
                  child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), backgroundColor: Colors.transparent,)
                );
              else {
                var reservation = upcomingReservations[index];
                print(reservation);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Theme.of(context).highlightColor,
                    //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 100,
                    child: Row(
                      children: [
                        FutureProvider<Image?>.value(
                          value: provider.getImage(reservation.placeId),
                          initialData: null,
                          builder: (context, child){
                            var image = Provider.of<Image?>(context);
                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: image != null 
                              ? AspectRatio(
                                aspectRatio: 1.5,
                                child: image,
                              )
                              : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), backgroundColor: Colors.transparent,)
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reservation.placeName, style: Theme.of(context).textTheme.labelMedium),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text.rich( /// The Date
                                    TextSpan(
                                      children: [
                                        WidgetSpan(child: Image.asset(asset('calendar'), width: 18)),
                                        WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(
                                          text: formatDateToDay(reservation.dateStart)
                                        ),
                                      ]
                                    )
                                  ),
                                  Text.rich( /// The Time 
                                    TextSpan(
                                      children: [
                                        WidgetSpan(child: Image.asset(asset('time'), width: 18)),
                                        WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(
                                          text: formatDateToHourAndMinutes(reservation.dateStart)
                                        ),
                                      ]
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }
            }
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal : 10),
            child: Text(
              "Rezervări trecute",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(height: 15,),
          SizedBox(height: 15),
          ListView.builder( 
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: pastReservations == null ? 1 : pastReservations.length,
            itemBuilder: (context, index){
              print(pastReservations.toString() + " REZERVARI");
              if(pastReservations == null)
                return Container(
                  padding: EdgeInsets.only(top: 95),
                  height: 5,
                  child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), backgroundColor: Colors.transparent,)
                );
              else {
                var reservation = pastReservations[index];
                print(reservation);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Theme.of(context).highlightColor,
                    //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 100,
                    child: Row(
                      children: [
                        FutureProvider<Image?>.value(
                          value: provider.getImage(reservation.placeId),
                          initialData: null,
                          builder: (context, child){
                            var image = Provider.of<Image?>(context);
                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: image != null 
                              ? AspectRatio(
                                aspectRatio: 1.5,
                                child: image,
                              )
                              : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), backgroundColor: Colors.transparent,)
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reservation.placeName, style: Theme.of(context).textTheme.labelMedium),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text.rich( /// The Date
                                    TextSpan(
                                      children: [
                                        WidgetSpan(child: Image.asset(asset('calendar'), width: 18)),
                                        WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(
                                          text: formatDateToDay(reservation.dateStart)
                                        ),
                                      ]
                                    )
                                  ),
                                  Text.rich( /// The Time 
                                    TextSpan(
                                      children: [
                                        WidgetSpan(child: Image.asset(asset('time'), width: 18)),
                                        WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(
                                          text: formatDateToHourAndMinutes(reservation.dateStart)
                                        ),
                                      ]
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }
            }
          ),
        ],
      ),
    );
  }
}