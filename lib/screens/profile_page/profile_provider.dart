import 'package:feastique/models/user/user.dart';
import 'package:flutter/widgets.dart';
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