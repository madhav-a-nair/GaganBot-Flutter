import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:atl_space_challenge_project/widgets/planetPicker.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Top5Elements extends StatefulWidget {
  @override
  _Top5ElementsState createState() => _Top5ElementsState();
}

class _Top5ElementsState extends State<Top5Elements> {
  void initState() {
    loadData();
    Timer(Duration(seconds: 1), () {
      changeText();
    });
    super.initState();
  }

  void loadData() async {
    data = jsonDecode(await DefaultAssetBundle.of(context)
        .loadString("assets/data/planetData.json"));
  }

  dynamic data = {};
  TextEditingController controller = TextEditingController();
  String planet = "sun";
  String text = "";
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Planet Composition".toUpperCase(),
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              Text(
                "Select The Celestial Body",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 330,
                  height: 90,
                  child: PlanetPicker().create(true, true, (t) {
                    planet = t;
                    changeText();
                  })),
              Text(
                planet.toUpperCase(),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.lime,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Top 5 Elements " + text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 250,
                  width: double.infinity,
                  child: BarChart(mainBarData())),
              SizedBox(
                height: 20,
              ),
              Text(
                "Data Source:\nLunar And Planetary Institute, USRA",
                style: TextStyle(
                    fontSize: 13, color: Colors.grey.withOpacity(0.9)),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 10,
                color: Colors.white.withOpacity(0.3),
                thickness: 1,
              ),
              ExpansionTile(
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                leading: Icon(
                  Icons.help_outline_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  "What is the most abundant elements in the universe?",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                children: [
                  Text(
                    "Hydrogen is the most abundant element in the universe, accounting for about 75 percent of its normal matter. The hydrogen in the universe and also in your body came from the Big Bang.",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      maxY: 100,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String element;
              element = data["Top 5 Elements"][planet]
                  .keys
                  .toList()[group.x.toInt()]
                  .toString()
                  .split("||")[1];
              return BarTooltipItem(
                element + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (double.parse((rod.y - 15).toStringAsFixed(3)))
                        .toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            String element;
            element = data["Top 5 Elements"][planet]
                .keys
                .toList()[value.toInt()]
                .toString()
                .split("||")[0];
            return element;
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    Color? color = planet == "sun"
        ? Colors.purple[800]!
        : planet == "mercury"
            ? Colors.indigo
            : planet == "venus"
                ? Colors.blue
                : planet == "earth"
                    ? Colors.green
                    : planet == "moon"
                        ? Colors.yellow
                        : planet == "mars"
                            ? Colors.orange
                            : planet == "jupiter"
                                ? Colors.red[700]
                                : planet == "saturn"
                                    ? Colors.yellow[700]
                                    : planet == "uranus"
                                        ? Colors.grey[400]
                                        : planet == "neptune"
                                            ? Colors.limeAccent
                                            : Colors.white;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 15 : y,
          colors: [color!],
          width: width,
          borderSide: BorderSide(color: Colors.white, width: 0.5),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 100,
            colors: [Colors.grey[300]!.withOpacity(0.2)],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
        if (data["Top 5 Elements"] != null) {
          List elements = data["Top 5 Elements"][planet].values.toList();
          List top5Elements = [];
          elements.forEach((element) {
            top5Elements.add(double.parse(element.toStringAsFixed(1)));
          });
          return makeGroupData(i, double.parse(elements[i].toString()),
              isTouched: i == touchedIndex);
        } else {
          return makeGroupData(1, 1, isTouched: i == touchedIndex);
        }
      });
  void changeText() {
    setState(() {
      text = planet == "sun"
          ? "On The Photosphere"
          : planet == "mercury"
              ? "On The Surface"
              : planet == "venus"
                  ? "In The Atmosophere"
                  : planet == "earth"
                      ? "In The Continental Crust"
                      : planet == "moon"
                          ? "On The Surface"
                          : planet == "mars"
                              ? "In The Crust"
                              : planet == "jupiter"
                                  ? "In The Atmosphere"
                                  : planet == "saturn"
                                      ? "In The Atmosphere"
                                      : planet == "uranus"
                                          ? "In The Atmosphere"
                                          : planet == "neptune"
                                              ? "In The Atmosphere"
                                              : "";
    });
  }
}
