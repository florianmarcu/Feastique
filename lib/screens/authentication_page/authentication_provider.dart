import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class AuthenticationPageProvider with ChangeNotifier{

  String? email;
  String? password;
  bool passwordVisible = false;
  bool isLoading = false;

  void logIn(BuildContext context) async{
    var result = await Authentication.signInWithEmailAndPassword(email!, password!);
    if(result.runtimeType == FirebaseAuthException)
      _handleAuthError(context, result);

    notifyListeners();
  }

  void setEmail(String? email){
    this.email = email;

    notifyListeners();
  }

  void setPassword(String? password){
    this.password = password;

    notifyListeners();
  }

  void setPasswordVisibility(){
    passwordVisible = !passwordVisible;

    notifyListeners();
  }

  /// Upon any error returned by the sign-in methods, shows a SnackBar accordignly
  void _handleAuthError(BuildContext context, FirebaseAuthException error){
    var errorCodeToText = {
      "invalid-email": "Emailul introdus este invalid", 
      "user-disabled": "Contul introdus este dezactivat", 
      "user-not-found": "Nu există utilizator pentru emailul introdus", 
      "wrong-password": "Combinația de email și parolă este greșită"
    };
    print(error.code);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorCodeToText[error.code]!),
      )
    ).closed
    .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }

  void _loading(){
    isLoading = !isLoading;

    notifyListeners();
  }
}