import 'package:feastique/screens/authentication_page/components/log_in_form.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// The circle in the upper right corner
          Positioned(
            top: -120,
            right: -120,
            child: new Container(
              width: 240.0,
              height: 240.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*0.2, 
              left: MediaQuery.of(context).size.width*0.05,
              right: MediaQuery.of(context).size.width*0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// TODO: Bagat animatie care ridica textul si da reveal la Login Form
                Text("Bun venit!", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                SizedBox(height: 20),
                LogInForm()
              ],
            ),
          ),
          /// The circle in the down left corner
          Positioned(
            bottom: -150,
            left: 0,
            child: new Container(
              width: 400.0,
              height: 270.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).accentColor,
                shape: BoxShape.circle,
              ),
            )
          ),
          /// The circle in the down left corner
          Positioned(
            bottom: -200,
            left: -200,
            child: new Container(
              width: 400.0,
              height: 400.0,
              decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            )
          ),
        ],
      ),
    );
  }
}