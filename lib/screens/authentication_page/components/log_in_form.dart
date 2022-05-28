import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({ Key? key }) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {

  bool _passwordVisible = false;
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Email field
          TextFormField(
            decoration: InputDecoration(
              labelText: "Email",
            ),
            onChanged: (value) => setState(()=> _email = value),
          ),
          SizedBox(height: 20),
          /// Password field
          TextFormField(
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: "Parolă", 
              suffixIcon: IconButton(
                highlightColor: Colors.grey[200],
                splashColor: Colors.grey[400],
                icon: Icon(Icons.visibility, color: Theme.of(context).highlightColor,), 
                onPressed: () => setState(() => _passwordVisible = !_passwordVisible), 
                padding: EdgeInsets.zero, 
              ),
            ),
            onChanged: (value) => setState(()=> _password = value),
          ),
          SizedBox(height: 30,),
          TextButton(
            onPressed: () async{
              var result = await Authentication.signInWithEmailAndPassword(_email, _password);
              if(result.runtimeType == FirebaseAuthException)
                _handleAuthError(context, result);
            },
            child: Text("Log in"),
          )
        ],
      )
    );
  }

  /// Upon any error returned by the sign-in methods, shows a SnackBar accordignly
  void _handleAuthError(BuildContext context, FirebaseAuthException error){
    var errorCodeToText = {
      "invalid-email": "Emailul introdus nu este valid", 
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
}