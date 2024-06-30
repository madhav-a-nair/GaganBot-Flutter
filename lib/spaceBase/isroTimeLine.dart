import 'dart:math';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class IndianSpaceSaga extends StatefulWidget {
  @override
  _IndianSpaceSagaState createState() => _IndianSpaceSagaState();
}

final fb = FirebaseDatabase.instance;
String? selectedYear;
bool loading = false;

class _IndianSpaceSagaState extends State<IndianSpaceSaga> {
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    timeline = [];
    var ref = fb.reference();
    if (await InternetConnectionChecker().hasConnection) {
      await ref.child("ISRO Timeline").once().then((value) {
        print(value.value);
        Map data = value.value;
        TimelineItemPosition position = TimelineItemPosition.left;
        data.forEach((key, value) {
          timeline.add(TimelineModel(
              Card(
                margin:
                    EdgeInsets.only(top: 20, left: 10, bottom: 20, right: 10),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        key.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        value[0]["Content"] + "\n",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        value.length > 1
                            ? "Click To View More"
                            : "Click To View",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ), onTap: () {
            selectedYear = key;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IndianSpaceSagaSubCategory()));
          },
              iconBackground: Colors.transparent,
              icon: value.length > 1
                  ? Icon(
                      Icons.auto_awesome,
                      color: randomColor(),
                    )
                  : Icon(
                      Icons.star,
                      color: randomColor(),
                    ),
              position: position));
          if (position == TimelineItemPosition.left) {
            position = TimelineItemPosition.right;
          } else {
            position = TimelineItemPosition.left;
          }
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No Internet Connection!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
    if (mounted) {
      setState(() {});
    }
  }

  List<TimelineModel> timeline = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Indian Space Saga".toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Timeline(
          lineColor: Colors.grey.shade400,
          iconSize: 30,
          children: timeline,
          lineWidth: 5,
        ),
      ),
    );
  }
}

class IndianSpaceSagaSubCategory extends StatefulWidget {
  @override
  _IndianSpaceSagaSubCategoryState createState() =>
      _IndianSpaceSagaSubCategoryState();
}

class _IndianSpaceSagaSubCategoryState
    extends State<IndianSpaceSagaSubCategory> {
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    timeline = [];
    var ref = fb.reference();
    if (await InternetConnectionChecker().hasConnection) {
      setState(() {
        loading = true;
      });
      await ref
          .child("ISRO Timeline")
          .child(selectedYear.toString())
          .once()
          .then((value) {
        print(value.value);
        List data = value.value;
        TimelineItemPosition position = TimelineItemPosition.left;
        data.forEach((value) {
          timeline.add(TimelineModel(
              Card(
                margin:
                    EdgeInsets.only(top: 20, left: 10, bottom: 20, right: 10),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/icons/timelineIcons/${value["Type"].toLowerCase()}.png",
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        value["Content"].toString().endsWith(".")
                            ? value["Content"].trim()
                            : value["Content"].trim() + ".",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              iconBackground: Colors.transparent,
              icon: Icon(
                Icons.event,
                color: randomColor(),
              ),
              position: position));
          if (position == TimelineItemPosition.left) {
            position = TimelineItemPosition.right;
          } else {
            position = TimelineItemPosition.left;
          }
        });
      });
      setState(() {
        loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No Internet Connection!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  List<TimelineModel> timeline = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Timeline - $selectedYear".toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: loading
            ? Text(
                "Loading....",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )
            : Timeline(
                lineColor: Colors.grey.shade400,
                iconSize: 30,
                children: timeline,
                lineWidth: 5,
              ),
      ),
    );
  }
}

Color randomColor() {
  List<Color> colors = Colors.primaries;
  final random = Random();
  return colors[random.nextInt(6)];
}
