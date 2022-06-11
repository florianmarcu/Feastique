import 'package:flutter/widgets.dart';
import 'package:feastique/models/models.dart';
export 'package:provider/provider.dart';

class ReservationProvider with ChangeNotifier{
  
  Reservation reservation;

  ReservationProvider(this.reservation);

}