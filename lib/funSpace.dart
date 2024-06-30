import 'dart:async';

import 'package:atl_space_challenge_project/funSpace/compareRockets.dart';
import 'package:atl_space_challenge_project/funSpace/howFastYouSpin.dart';
import 'package:atl_space_challenge_project/funSpace/simulations.dart';
import 'package:atl_space_challenge_project/funSpace/spaceQuiz.dart';
import 'package:atl_space_challenge_project/funSpace/whereIsISS.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

class FunSpace extends StatefulWidget {
  @override
  _FunSpaceState createState() => _FunSpaceState();
}

class _FunSpaceState extends State<FunSpace> {
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
              "assets/images/satlight.png",
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
                                builder: (context) => QuizHomePage()),
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
                              "Gagan Quiz",
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
                                builder: (context) => HowFastYouSpin()),
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
                              "How Fast You Spin",
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
                                  builder: (context) => WhereIsISS()));
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          elevation: 10,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Track The Station",
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
                                builder: (context) => GameViewer()),
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
                              "DSN Game",
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
                                builder: (context) => Simulations()),
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
                              "Simulations",
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
                                builder: (context) => CompareRockets()),
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
                              "Space Animations",
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

class GameViewer extends StatefulWidget {
  const GameViewer({Key? key}) : super(key: key);

  @override
  _GameViewerState createState() => _GameViewerState();
}

class _GameViewerState extends State<GameViewer> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
    Timer(Duration(seconds: 2), () {
      showInfo();
    });
  }

  void showInfo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            title: Text("Insructions"),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                  """Get a feel of how a Deep Space Network (DSN) communicate with space probes and back!!

--- Aim ---
With minimum data loss, complete the data up-link and down-link with 4 space probes and 2 DSN stations.

--- How To Play ---
· Use the arrow keys (In Computer) or the Arrow Buttons (In Mobile Screen) to steer the antenna.
· Click the space bar (In Computer) or the 'COMMUNICATE' button (In Mobile Screen) to start data transfer.

· When the data hits any of the space probes, data will be returned from the space probe to the antenna. This will increase the progress.
· When all the space probe's progress becomes 100%, you will win the game!!
· You have 3000 data units when you start the game.
· The data units will be reduced when you communicate with the space probes. If it becomes 0, you will lose!!
· Click on the Green Flag to restart the game.

We got this idea from the NASA site 
https://spaceplace.nasa.gov/dsn-game/en/
Thank you NASA for the idea!!

Full Screen Recommended"""),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK")),
            ],
          );
        });
  }

  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DSN Game (Full Screen Recommended)"),
        actions: [
          IconButton(
              tooltip: "Insructions",
              onPressed: () {
                showInfo();
              },
              icon: Icon(Icons.help_outline_rounded)),
          IconButton(
              tooltip: "Info",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Network Connection"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                              "It will take time to load the game depending upon your network connection. If you are unable to open the game then try to open in a browser."),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                launch(
                                    "https://scratch.mit.edu/projects/582804776");
                              },
                              child: Text("OPEN BROWSER")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.info_outline_rounded)),
          SizedBox(
            width: 20,
          ),
          loading
              ? Tooltip(
                  message: "Loading",
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    height: 20,
                    width: 27,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ))
              : Tooltip(message: "Loading Completed", child: Icon(Icons.done)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: WebViewX(
        onPageFinished: (url) {
          loading = false;
          if (mounted) {
            setState(() {});
          }
        },
        onPageStarted: (url) {
          loading = true;
          setState(() {});
        },
        width: double.infinity,
        height: double.infinity,
        initialSourceType: SourceType.html,
        initialContent: """<!DOCTYPE html>
<html>

<head>
	<title>full screen iframe</title>
	<style type="text/css">
		html {
			overflow: auto;
		}
		
		html,
		body,
		div,
		iframe {
			margin: 0px;
			padding: 0px;
			height: 100%;
			border: none;
		}
		
		iframe {
			display: block;
			width: 100%;
			border: none;
			overflow-y: auto;
			overflow-x: hidden;
		}
	</style>
</head>

<body>
	<iframe src="https://scratch.mit.edu/projects/582804776/embed"
			frameborder="0"
			marginheight="0"
			marginwidth="0"
			width="100%"
			height="100%"
			scrolling="no">
</iframe>

</body>

</html>
""",
      ),
    );
  }
}
