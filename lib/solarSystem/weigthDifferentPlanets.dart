import 'dart:convert';
import 'dart:ui';

import 'package:atl_space_challenge_project/widgets/planetPicker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeigthDifferentPlanets extends StatefulWidget {
  @override
  _WeigthDifferentPlanetsState createState() => _WeigthDifferentPlanetsState();
}

class _WeigthDifferentPlanetsState extends State<WeigthDifferentPlanets> {
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    data = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/data/planetData.json"));
  }

  dynamic data = {};
  TextEditingController controller = TextEditingController();
  double result = 1.0;
  String planet = "earth";
  int pickervalue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weight Checker".toUpperCase(),
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
                "Your Weight On Earth (kg)?",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 110,
                    width: 330,
                    child: NumberPicker(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      axis: Axis.horizontal,
                      minValue: 1,
                      maxValue: 200,
                      itemCount: 3,
                      itemHeight: 100,
                      infiniteLoop: true,
                      itemWidth: 110,
                      textStyle: TextStyle(fontSize: 40, color: Colors.grey),
                      selectedTextStyle:
                          TextStyle(fontSize: 40, color: Colors.white),
                      value: pickervalue,
                      onChanged: (value) {
                        pickervalue = value;
                        setState(() {});
                        calculate();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Select The Celestial Body",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 330,
                  height: 90,
                  child: PlanetPicker().create(true, true, (t) {
                    planet = t;
                    calculate();
                  })),
              SizedBox(
                height: 20,
              ),
              Text(
                "Your Weigth On ${planet.toUpperCase()}:",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SfRadialGauge(
                enableLoadingAnimation: true,
                axes: <RadialAxis>[
                  RadialAxis(
                      maximum: planet == "sun" ? 6000 : 600,
                      minimum: 0,
                      axisLabelStyle: GaugeTextStyle(
                        fontSize: 9,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: result,
                          needleColor: Colors.red,
                          knobStyle: KnobStyle(color: Colors.red),
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            angle: 90,
                            positionFactor: 0.5,
                            widget: Text(
                              '$result kg \n ${planet.toUpperCase()}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white),
                            ))
                      ])
                ],
              ),
              Text(
                data["Gravity"] != null
                    ? "Acceleration Due To Gravity in ${planet.toUpperCase()}: \n${double.parse(data["Gravity"][planet].toStringAsFixed(2))} m/s/s"
                    : "Acceleration Due To Gravity On EARTH: \n 9.8 m/s/s",
                style: TextStyle(color: Colors.redAccent[400], fontSize: 18),
                textAlign: TextAlign.center,
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
                  "Difference between Weight & Mass?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                children: [
                  Text(
                    "Mass is the amount of matter an object contains, and weight, the measurement of the pull of gravity on the object. For example, your mass will be same on all planets, but your weight will be different as the acceleration due to gravity is different on each celestical body.",
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
    result = (data["Gravity"][planet] / data["Gravity"]["earth"]) *
        double.parse(pickervalue.toString());
    result = double.parse(result.toStringAsFixed(1));
    setState(() {});
  }
}
