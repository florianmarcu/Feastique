import 'package:feastique/config/paths.dart';
import 'package:flutter/material.dart';


abstract class DetailTile extends StatelessWidget {}

enum Ambience {intimate, social}
class AmbienceDetailTile extends DetailTile{

  final String ambience;

  AmbienceDetailTile(this.ambience);
  
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image.asset(asset(ambience), width: 23,),
          SizedBox(width: 10,),
          Column(
            children: [
              Text("Atmosferă", style:Theme.of(context).textTheme.overline,),
              Text(_text(ambience), style:Theme.of(context).textTheme.labelMedium,),
            ],
          )/// Icon
        ],
      ),
    );
  }
  
  String _text(String ambience){
    switch(ambience){
      case "calm":
        return "Intim";
      case "social-friendly":
        return "Socială";
      default: return "";
    }
  }
}