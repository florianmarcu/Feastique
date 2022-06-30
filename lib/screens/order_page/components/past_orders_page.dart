import 'package:feastique/config/config.dart';
import 'package:feastique/config/format.dart';
import 'package:feastique/screens/order_page/order_provider.dart';
import 'package:flutter/material.dart';

import 'order_item_page.dart';

class PastOrdersList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<OrderPageProvider>();
    var pastOrders = provider.pastOrders;
    return WillPopScope(
      onWillPop: () {
        provider.pageController.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        return Future.value(false);
      },
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20), 
            itemCount: pastOrders == null ? 1 : pastOrders.length,
            itemBuilder: (context, index) {
              if(pastOrders == null)
                return Container(
                  padding: EdgeInsets.only(top: 95),
                  height: 100,
                  child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), backgroundColor: Colors.transparent,)
                );
              else {
                var order = pastOrders[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                         onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          ChangeNotifierProvider.value(
                            value: provider,
                            child: OrderItemPage(order),
                          )
                        )).whenComplete(() => provider.getData()),
                        child: Container(
                          color: Theme.of(context).highlightColor,
                          //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          height: 100,
                          child: Row(
                            children: [
                              SizedBox(width: 20,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Comandă la ${formatDateToHourAndMinutes(order.dateCreated)}", style: Theme.of(context).textTheme.labelMedium),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text.rich( /// The 'Accepted' or 'Refused' symbol
                                            TextSpan(
                                              children: order.accepted != null
                                              ? ( order.accepted!
                                              ? [
                                                WidgetSpan(child: Image.asset(localAsset('accepted'), width: 18, color: Colors.green)),
                                                WidgetSpan(child: SizedBox(width: 10)),
                                                TextSpan(
                                                  text: "Acceptată",
                                                  style: TextStyle(
                                                    color: Colors.green
                                                  )
                                                ),
                                              ]
                                              : [
                                                WidgetSpan(child: Image.asset(localAsset('refused'), width: 18, color: Colors.red)),
                                                WidgetSpan(child: SizedBox(width: 10)),
                                                TextSpan(
                                                  text: "Refuzată",
                                                  style: TextStyle(
                                                    color: Colors.red
                                                  )
                                                ),
                                              ])
                                              : [
                                                WidgetSpan(child: Image.asset(localAsset('waiting'), width: 18)),
                                                WidgetSpan(child: SizedBox(width: 10)),
                                                TextSpan(
                                                  text: "În așteptare",
                                                ),
                                              ]
                                            )
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),
                    ],
                  ),
                );
              }
            }, 
          ),
        )
      ),
    );
  }
}