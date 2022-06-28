import 'package:feastique/models/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
export 'package:provider/provider.dart';

class PlaceProvider with ChangeNotifier{

  Place place;

  PlaceProvider(this.place);

  // Launches both Uber app and Place's Menu
  Future<void> launchUber(BuildContext context, [bool universalLinks = false]) async {

    String url = "https://m.uber.com/ul/?client_id=LNvSpVc4ZskDaV1rDZe8hGZy02dPfN84&action=setPickup&pickup[latitude]=" 
    + "44.43560743910277"+
    "&pickup[longitude]=" 
    + "26.10173633395698" +
    "&pickup[nickname]="
    + "" +
    "&pickup[formatted_address]="
    + "" +
    "&dropoff[latitude]="
    + place.location.latitude.toString() + 
    "&dropoff[longitude]="
    + place.location.longitude.toString() +
    "&dropoff[nickname]="
    + place.name.replaceAll(' ', '%20') +
    "&dropoff[formatted_address]="
    + "" +
    "&product_id="
    +"a1111c8c-c720-46c3-8534-2fcdd730040d"
    ;
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalNonBrowserApplication
        // universalLinksOnly: universalLinks,
        // forceSafariVC: false,
        // forceWebView: false,
        // headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else if(!universalLinks){
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Meniul nu este disponibil"
          )
        )
      );
    }
  }
}