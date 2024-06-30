import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class QuizHomePage extends StatefulWidget {
  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

final box = Hive.box("quizUserPoints");
final fb = FirebaseDatabase.instance;
NumberFormat format = NumberFormat.decimalPattern("hi");
List finalQuestions = [];

class _QuizHomePageState extends State<QuizHomePage> {
  @override
  void initState() {
    super.initState();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "GAGAN QUIZ".toUpperCase(),
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
              child: Column(
                children: [
                  Text(
                    "My Badges",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 110,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Tooltip(
                            message: "Planet Badge",
                            child: box.get("points", defaultValue: 0) >= 200
                                ? Image.asset(
                                    "assets/images/icons/planetBadge.png",
                                    fit: BoxFit.fill,
                                    height: 90,
                                    width: 110,
                                  )
                                : createEmptyBadge(200, "Planet Badge")),
                        SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                            message: "Star Badge",
                            child: box.get("points", defaultValue: 0) >= 1000
                                ? Image.asset(
                                    "assets/images/icons/starBadge.png",
                                    fit: BoxFit.fill,
                                    height: 90,
                                    width: 110,
                                  )
                                : createEmptyBadge(1000, "Star Badge")),
                        SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                            message: "Galaxy Badge",
                            child: box.get("points", defaultValue: 0) >= 5000
                                ? Image.asset(
                                    "assets/images/icons/galaxyBadge.png",
                                    fit: BoxFit.fill,
                                    height: 90,
                                    width: 110,
                                  )
                                : createEmptyBadge(5000, "Galaxy Badge")),
                        SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                            message: "Big Bang Badge",
                            child: box.get("points", defaultValue: 0) >= 8000
                                ? Image.asset(
                                    "assets/images/icons/bigBangBadge.png",
                                    fit: BoxFit.fill,
                                    height: 90,
                                    width: 110,
                                  )
                                : createEmptyBadge(8000, "Big Bang Badge")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Tooltip(
                              message: "Gagan Points",
                              child: Image.asset(
                                "assets/images/icons/points.png",
                                height: 60,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${format.format(box.get("points", defaultValue: 0))}",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: loading ? 1 : 50,
                    width: loading ? double.infinity : 140,
                    child: loading
                        ? LinearProgressIndicator(
                            color: Colors.redAccent,
                            backgroundColor: Colors.transparent,
                          )
                        : ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Start Quiz"),
                                      content: Text("Are you ready?" +
                                          "\n\n" +
                                          "Rules\n1. There will be 5 questions.\n2. Each correct answer carrys 5 Gagan Points.\n3. A wrong answer will reduce 3 Gagan Points.\n4. You have to complete the questions in 60 seconds.\n4. The more Gagan Points you get, the more badges you achive."),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("CANCEL")),
                                        TextButton(
                                            onPressed: () {
                                              createQuiz();
                                              Navigator.pop(context);
                                            },
                                            child: Text("YES"))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text("START"),
                            style: ElevatedButton.styleFrom(
                                textStyle:
                                    TextStyle(fontSize: 18, fontFamily: "Jost"),
                                foregroundColor: Colors.blueGrey.shade800),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  loading
                      ? Text(
                          "Generating Quiz Questions....",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      : SizedBox()
                ],
              ),
            )));
  }

  Widget createEmptyBadge(int obtainWhen, String name) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "$name\n@ $obtainWhen Points",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: Colors.grey),
      ),
      height: 90,
      width: 110,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(100)),
    );
  }

  void createQuiz() async {
    setState(() {
      loading = true;
    });
    List quizQuestions = [];
    final ref = fb.reference();
    await ref.child("Quiz").once().then((questions) {
      List data = questions.value;
      for (var i = 0; i < 5; i++) {
        final ranNum = Random();
        final val = ranNum.nextInt(data.length);
        quizQuestions.add(data[val]);
        data.removeAt(val);
      }
    });
    finalQuestions = quizQuestions;
    setState(() {
      loading = false;
    });
    Navigator.pop(context);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Quiz()));
  }
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

List<Map> resultTable = [];

