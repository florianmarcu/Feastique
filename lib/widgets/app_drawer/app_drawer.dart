import 'package:authentication/authentication.dart';
import 'package:feastique/models/user/user.dart';
import 'package:feastique/screens/manager_home_page/manager_home_page.dart';
import 'package:feastique/screens/manager_home_page/manager_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// The app's drawer
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProfile>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user.displayName!, 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                )
              ), 
              accountEmail: Text(user.email!),
              currentAccountPicture: user.photoURL == null
              ? Icon(Icons.person, size: 40, color: Theme.of(context).highlightColor,)
              : Image.network(user.photoURL!),
              //accountName: Text(""), 
              // accountEmail: Text("")
            ),
            MaterialButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => ManagerHomePageProvider(),
                      child: ManagerHomePage()
                    )
                  )
                );
              },
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  Icon(Icons.settings),
                  SizedBox(width: 10,),
                  Text("Manager")
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            TextButton(
              child: Text("Ieși din cont"),
              onPressed: () => Authentication.signOut(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08)
          ],
        ),
      ),
    );
  }
}