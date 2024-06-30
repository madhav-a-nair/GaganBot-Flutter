import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class IndianSkyMap extends StatefulWidget {
  @override
  _IndianSkyMapState createState() => _IndianSkyMapState();
}

class _IndianSkyMapState extends State<IndianSkyMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Indian Sky Map".toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 0,
      ),
      body: WebViewX(
        height: double.infinity,
        width: double.infinity,
        initialContent: "https://astron-soc.in/outreach/resources/sky-maps/",
      ),
    );
  }
}
