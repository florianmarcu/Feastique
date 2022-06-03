import 'package:flutter/gestures.dart';

import 'components/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: Container(
        height: MediaQuery.of(context).size.height,

        child: Center(
          child: ScrollConfiguration(
            behavior: ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
            child: ListView(
              padding: EdgeInsets.only(bottom: 50, left: 20, right: 20),
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 140),
                // Text(
                //   "Bună!",
                //   style: Theme.of(context).textTheme.headline3,
                // ),
                // Text(
                //   "Rezervă o masă prin aplicație și bucură-te de ofertele exclusive!",
                //   style: Theme.of(context).textTheme.headline6,
                // ),
                Text(
                  "Ai rămas fără idei?",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 12,),
                TextButton( /// 'Find the perfect place' button
                  onPressed: (){},
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Center(child: Text("Găsește localul perfect"))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ThemeData _buildTheme(BuildContext context) => Theme.of(context).copyWith(textButtonTheme: textButtonTheme(context));
}