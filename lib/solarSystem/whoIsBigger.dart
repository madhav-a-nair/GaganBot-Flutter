import 'dart:async';
import 'dart:convert';

import 'package:atl_space_challenge_project/widgets/planetPicker.dart';
import 'package:flutter/material.dart';

class WhoIsBigger extends StatefulWidget {
  @override
  _WhoIsBiggerState createState() => _WhoIsBiggerState();
}

class _WhoIsBiggerState extends State<WhoIsBigger> {
  void initState() {
    super.initState();
    loadData();
    Timer(Duration(seconds: 1), () {
      compare();
    });
  }

  void loadData() async {
    data = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/data/planetData.json"));
  }

  var data = {};
  String fromPlanet = "earth";
  String toPlanet = "venus";
  double fromPlanetSize = 0;
  double toPlanetSize = 0;
  String textResult = "";
  String comparisonText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Who Is Bigger".toUpperCase(),
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
              "I Want To Compare",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 330,
                height: 90,
                child: PlanetPicker().create(true, true, (t) {
                  fromPlanet = t;
                  compare();
                })),
            SizedBox(
              height: 20,
            ),
            Text(
              "With",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: 330,
                height: 90,
                child: PlanetPicker().create(true, true, (t) {
                  toPlanet = t;
                  compare();
                })),
            SizedBox(
              height: 35,
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
                      duration: Duration(seconds: 1),
                      child: Image.asset(
                        "assets/images/$fromPlanet.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      fromPlanet.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                      height: toPlanetSize,
                      duration: Duration(seconds: 1),
                      child: Image.asset(
                        "assets/images/$toPlanet.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      toPlanet.toUpperCase(),
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
              textResult,
              style: TextStyle(color: Colors.redAccent[400], fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              comparisonText,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 10,
              color: Colors.white.withOpacity(0.3),
              thickness: 1,
            ),
            ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              leading: Icon(
                Icons.help_outline_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Do You Know?",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              children: [
                Text(
                  "In 200 B.C., the size of the Earth was actually calculated to within 1% accuracy by Eratosthenes !!. Explore and find out how he did it. Also, find how plant size is measured from Earth (It has something to do with Trignometry).",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  void compare() {
    int p1 = data["Diameter"][fromPlanet];
    int p2 = data["Diameter"][toPlanet];
    if (p1 > p2) {
      fromPlanetSize = MediaQuery.of(context).size.width * 0.7;
      toPlanetSize = MediaQuery.of(context).size.width * 0.7 / (p1 / p2);
      textResult =
          "${fromPlanet.toUpperCase()}'s diameter is ${double.parse((p1 / p2).toStringAsFixed(1))} times bigger than ${toPlanet.toUpperCase()}";
    } else if (p1 < p2) {
      toPlanetSize = MediaQuery.of(context).size.width * 0.7;
      fromPlanetSize = MediaQuery.of(context).size.width * 0.7 / (p2 / p1);
      textResult =
          "${toPlanet.toUpperCase()}'s diameter is ${double.parse((p2 / p1).toStringAsFixed(1))} times bigger than ${fromPlanet.toUpperCase()}";
    } else if (p1 == p2) {
      fromPlanetSize = MediaQuery.of(context).size.width * 0.7;
      toPlanetSize = MediaQuery.of(context).size.width * 0.7;
      textResult = "Looks like we are the same!!";
    }
    comparisonText =
        "Diameter Of ${fromPlanet.toUpperCase()}: ${data["Diameter"][fromPlanet]} km \nDiameter Of ${toPlanet.toUpperCase()}: ${data["Diameter"][toPlanet]} km";
    setState(() {});
  }
}
