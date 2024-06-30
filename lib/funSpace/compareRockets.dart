import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

class CompareRockets extends StatefulWidget {
  @override
  _CompareRocketsState createState() => _CompareRocketsState();
}

class _CompareRocketsState extends State<CompareRockets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Space Animations".toUpperCase(),
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
            child: ListView(
              children: [
                createTile(
                    "https://www.youtube.com/embed/hQ62htM7YoA", "PIB India"),
                createTile("https://www.youtube.com/embed/_qH2hI9GwFQ",
                    "Stanley Creative"),
                createTile(
                    "https://www.youtube.com/embed/4Ca6x4QbpoM", "SpaceX"),
                createTile(
                    "https://www.youtube.com/embed/_v7YgDum2Sg", "Jared Owen"),
                createTile(
                    "https://www.youtube.com/embed/6h0OaBI7Gwk", "HannesN"),
                createTile(
                    "https://www.youtube.com/embed/0qo78R_yYFA", "SpaceX"),
                createTile(
                    "https://www.youtube.com/embed/sZlzYzyREAI", "SpaceX"),
                createTile(
                    "https://www.youtube.com/embed/cFBRawYov00", "Jared Owen"),
                createTile("https://www.youtube.com/embed/8dpkmUjJ8xU",
                    "Jared Owen (Part 1)"),
                createTile("https://www.youtube.com/embed/tl1KPjxKVqk",
                    "Jared Owen (Part 2)"),
                createTile("https://www.youtube.com/embed/qt_xoCXLXnI",
                    "Jared Owen (Part 3)"),
                createTile(
                    "https://www.youtube.com/embed/-YJhymiZjqc", "Blue Origin"),
                createTile("https://www.youtube.com/embed/aVKFH5-Q0s4",
                    "Ars Technica"),
                createTile("https://www.youtube.com/embed/Z4SXarl6i1k",
                    "SciTech Daily"),
                createTile(
                    "https://www.youtube.com/embed/KBEPcotWAuI", "Stargaze"),
              ],
            )));
  }

  Widget createTile(String url, String source) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WebViewX(
          height: 220,
          width: double.infinity,
          initialContent:
              '<iframe width="${MediaQuery.of(context).size.width - 15}" height="200" src="$url" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
          initialSourceType: SourceType.html,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Video Source: $source, YouTube",
                style: TextStyle(
                    fontSize: 18, color: Colors.grey.withOpacity(0.9)),
              ),
              IconButton(
                  onPressed: () {
                    print(url.replaceAll("embed/", "watch?v="));
                    launch(url.replaceAll("embed/", "watch?v="));
                  },
                  tooltip: "Full Screen",
                  icon: Icon(Icons.fullscreen, color: Colors.white))
            ],
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}
