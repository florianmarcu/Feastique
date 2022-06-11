import 'package:authentication/authentication.dart';
import 'package:feastique/models/models.dart';
import 'package:feastique/screens/authentication_page/authentication_page.dart';
import 'package:feastique/screens/authentication_page/authentication_provider.dart';
import 'package:feastique/screens/discover_page/discover_provider.dart';
import 'package:feastique/screens/home_page/home_provider.dart';
import 'package:feastique/screens/profile_page/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'wrapper_home_page/wrapper_home_page.dart';

/// Class that handles the UI according to the authentication state:
///   - logged in
///   - logged out
class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProfile?>(context);
    print(Authentication.currentUser);
    // Logged out
    if(user == null)
      return ChangeNotifierProvider(
        create: (context) => AuthenticationPageProvider(),
        child: AuthenticationPage()
      );
    // Logged in
    else 
      return WrapperHomePage();
  }
}