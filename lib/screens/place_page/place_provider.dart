import 'package:feastique/models/models.dart';
import 'package:flutter/cupertino.dart';
export 'package:provider/provider.dart';

class PlaceProvider with ChangeNotifier{

  Place place;

  PlaceProvider(this.place);
}