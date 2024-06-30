import 'package:atl_space_challenge_project/spaceQuest/cosmicObjects.dart';
import 'package:atl_space_challenge_project/spaceQuest/indianSkyMap.dart';
import 'package:atl_space_challenge_project/spaceQuest/soundsFromSpace.dart';
import 'package:atl_space_challenge_project/spaceQuest/starSizeComparison.dart';
import 'package:flutter/material.dart';

class SpaceQuest extends StatefulWidget {
  @override
  _SpaceQuestState createState() => _SpaceQuestState();
}

class _SpaceQuestState extends State<SpaceQuest> {
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
              "assets/images/galaxy.png",
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
                                builder: (context) => SoundsFromSpace()),
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
                              "Sounds From Space",
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
                                builder: (context) => UniverseSizeComparison()),
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
                              "Star Size Comparison",
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
                                builder: (context) => CosmicObjects()),
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
                              "Cosmic Objects",
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
                                builder: (context) => IndianSkyMap()),
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
                              "Indian Sky Map",
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