class _QuizState extends State<Quiz> {
  @override
  void initState() {
    super.initState();
    resultTable = [];
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 60) {
        timer.cancel();
        setState(() {
          timeLeft = 0;
        });
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Time Up..."),
                content: Text("Oops!! Time is Up. Better Luck Next Time"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              );
            }).then((value) => Navigator.pop(context));
      } else {
        setState(() {
          timeLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  int timeLeft = 60;
  var timer;

  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "QUIZ".toUpperCase(),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Slider(
                    min: 0,
                    max: 60,
                    value: double.parse(timeLeft.toString()),
                    onChanged: (value) => null,
                    divisions: 60,
                    inactiveColor: Colors.grey.shade300,
                    activeColor: timeLeft < 20
                        ? Colors.red
                        : timeLeft >= 20 && timeLeft < 40
                            ? Colors.yellow
                            : timeLeft >= 40 && timeLeft < 60
                                ? Colors.green
                                : Colors.green),
                Text(
                  "Time Left: $timeLeft sec",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: ListView(
                  children: [
                    Text(
                      "Q${currentQuestion + 1}. ${finalQuestions[currentQuestion]["q"]}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    createOption("A", 0),
                    createOption("B", 1),
                    createOption("C", 2),
                    createOption("D", 3)
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  Widget createOption(String option, int optionNumber) {
    return Container(
      height: 70,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TextButton.icon(
            onPressed: () {
              if (currentQuestion == 4) {
                resultTable.add({
                  "Question": finalQuestions[currentQuestion]["q"],
                  "Correct Answer": finalQuestions[currentQuestion]["c"],
                  "Your Answer": optionNumber
                });
                timer.cancel();
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizResults()));
              } else {
                resultTable.add({
                  "Question": finalQuestions[currentQuestion]["q"],
                  "Correct Answer": finalQuestions[currentQuestion]["c"],
                  "Your Answer": optionNumber
                });
                setState(() {
                  currentQuestion++;
                });
              }
            },
            icon: CircleAvatar(
              backgroundColor: optionNumber == 0
                  ? Colors.red
                  : optionNumber == 1
                      ? Colors.green
                      : optionNumber == 2
                          ? Colors.blue
                          : optionNumber == 3
                              ? Colors.pink
                              : Colors.red,
              child: Text(
                option,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            label: Text(
              "- ${finalQuestions[currentQuestion]["o"][optionNumber]}",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizResults extends StatefulWidget {
  @override
  _QuizResultsState createState() => _QuizResultsState();
}

class _QuizResultsState extends State<QuizResults> {
  int score = box.get("points", defaultValue: 0);
  int previousScore = box.get("points", defaultValue: 0);

  @override
  void initState() {
    calculate();
    super.initState();
  }

  void calculate() async {
    int currentScore = 0;
    print(resultTable.length);
    resultTable.forEach((element) {
      if (element["Your Answer"] == element["Correct Answer"]) {
        currentScore = currentScore + 5;
      } else {
        currentScore = currentScore - 3;
      }
    });
    print([score, currentScore]);
    score = score + currentScore;
    await box.put("points", score);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => QuizHomePage()));
            },
          ),
          title: Text(
            "QUIZ RESULTS".toUpperCase(),
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
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tooltip(
                        message: "Your Current Gagan Points",
                        child: Image.asset(
                          "assets/images/icons/points.png",
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        score.toString(),
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                          score > previousScore
                              ? "+ ${score - previousScore}"
                              : previousScore > score
                                  ? "- ${previousScore - score}"
                                  : "",
                          style: TextStyle(
                              fontSize: 25,
                              color: score > previousScore
                                  ? Colors.green
                                  : previousScore > score
                                      ? Colors.red
                                      : Colors.white)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, count) {
                            return Divider(
                              height: 20,
                              thickness: 1,
                              color: Colors.grey,
                            );
                          },
                          itemCount: 5,
                          itemBuilder: (context, count) {
                            return ListTile(
                              minLeadingWidth: 15,
                              leading: resultTable[count]["Correct Answer"] ==
                                      resultTable[count]["Your Answer"]
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                              title: Text(
                                resultTable[count]["Question"],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                "\n" +
                                    "Your Answer: ${finalQuestions[count]["o"][resultTable[count]["Your Answer"]]}" +
                                    "\n" +
                                    "Correct Answer: ${finalQuestions[count]["o"][resultTable[count]["Correct Answer"]]}",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }))
                ],
              ),
            )));
  }
}
