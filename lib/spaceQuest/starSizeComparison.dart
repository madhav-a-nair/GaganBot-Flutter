import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class UniverseSizeComparison extends StatefulWidget {
  @override
  _UniverseSizeComparisonState createState() => _UniverseSizeComparisonState();
}

class _UniverseSizeComparisonState extends State<UniverseSizeComparison> {
  void initState() {
    super.initState();
    loadData();
    Timer(Duration(seconds: 1), () {
      compare();
    });
  }

  void loadData() async {
    data = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/data/starComparison.json"));
  }

  Map? data;
  String fromStar = "Sun||Yellow";
  String toStar = "Sirius A||White";
  double fromPlanetSize = 0;
  double toPlanetSize = 0;
  String comparisonText = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Star Size Comparison".toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/background.jpg"))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(children: [
            Text(
              "Sun Compared With",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            data != null
                ? Container(
                    width: 330,
                    height: 90,
                    child: create((t) {
                      toStar = t;
                      compare();
                    }))
                : SizedBox(),
            SizedBox(
              height: 20,
            ),
            Text(
              "See How It Looks Like",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            InteractiveViewer(
              maxScale: 10,
              child: Container(
                color: Color.fromARGB(255, 6, 18, 33),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedContainer(
                      height: fromPlanetSize,
                      width: fromPlanetSize,
                      duration: Duration(seconds: 1),
                      decoration: BoxDecoration(
                          color: fromStar.split("||")[1] == "Yellow"
                              ? Colors.yellow
                              : fromStar.split("||")[1] == "Red"
                                  ? Colors.red
                                  : fromStar.split("||")[1] == "White"
                                      ? Colors.white
                                      : fromStar.split("||")[1] == "Orange"
                                          ? Colors.orange
                                          : fromStar.split("||")[1] == "Blue"
                                              ? Colors.blue
                                              : Colors.white,
                          borderRadius: BorderRadius.circular(1000)),
                    ),
                    Text(
                      fromStar.split("||")[0].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                      height: toPlanetSize,
                      width: toPlanetSize,
                      duration: Duration(seconds: 1),
                      decoration: BoxDecoration(
                          color: toStar.split("||")[1] == "Yellow"
                              ? Colors.yellow
                              : toStar.split("||")[1] == "Red"
                                  ? Colors.red
                                  : toStar.split("||")[1] == "White"
                                      ? Colors.white
                                      : toStar.split("||")[1] == "Orange"
                                          ? Colors.orange
                                          : toStar.split("||")[1] == "Blue"
                                              ? Colors.blue
                                              : Colors.white,
                          borderRadius: BorderRadius.circular(1000)),
                    ),
                    Text(
                      toStar.split("||")[0].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              comparisonText,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data != null
                  ? "${toStar.split("||")[0]} Type: " +
                      data![toStar.split("||")[0]]["Type"]
                  : "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.orange),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data != null
                  ? "${toStar.split("||")[0]} Distance From Earth:\n" +
                      data![toStar.split("||")[0]]["Distance From Earth"]
                  : "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            Text(
              "*Approximate Values",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }

  Widget create(Function(String t) onPressed) {
    List<String> planets = [];
    data!.forEach((key, value) {
      planets.add("$key||${value["Type"].toString().split(" ")[0]}");
    });
    List<Widget> items = [];
    planets.forEach((element) {
      items.add(TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Colors.grey[500],
              textStyle: TextStyle(fontSize: 18, fontFamily: "Jost")),
          onPressed: () => onPressed(element),
          icon: Container(
            height: 80,
            width: 75,
            decoration: BoxDecoration(
                color: element.split("||")[1] == "Yellow"
                    ? Colors.yellow
                    : element.split("||")[1] == "Red"
                        ? Colors.red
                        : element.split("||")[1] == "White"
                            ? Colors.white
                            : element.split("||")[1] == "Orange"
                                ? Colors.orange
                                : element.split("||")[1] == "Blue"
                                    ? Colors.blue
                                    : Colors.white,
                borderRadius: BorderRadius.circular(100)),
          ),
          label: Text(element.split("||")[0].toUpperCase())));
      items.add(SizedBox(
        height: 90,
        child: VerticalDivider(
          thickness: 1,
          width: 5,
        ),
      ));
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: items,
    );
  }

  void compare() {
    double p1 =
        double.parse(data![fromStar.split("||")[0]]["Times Bigger"].toString());
    double p2 =
        double.parse(data![toStar.split("||")[0]]["Times Bigger"].toString());
    if (p1 < p2) {
      toPlanetSize = MediaQuery.of(context).size.width * 0.7;
      fromPlanetSize = MediaQuery.of(context).size.width * 0.7 / p2;
      comparisonText = "${toStar.split("||")[0]} is $p2 times bigger than Sun";
    } else if (p1 == p2) {
      fromPlanetSize = MediaQuery.of(context).size.width * 0.7;
      toPlanetSize = MediaQuery.of(context).size.width * 0.7;
      comparisonText = "Looks like we are the same!!";
    }
    setState(() {});
  }
}
