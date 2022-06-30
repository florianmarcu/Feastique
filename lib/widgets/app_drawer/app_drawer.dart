import 'package:authentication/authentication.dart';
import 'package:feastique/screens/manager_home_page/manager_home_page.dart';
import 'package:feastique/screens/manager_home_page/manager_home_provider.dart';
import 'package:feastique/screens/wrapper_home_page/wrapper_home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// The app's drawer
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<WrapperHomePageProvider>().currentUser!;
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user.displayName, 
                style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 25)
              ), 
              accountEmail: Text(user.email != null ? user.email! : ""),
              currentAccountPicture: user.photoURL == null
              ? Icon(Icons.person, size: 40, color: Theme.of(context).highlightColor,)
              : ClipRRect(borderRadius: BorderRadius.circular(30), child: Image.network(user.photoURL!)),
            ),
            /// If the user is manager, allow him to see the manager panel
            user.isManager == true
            ? MaterialButton(
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
            )
            : Container(),
            Expanded(
              child: Container(),
            ),
            TextButton(
              child: Text(
                !user.isAnonymous
                ? "Ieși din cont"
                : "Log In"
              ),
              onPressed: () => Authentication.signOut(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.08)
          ],
        ),
      ),
    );
  }
}