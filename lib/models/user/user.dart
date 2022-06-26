import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  
  final String uid;
  final String? email;
  final String? photoURL;
  final String? displayName;
  final bool isAnonymous;
  String? phoneNumber;
  bool isManager = false;

  UserProfile({required this.uid, this.email, this.photoURL, this.displayName, required this.isAnonymous, this.phoneNumber});
}

/// Converts a User to UserProfile
Future<UserProfile?> userToUserProfile(User? user) async{
  if(user != null){
    var userProfile = UserProfile(
      uid: user.uid,
      email: user.email,
      photoURL: user.photoURL,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName != null 
        ? user.displayName 
        : (user.email != null
          ? user.email!.substring(0,user.email!.indexOf('@'))
          : "Oaspete"),
      isAnonymous : user.isAnonymous,
    );

    /// Fetch extra data from the user's document in Firestore (users/{user})  
    if(!user.isAnonymous)
      await FirebaseFirestore.instance.collection('users').doc(userProfile.uid).get()
      .then((doc){
        userProfile.isManager = doc.data()!.containsKey('manager') && doc.data()!['manager'] == true;
      });
    
    return userProfile;

  }
  else return null;
}
