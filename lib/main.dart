import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feastique/config/theme.dart';
import 'package:feastique/models/models.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  await FirebaseAppCheck.instance.activate(
    // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  // FirebaseOptions firebaseOptions = const FirebaseOptions(
  //   appId: '1:1009284415459:web:3fe12199aeadcfcf326ad6',
  //   apiKey: 'AIzaSyBeApv-LQI5lDvkZUFD-5yiMLu55KOe6Bo',
  //   projectId: 'hyuga-app',
  //   messagingSenderId: '1009284415459',
  //   storageBucket: 'hyuga-app.appspot.com'
  // );
  // await Firebase.initializeApp(name: "hyuga",options: firebaseOptions);
  //await fillDb();
}

fillDb() async{
  var query2 = await FirebaseFirestore.instance.collection('places').get();
  query2.docs.forEach((doc) async{ 
    await doc.reference.set(
      {
        "city": "bucharest",
      },
      SetOptions(merge: true)
    );
  });
}
