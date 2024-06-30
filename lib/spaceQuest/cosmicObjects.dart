import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class CosmicObjects extends StatefulWidget {
  @override
  _CosmicObjectsState createState() => _CosmicObjectsState();
}

class _CosmicObjectsState extends State<CosmicObjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "COSMIC OBJECTS".toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueGrey.shade800,
          elevation: 0,
        ),
        body: WebViewX(
          height: double.infinity,
          width: double.infinity,
          initialContent:
              "https://imagine.gsfc.nasa.gov/science/objects/index.html",
        ));
  }
}
