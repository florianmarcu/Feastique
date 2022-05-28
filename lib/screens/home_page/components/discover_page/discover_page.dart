import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: TextButton(
          onPressed: (){},
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width*0.8,
            child: Center(child: Text("Găsește localul perfect"))
          ),
        )
      ),
    );
  }
}