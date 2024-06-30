import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HowFarIsThePlanet extends StatefulWidget {
  @override
  _HowFarIsThePlanetState createState() => _HowFarIsThePlanetState();
}

class _HowFarIsThePlanetState extends State<HowFarIsThePlanet> {
  void initState() {
    loadData();
    super.initState();
    Timer(Duration(seconds: 1), () {
      calculate();
    });
  }

  void loadData() async {
    data = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/data/planetData.json"));
  }

  dynamic data = {};
  TextEditingController controller = TextEditingController();
  String planet = "earth";
  String result = "";
  String modeResult = "";
  String mode = "Rocket";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FEEL THE DISTANCE".toUpperCase(),
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
          child: ListView(
            children: [
              Text(
                "Planets are far away from the Sun. Just feel the distance......",
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Select The Planet",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 330,
                  height: 90,
                  child: create((t) {
                    planet = t;
                    calculate();
                  })),
              SizedBox(
                height: 20,
              ),
              Text(
                result,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                height: 10,
                color: Colors.white.withOpacity(0.3),
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "How Long To Cover This Distance If You Travel At The Speed Of",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        "assets/images/icons/cycle.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        mode = "Cycle";
                        calculate();
                      },
                    ),
                    SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.4),
                        width: 5,
                        thickness: 1,
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        "assets/images/icons/car.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        mode = "F1 Car";
                        calculate();
                      },
                    ),
                    SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.4),
                        width: 5,
                        thickness: 1,
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        "assets/images/icons/plane.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        mode = "Fighter Plane";
                        calculate();
                      },
                    ),
                    SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.4),
                        width: 5,
                        thickness: 1,
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        "assets/images/icons/rocketFeeltheDistance.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        mode = "Rocket";
                        calculate();
                      },
                    ),
                    SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Colors.grey.withOpacity(0.4),
                        width: 5,
                        thickness: 1,
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        "assets/images/icons/light.png",
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      onTap: () {
                        mode = "Light";
                        calculate();
                      },
                    )
                  ],
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              Text(
                mode,
                style: TextStyle(
                    fontSize: 18,
                    color: mode == "Cycle"
                        ? Colors.blue[600]
                        : mode == "F1 Car"
                            ? Colors.yellow[700]
                            : mode == "Fighter Plane"
                                ? Colors.green[500]
                                : mode == "Rocket"
                                    ? Colors.orange[600]
                                    : Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                modeResult,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              Text(
                "*Approximate Values",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 10,
                color: Colors.white.withOpacity(0.3),
                thickness: 1,
              ),
              SizedBox(
                height: 10,
              ),
              ExpansionTile(
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                leading: Icon(
                  Icons.help_outline_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  "What is the next closest star to Earth?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                children: [
                  Text(
                    "The closest star after Sun is Proxima Centauri, which is at a distance of about 3,99,00,00,00,00,000 kilometers!!. On the scale of the universe, measuring distances in kilometers is not a good idea. Instead scientists use a unit called lightyear. Lightyear is the distance light travels in one Earth year. One lightyear is 9.46 trillion kilometers, because light zips through interstellar space at 3,00,000 kilometers per second. Proxima Centauri is 4.25 light years away from us. Much easier to mention right? There is another distance measurement used to describe distance between Sun and planets. Explore and find out.",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void calculate() async {
    var formatter = NumberFormat.decimalPattern("hi");
    result = "${planet.toUpperCase()} is " +
        formatter
            .format(data["Distance From Sun"][planet] * 1000000)
            .toString() +
        " km away from SUN.";
    Map modeData = {
      "Cycle": 20,
      "F1 Car": 400,
      "Fighter Plane": 3500,
      "Rocket": 50000,
      "Light": 1080000000,
    };
    if (mode == "Light") {
      if ((((data["Distance From Sun"][planet] * 1000000) / modeData[mode])) <
          1) {
        modeResult =
            "Speed: ${formatter.format(modeData[mode])} km/hr \nTime Taken: ${(((data["Distance From Sun"][planet] * 1000000) / modeData[mode]) * 60).round()} min";
      } else {
        modeResult =
            "Speed: ${formatter.format(modeData[mode])} km/hr \nTime Taken: ${(((data["Distance From Sun"][planet] * 1000000) / modeData[mode])).round()} hr";
      }
    } else {
      if ((((data["Distance From Sun"][planet] * 1000000) / modeData[mode]) /
              8760) <
          1) {
        modeResult =
            "Speed: ${formatter.format(modeData[mode])} km/hr \nTime Taken: ${(((data["Distance From Sun"][planet] * 1000000) / modeData[mode])).round()} hr";
      } else {
        modeResult =
            "Speed: ${formatter.format(modeData[mode])} km/hr \nTime Taken: ${(((data["Distance From Sun"][planet] * 1000000) / modeData[mode]) / 8760).round()} year";
      }
    }
    setState(() {});
  }

  Widget create(Function(String t) onPressed) {
    List<String> planets = [
      "mercury",
      "venus",
      "earth",
      "mars",
      "jupiter",
      "saturn",
      "uranus",
      "neptune"
    ];
    List<Widget> items = [];
    planets.forEach((element) {
      items.add(TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Colors.grey[500],
              textStyle: TextStyle(fontFamily: "Jost", fontSize: 18)),
          onPressed: () => onPressed(element),
          icon: Image.asset(
            "assets/images/$element.png",
            height: 80,
            fit: BoxFit.contain,
          ),
          label: Text(element.toUpperCase())));
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
}
