import 'package:authentication/authentication.dart';
import 'package:feastique/models/models.dart';
import 'package:feastique/screens/authentication_page/authentication_page.dart';
import 'package:feastique/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Class that handles the UI according to the authentication state:
///   - logged in
///   - logged out
class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProfile?>(context);
    print(Authentication.currentUser);
    // Logged in
    if(user != null)
      return HomePage();
    // Logged out
    else 
      return AuthenticationPage();
  }
}