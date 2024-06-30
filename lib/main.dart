import 'dart:io';

import 'package:atl_space_challenge_project/funSpace.dart';
import 'package:atl_space_challenge_project/solarSystem.dart';
import 'package:atl_space_challenge_project/spaceBase.dart';
import 'package:atl_space_challenge_project/spaceQuest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  Hive.openBox("quizUserPoints");
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme: ThemeData(fontFamily: "Jost"),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/homepagebackground.jpg"))),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset("assets/images/gaganBot.png"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/banner.png"))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SolarSystem()));
                        },
                        child: Image(
                          height: 110,
                          fit: BoxFit.contain,
                          image: AssetImage(
                              "assets/images/buttons/solarSystem.png"),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpaceQuest()));
                        },
                        child: Image(
                          height: 110,
                          fit: BoxFit.contain,
                          image: AssetImage(
                              "assets/images/buttons/spaceQuest.png"),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpaceBase()));
                        },
                        child: Image(
                          height: 110,
                          fit: BoxFit.contain,
                          image:
                              AssetImage("assets/images/buttons/spaceBase.png"),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FunSpace()));
                        },
                        child: Image(
                          height: 110,
                          fit: BoxFit.contain,
                          image:
                              AssetImage("assets/images/buttons/funSpace.png"),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "assets/images/astronaut.png",
                    fit: BoxFit.contain,
                  )
                ],
              ))
            ],
          )),
    );
  }
}
