import 'package:authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  
  final String uid;
  final String? email;
  final String? photoURL;
  final String? displayName;
  final bool? isAnonymous;
  String? phoneNumber;
  Future<bool>? isManager;

  UserProfile(this.uid, {this.email,this.photoURL, this.displayName, this.isAnonymous, this.phoneNumber});
}

/// Converts a User to UserProfile
UserProfile? userToUserProfile(User? user){
  if(user != null){

    var userProfile = UserProfile(
      user.uid,
      email: user.email,
      photoURL: user.photoURL,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName != null 
        ? user.displayName 
        : (user.email != null
          ? user.email!.substring(0,user.email!.indexOf('@'))
          : "Guest"),
      isAnonymous : user.isAnonymous,
    );

    _fetchExtraData(userProfile);
    
    return userProfile;

  }
  else return null;
}

void _fetchExtraData(UserProfile userProfile){
  bool isManager = false;

  FirebaseFirestore.instance.collection('users').doc(userProfile.uid).get()
  .then((doc){
    isManager = doc.data()!.containsKey('isManager') && doc.data()!['isManager'] == true;

  });
  //userProfile.isManager
}
