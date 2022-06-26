import 'package:feastique/models/user/user.dart';
import 'package:feastique/screens/wrapper_home_page/wrapper_home_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
export 'package:provider/provider.dart';

class ProfilePageProvider with ChangeNotifier{

  UserProfile user;
  BuildContext context;
  Map<String, dynamic>? configData;
  List<Map<String, dynamic>>? cities;
  Map<String, dynamic>? city;
  
 
  ProfilePageProvider(this.context, this.user){
    getData(context);
  }
    
  void getData(BuildContext context){
  }

}