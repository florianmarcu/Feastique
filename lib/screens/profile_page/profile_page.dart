import 'package:feastique/screens/profile_page/profile_provider.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.watch<ProfilePageProvider>().user;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("Salut, ${user.displayName != null ? user.displayName : ""}!")
          )
        ],
      )
    );
  }
}