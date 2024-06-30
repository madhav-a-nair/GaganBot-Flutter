import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WhereIsISS extends StatefulWidget {
  @override
  _WhereIsISSState createState() => _WhereIsISSState();
}

class _WhereIsISSState extends State<WhereIsISS> {
  void initState() {
    loadData();
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      try {
        if (await InternetConnectionChecker().hasConnection) {
          ScaffoldMessenger.of(context).clearSnackBars();
          http
              .get(Uri.parse("http://api.open-notify.org/astros.json"))
              .then((value) {
            totalPeople = jsonDecode(value.body);
          });
          http
              .get(Uri.parse("https://api.wheretheiss.at/v1/satellites/25544"))
              .then((response) {
            position = jsonDecode(response.body);
            if (mounted) {
              setState(() {});
            }
            if (mounted) {
              controller.future.then((value) async {
                if (position != null) {
                  value.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          zoom: await value.getZoomLevel(),
                          target: LatLng(
                              position!["latitude"], position!["longitude"]))));
                }
              });
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No Internet Connection!"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 10),
          ));
        }
      } on SocketException catch (e) {
        print(e);
      }
    });
    super.initState();
  }

  Timer? timer;

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void loadData() async {
    iss = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
            size: Size(
              1,
              1,
            ),
            devicePixelRatio: 1),
        "assets/images/icons/iss.png");
  }

  Map? position;
  Map? totalPeople;
  BitmapDescriptor? iss;
  Completer<GoogleMapController> controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Track The Station".toUpperCase(),
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
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      onMapCreated: (con) {
                        controller.complete(con);
                      },
                      markers: iss != null && position != null
                          ? {
                              Marker(
                                  icon: iss!,
                                  markerId: MarkerId("iss"),
                                  position: LatLng(position!["latitude"],
                                      position!["longitude"]))
                            }
                          : {},
                      initialCameraPosition: CameraPosition(
                          target: position != null
                              ? LatLng(
                                  position!["latitude"], position!["longitude"])
                              : LatLng(20.55755518244729, 78.95739993730994)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    position != null
                        ? "Position Of International Space Station\nLatitude: ${double.parse(position!["latitude"].toStringAsFixed(2))} | Longitude: ${double.parse(position!["longitude"].toStringAsFixed(2))}"
                        : "No Data Available",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 0),
                    minLeadingWidth: 20,
                    leading: Icon(
                      Icons.speed,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      position != null
                          ? "Velocity: ${double.parse(position!["velocity"].toStringAsFixed(2))} km/hr"
                          : "No Data Available",
                      style: TextStyle(fontSize: 20, color: Colors.lime),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 0),
                    minLeadingWidth: 20,
                    leading: Icon(
                      Icons.height,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      position != null
                          ? "Altitude: ${double.parse(position!["altitude"].toStringAsFixed(2))} km"
                          : "No Data Available",
                      style: TextStyle(fontSize: 20, color: Colors.cyan),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 0),
                    minLeadingWidth: 20,
                    leading: Icon(
                      Icons.visibility,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      position != null
                          ? "Visibility: ${position!["visibility"]}"
                          : "No Data Available",
                      style: TextStyle(fontSize: 20, color: Colors.red[400]),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 0),
                    minLeadingWidth: 20,
                    leading: Icon(
                      Icons.groups,
                      color: Colors.white,
                      size: 30,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"))
                                    ],
                                    title: Text("People In Space Now"),
                                    content: ListView.builder(
                                        itemCount:
                                            totalPeople!["people"].length,
                                        itemBuilder: (context, count) {
                                          return ListTile(
                                            title: Text(totalPeople!["people"]
                                                [count]["name"]),
                                            subtitle: Text(
                                                totalPeople!["people"][count]
                                                    ["craft"]),
                                          );
                                        }));
                              });
                        },
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.white,
                          size: 30,
                        )),
                    title: Text(
                      position != null
                          ? "People In Space Now: ${totalPeople!["number"]}"
                          : "No Data Available",
                      style: TextStyle(fontSize: 20, color: Colors.purple[200]),
                    ),
                  )
                ],
              )),
        ));
  }
}
