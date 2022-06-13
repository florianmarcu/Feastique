import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_auth/firebase_auth.dart';

/// A singleton class that handles the entire authentication process of the app
class Authentication{
    static final FirebaseAuth _auth = FirebaseAuth.instance;
    static final FirebaseFirestore _db = FirebaseFirestore.instance;
    static User? currentUser;

  /// Auth state of the app as a stream
  static Stream<User?> get user{
    return _auth.authStateChanges();
  }

  /// Creates a new user document in the Firestore for a new signed up user
  static void updateUserData(User user, [String? credentialProvider]) async{
    DocumentReference ref = _db.collection('users').doc(user.uid);
    DocumentSnapshot doc = await ref.get();
    //await _saveDeviceToken(user.uid);
    if(doc.data() == null){
      //AnalyticsService().analytics.logSignUp(signUpMethod: credentialProvider!);
      // Commented temporarly in order to skip the tutorial
      // g.isNewUser = true;
      ref.set({
        'uid' : user.uid,
        'email' : user.email,
        'photoURL' : user.photoURL,
        'display_name' : (user.displayName != null || user.isAnonymous == true) ? user.displayName : user.email!.substring(0,user.email!.indexOf('@')),
        'date_registered': FieldValue.serverTimestamp(),
        'provider': credentialProvider
        },
        SetOptions(merge: true)
      );
    }
  }

  // Sign in by email and password
  static Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // User? user = result.user;
      // if(user != null)
      //   updateUserData(user, 'email_and_password');
      //AnalyticsService().analytics.logLogin(loginMethod: 'email_and_password');
      return result;
    }
    catch(error){
      print(error);
      return error;
    }
  }

  /// Register with email and password
  static Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(result.user != null)
        updateUserData(result.user!,'email_and_password');
      return result;
    }
    catch(error){
      return error;
    }
  }

  /// Sign out
  static Future signOut() async{
    try{
      await _auth.signOut();
    }
    catch(error){
      return(error);
    }
  }

  Authentication._init(){
    user.listen((user) {
      currentUser = user;
    });
  }
  static final Authentication _instance = Authentication._init();
  factory Authentication() => _instance;

}