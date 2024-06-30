import 'package:atl_space_challenge_project/solarSystem/howFarIsThePlanet.dart';
import 'package:atl_space_challenge_project/solarSystem/solarSystem3DView.dart';
import 'package:atl_space_challenge_project/solarSystem/top5elements.dart';
import 'package:atl_space_challenge_project/solarSystem/weigthDifferentPlanets.dart';
import 'package:atl_space_challenge_project/solarSystem/whoIsBigger.dart';
import 'package:flutter/material.dart';

class SolarSystem extends StatefulWidget {
  @override
  _SolarSystemState createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/homepagebackground.jpg"))),
        child: Column(
          children: [
            Image.asset(
              "assets/images/subPageBackgroundIcon.png",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeigthDifferentPlanets()),
                          );
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Weight Checker",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            ),
                            height: 60,
                            width: double.infinity,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WhoIsBigger()),
                          );
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Who Is Bigger",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            ),
                            height: 60,
                            width: double.infinity,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Top5Elements()),
                          );
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Planet Composition",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            ),
                            height: 60,
                            width: double.infinity,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HowFarIsThePlanet()),
                          );
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Feel The Distance",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            ),
                            height: 60,
                            width: double.infinity,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SolarSystem3DView()),
                          );
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Solar System 3D View",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 3),
                            ),
                            height: 60,
                            width: double.infinity,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
