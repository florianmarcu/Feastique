import 'package:feastique/screens/authentication_page/authentication_provider.dart';
import 'package:flutter/material.dart';

class LogInForm extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<AuthenticationPageProvider>();
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Email field
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
            ),
            onChanged: (email) => provider.setEmail(email),
          ),
          SizedBox(height: 20),
          /// Password field
          TextFormField(
            obscureText: !provider.passwordVisible,
            decoration: InputDecoration(
              labelText: "Parolă", 
              suffixIcon: IconButton(
                highlightColor: Colors.grey[200],
                splashColor: Colors.grey[400],
                icon: Icon(Icons.visibility, color: Theme.of(context).highlightColor,), 
                onPressed: () => provider.setPasswordVisibility(), 
                padding: EdgeInsets.zero, 
              ),
            ),
            onChanged: (password) => provider.setPassword(password),
          ),
          SizedBox(height: 30,),
          TextButton(
            onPressed: () => provider.logIn(context),
            child: Text("Log in"),
          )
        ],
      )
    );
  }
}