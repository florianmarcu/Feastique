import 'package:feastique/screens/reservation_page/reservation_provider.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {

  final _scrollController = ScrollController(
    keepScrollOffset: true,
    initialScrollOffset: 0
  );

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ReservationProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //toolbarHeight: 70,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(210, 30), bottomRight: Radius.elliptical(210, 30))),
        title: Center(child: Text("Rezervare confirmată", style: Theme.of(context).textTheme.headline4,)),
        // bottom: PreferredSize(
        //   preferredSize: Size(MediaQuery.of(context).size.width, 80),
        //   child: Row(children: [
            
        //   ],)
        // ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Text(provider.reservation.id),
            ]),
          ),
        ],
      )
    );
  }
}