import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HowFastYouSpin extends StatefulWidget {
  @override
  _HowFastYouSpinState createState() => _HowFastYouSpinState();
}

class _HowFastYouSpinState extends State<HowFastYouSpin> {
  LatLng? clickedPosition;
  double? result;
  NumberFormat format = NumberFormat.decimalPattern("hi");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HOW FAST YOU SPIN".toUpperCase(),
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
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(24.041222, 77.993960)),
                      markers: clickedPosition != null
                          ? {
                              Marker(
                                  markerId: MarkerId("position"),
                                  position: clickedPosition!)
                            }
                          : {},
                      onTap: (position) {
                        setState(() {
                          clickedPosition = position;
                          calculate();
                        });
                      },
                    ),
                    clickedPosition == null
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Click On A Point To\nSee The Speed",
                                style: TextStyle(fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      result != null
                          ? "Selected Lat/Lon: ${format.format(clickedPosition!.latitude)}, ${format.format(clickedPosition!.longitude)}"
                          : "",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      result != null
                          ? "Your Speed (km/hr): ${format.format(result!.round())} km/hr"
                          : "",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      result != null
                          ? "Your Speed (m/s): ${format.format((result! / 3.6).round())} m/s"
                          : "",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      result != null
                          ? "In this speed, you are spinning with Earth"
                          : "",
                      style: TextStyle(fontSize: 15, color: Colors.lime),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void calculate() {
    num newLat = clickedPosition!.latitude * (pi / 180);
    result = (((2 * pi) * 6378137 * cos(newLat)) / 23.9344699) / 1000;
    setState(() {});
  }
}
