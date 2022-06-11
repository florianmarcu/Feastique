import 'package:feastique/config/constants.dart';
import 'package:feastique/models/models.dart';
import 'package:feastique/screens/place_page/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingBottomSheet extends StatefulWidget {

  final BuildContext context;

  BookingBottomSheet(this.context);

  @override
  State<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends State<BookingBottomSheet> {
  
  DateTime? _selectedDate;
  int _selectedNoOfPeople = 1;
  int _selectedDay = 0;
  int _selectedHour = DateTime.now().toLocal().hour;
  ScrollController? _peopleNoScrollController;
  ScrollController? _dayScrollController;
  ScrollController? _hourScrollController;
  PageController _pageController = PageController(keepPage: false);

  final currentTime = DateTime.now().toLocal();
  Map<String,dynamic>? schedule;
  String? startHour; // The starting hour of the schedule
  String? endHour; // The ending hour of the schedule
  int? hourDiff; // The difference(in hours) between the ending and starting hour respectively
  int? minDiff; // It's value is either 1 or 0, for :30 and :00 respectively 
  DateTime? hour; // The first hour of the current weekday in the place's schedule (used for indexing the avaiable hours)

  @override
  void initState() {
    super.initState();
    _peopleNoScrollController = ScrollController(initialScrollOffset: MediaQuery.of(widget.context).size.width*0.16);
    _dayScrollController = ScrollController();
    _hourScrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  Widget build(BuildContext context) {
    var place = context.watch<PlaceProvider>().place;
    initiateHours(place);
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container( /// First page of the PageView
          padding: EdgeInsets.only(top: 20),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "În ce zi?",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 15,),
              Container( /// Days list
                height: 50,
                width: double.infinity,
                child: ListView.separated(
                  controller: _dayScrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  separatorBuilder: (context,index)=>SizedBox(width: 10,),
                  itemBuilder: (context,index) => ChoiceChip(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                    backgroundColor:Colors.grey[200],
                    selectedColor: Theme.of(context).primaryColor,
                    labelPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                    selected: index == _selectedDay,
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kWeekdays[DateFormat('EEEE').format(currentTime.add(Duration(days: index))).substring(0,3)]!,
                        ),
                        Text(
                          currentTime.add(Duration(days: index)).day.toString() 
                          + ' ' +
                          DateFormat('MMMM').format(currentTime.add(Duration(days: index))).substring(0,3),
                        )
                      ],
                    ),
                    onSelected: (selected){
                      setState(() {
                        _selectedDay = index;
                      });
      
                      _dayScrollController!.animateTo(
                        (_selectedDay-1)*93.toDouble(),
                        duration: Duration(milliseconds: 500), 
                        curve: Curves.ease
                      );
                    },
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "La ce oră?",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 15,),
              Container( /// Hours list
                height: 60,
                width: double.infinity,
                child: ListView.separated(
                  controller: _hourScrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10,),
                  scrollDirection: Axis.horizontal,
                  itemCount: place.schedule != null
                    ? (endHour != "00:00" ? hourDiff! * 2 + minDiff! - 2 : hourDiff! * 2 + 24 + minDiff! - 2)
                    : 0,
                  separatorBuilder: (context,index)=>SizedBox(width: 10,),
                  itemBuilder: (context,index) {
                    GlobalKey _tooltipKey = GlobalKey();
                    int discount = 0;
                    //int discount = getDiscountForHour(index);
                    List<Map<String,dynamic>> deals = _getDealsForHour(place, index);
                    return  Opacity(
                      opacity: hour!.add(Duration(minutes: index*30)).compareTo(DateTime.now()) < 0 && _selectedDay == 0
                                  ? 0.4 : 1,
                      child: Stack(
                        // overflow: Overflow.visible,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: ChoiceChip(
                              labelPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                              backgroundColor: Theme.of(context).canvasColor,
                              selectedColor: Theme.of(context).primaryColor,
                              selected: index == _selectedHour,
                              label: Text(
                                hour!.add(Duration(minutes: index*30)).hour.toString()
                                + ":" +
                                  (hour!.add(Duration(minutes: index*30)).minute.toString() == '0' 
                                  ? '00' 
                                  : hour!.add(Duration(minutes: index*30)).minute.toString()),
                                style: Theme.of(context).textTheme.overline
                              ),
                              onSelected: (selected){
                                if(hour!.add(Duration(minutes: index*30)).compareTo(DateTime.now()) < 0 && _selectedDay == 0)
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      'Această oră este indisponibilă pentru rezervare',
                                      textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Theme.of(context).primaryColor
                                  )).closed.then((value) => ScaffoldMessenger.of(context).clearSnackBars());
                                else {
                                  _selectedHour = index;
                                  String selectedHour =  
                                    (hour!.add(Duration(minutes: index*30)).hour < 10 ?
                                    '0' + hour!.add(Duration(minutes: index*30)).hour.toString()
                                    :
                                    hour!.add(Duration(minutes: index*30)).hour.toString())
                                      + ":" +
                                        (hour!.add(Duration(minutes: index*30)).minute.toString() == '0' 
                                        ? '00'
                                        : hour!.add(Duration(minutes: index*30)).minute.toString());
                                  String selectedDay = 
                                  DateFormat('y-MM-dd').format(DateTime.now().add(Duration(days: _selectedDay)));
                                  setState(() {
                                    _selectedDate = DateTime.parse(selectedDay +' '+ selectedHour + ':00').toUtc();
                                    //_selectedDiscount = discount;
                                    //_selectedDeals = deals;
                                    print(_selectedDate);
                                  });
                                  _hourScrollController!.animateTo(
                                    (_selectedHour-1.6)*93.toDouble(),
                                    duration: Duration(milliseconds: 500), 
                                    curve: Curves.ease
                                  );
                                }
                              },
                            ),
                          ),
                          // The 'Deal' Chip
                          deals.length != 0
                          ? Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: (){
                                final dynamic tooltip = _tooltipKey.currentState;
                                tooltip.ensureTooltipVisible();
                              },
                              child: Tooltip(
                                preferBelow: false,
                                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
                                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                                key: _tooltipKey,
                                //message: formatDealTooltip(deals),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width*0.11,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Icon(
                                    Icons.local_offer,
                                    color: Colors.white,
                                    size: 19,
                                  )
                                ),
                              ),
                            ),
                          )
                          : Container(),
                          // The 'Discount' Chip
                          discount != 0
                          ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width*0.11,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Text(
                                "-$discount%",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          )
                          : Container()
                        ],
                      ),
                    );
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Câte persoane?",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Container( /// How many people List
                height: 50,
                width: double.infinity,
                child: ListView.separated(
                  controller: _peopleNoScrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  separatorBuilder: (context,index) => SizedBox(width: 10,),
                  itemBuilder: (context,index) => ChoiceChip(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                    backgroundColor: Theme.of(context).canvasColor,
                    labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    label: Text((index+1).toString()),
                    selected: index == _selectedNoOfPeople,
                    selectedColor: Theme.of(context).primaryColor,
                    onSelected: (selected){
                      ///TODO implement logic
                      setState(() {
                        _selectedNoOfPeople = index;
                      });
                      _peopleNoScrollController!.animateTo(
                        (_selectedNoOfPeople-2)*68.toDouble() - 6,
                        duration: Duration(milliseconds: 500), 
                        curve: Curves.easeIn
                      );
                    },
                  )
                ),
              ),
              Expanded(
                child: Container()
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton.extended(
                  shape: ContinuousRectangleBorder(),
                  elevation: 0,
                  onPressed: (){
                    _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                  },
                  label: Text("Alege", style: Theme.of(context).textTheme.headline4,)
                ),
              ),


            ]
          ),
        ),
      ],
    );
  }

  List<Map<String,dynamic>> _getDealsForHour(Place place, int index){
    String selectedHour =  
    hour!.add(Duration(minutes: index*30)).hour.toString()
        + ":" +
          (hour!.add(Duration(minutes: index*30)).minute.toString() == '0' 
          ? '00'
          : hour!.add(Duration(minutes: index*30)).minute.toString());
    List? hourAndDeals = place.deals![DateFormat("EEEE").format(DateTime.now().toLocal().add(Duration(days: _selectedDay))).toLowerCase()];
    List<Map<String,dynamic>> deals = <Map<String,dynamic>>[];
    if(hourAndDeals != null)
      for(int i = 0; i< hourAndDeals.length; i++)
        if(selectedHour.compareTo(hourAndDeals[i]['interval'].substring(0,5))>= 0 &&
          selectedHour.compareTo(hourAndDeals[i]['interval'].substring(6,11))< 0)
          deals.add(hourAndDeals[i]);
    return deals;
  }

  /// Initiate the time schedule for this widget
  initiateHours(Place place){
    var schedule = place.schedule;
    if(schedule != null){
      print(schedule);
      startHour = schedule[DateFormat('EEEE').format(currentTime.add(Duration(days: _selectedDay))).toLowerCase()].substring(0,5);
      endHour = schedule[DateFormat('EEEE').format(currentTime.add(Duration(days: _selectedDay))).toLowerCase()].toString().substring(6,11);
      hourDiff = 
        endHour != '00:00' 
        ? int.parse(endHour!.substring(0,2)) - int.parse(startHour!.substring(0,2))
        : int.parse(endHour!.substring(0,2)) + 12 - int.parse(startHour!.substring(0,2))
      ;
      minDiff = endHour!.substring(3,5) == '30' ? 1 : 0 ; /// In case the place has a delayed schedule
      hour = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, int.parse(startHour!.substring(0,2)), int.parse(startHour!.substring(3,5)));
    }
  }
}