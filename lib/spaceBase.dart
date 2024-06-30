import 'package:atl_space_challenge_project/spaceBase/indianSpaceSpots.dart';
import 'package:atl_space_challenge_project/spaceBase/isroTimeLine.dart';
import 'package:atl_space_challenge_project/spaceBase/spaceBooks.dart';
import 'package:atl_space_challenge_project/spaceBase/spaceWeb.dart';
import 'package:atl_space_challenge_project/spaceBase/virtualTours.dart';
import 'package:flutter/material.dart';

class SpaceBase extends StatefulWidget {
  @override
  _SpaceBaseState createState() => _SpaceBaseState();
}

class _SpaceBaseState extends State<SpaceBase> {
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
              "assets/images/astro.png",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    TextButton(
                        onPressed: () {
                          Future.delayed(Duration(seconds: 0), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndianSpaceSaga()),
                            );
                          });
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Indian Space Saga",
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
                          Future.delayed(Duration(seconds: 0), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpaceBooks()));
                          });
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Space Books",
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
                          Future.delayed(Duration(seconds: 0), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VirtualTours()),
                            );
                          });
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Virtual Tours",
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
                          Future.delayed(Duration(seconds: 0), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndianSpaceSpots()),
                            );
                          });
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Indian Space Spots",
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
                          Future.delayed(Duration(seconds: 0), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpaceWeb()),
                            );
                          });
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Space Web",
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
