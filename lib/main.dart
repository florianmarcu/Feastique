import 'package:feastique/config/theme.dart';
import 'package:feastique/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/wrapper.dart';
import 'package:authentication/authentication.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  await config();
  runApp(Main());
}

/// The class that renders the whole MaterialApp
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      /// The providers for app's state
      providers: [
        /// The auth state of the app
        StreamProvider<UserProfile?>.value(  
          value: Authentication.user.map(userToUserProfile), 
          initialData: null
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Feastique',
        theme: theme(context),
        home: Wrapper(),
      ),
    );
  }
}

/// Handles all the configuration needed before the app launches
Future<void> config() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
}
