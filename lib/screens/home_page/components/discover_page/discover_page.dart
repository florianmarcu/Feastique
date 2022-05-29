import 'components/theme.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildTheme(context),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 140),
              Text(
                "Ai rămas fără idei?",
                style: Theme.of(context).textTheme.headline4,
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
    );
  }

  ThemeData _buildTheme(BuildContext context) => Theme.of(context).copyWith(textButtonTheme: textButtonTheme(context));
}