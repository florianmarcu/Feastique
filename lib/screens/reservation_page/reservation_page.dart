import 'package:feastique/screens/reservation_page/reservation_provider.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<ReservationProvider>();
    return Scaffold(
      body: Center(
        child: Text(provider.reservation.id)
      )
    );
  }
}