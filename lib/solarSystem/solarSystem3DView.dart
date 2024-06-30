import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class SolarSystem3DView extends StatefulWidget {
  @override
  _SolarSystem3DViewState createState() => _SolarSystem3DViewState();
}

class _SolarSystem3DViewState extends State<SolarSystem3DView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewX(
        height: double.infinity,
        width: double.infinity,
        initialContent:
            "https://solarsystem.nasa.gov/solar-system/our-solar-system/overview/",
      ),
    );
  }
}
