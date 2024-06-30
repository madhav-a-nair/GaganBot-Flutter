import 'package:flutter/material.dart';

class PlanetPicker {
  Widget create(bool needSun, bool needMoon, Function(String t) onPressed) {
    List<String> planets = [
      "sun",
      "mercury",
      "venus",
      "earth",
      "moon",
      "mars",
      "jupiter",
      "saturn",
      "uranus",
      "neptune"
    ];
    List<Widget> items = [];
    if (needSun == false) {
      planets.remove(0);
    }
    if (needMoon == false) {
      planets.remove(4);
    }
    planets.forEach((element) {
      items.add(TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Colors.grey[500],
              textStyle: TextStyle(fontSize: 18, fontFamily: "Jost")),
          onPressed: () => onPressed(element),
          icon: Image.asset(
            "assets/images/$element.png",
            height: 80,
            fit: BoxFit.contain,
          ),
          label: Text(element.toUpperCase())));
      items.add(SizedBox(
        height: 90,
        child: VerticalDivider(
          thickness: 1,
          width: 5,
        ),
      ));
    });
    return ListView(
      scrollDirection: Axis.horizontal,
      children: items,
    );
  }
}
