import 'package:feastique/models/user/user.dart';
import 'package:flutter/widgets.dart';

class ProfilePageProvider with ChangeNotifier{

  UserProfile user;

  ProfilePageProvider(this.user);

}