import 'dart:math';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class SpaceWeb extends StatefulWidget {
  @override
  _SpaceWebState createState() => _SpaceWebState();
}

final fb = FirebaseDatabase.instance;
bool loading = false;

class _SpaceWebState extends State<SpaceWeb> {
  final ref = fb.reference();
  List<Map> books = [];
  List<Map> wantedWebPages = [];
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space Web".toUpperCase(),
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
                // TextField(
                //   keyboardType: TextInputType.text,
                //   textInputAction: TextInputAction.search,
                //   style: TextStyle(color: Colors.white),
                //   decoration: InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Colors.white, width: 1)),
                //       enabledBorder: OutlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Colors.white, width: 1)),
                //       hintText: "Search Space Books....",
                //       hintStyle: TextStyle(color: Colors.grey)),
                // ),
                SizedBox(
                  height: 10,
                ),
                loading
                    ? Text(
                        "Loading....",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          color: Colors.blueGrey.shade800,
                          onRefresh: refresh,
                          child: ListView.separated(
                            itemBuilder: (context, count) {
                              List<Color> colors = [
                                Colors.purple.shade800,
                                Colors.indigo,
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.orange,
                                Colors.red
                              ];
                              final random = Random();
                              return ListTile(
                                  minVerticalPadding: 0,
                                  minLeadingWidth: 35,
                                  onTap: () {
                                    launch(wantedWebPages[count]["Link"]);
                                  },
                                  leading: Icon(
                                    Icons.language,
                                    color: colors[random.nextInt(6)],
                                    size: 35,
                                  ),
                                  title: Text(
                                    wantedWebPages[count]["Title"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    wantedWebPages[count]["Description"],
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 35,
                                    color: Colors.grey,
                                  ));
                            },
                            separatorBuilder: (context, count) {
                              return Divider(
                                height: 10,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.4),
                              );
                            },
                            itemCount: wantedWebPages.length,
                          ),
                        ),
                      ),
              ],
            )),
      ),
    );
  }

  Future<void> refresh() async {
    books = [];
    wantedWebPages = [];
    if (await InternetConnectionChecker().hasConnection) {
      setState(() {
        loading = true;
      });
      await ref.child("Space Web").once().then((value) {
        List result = value.value;
        for (var i = 0; i < result.length; i++) {
          books.add(result[i]);
          print(books);
        }
      });
      wantedWebPages = books;
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No Internet Connection!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
    // if (books.length >= 15) {
    //   for (var i = 0; i < 15; i++) {
    //     wantedWebPages.add(books[i]);
    //   }
    // } else {
    //   for (var i = 0; i < books.length; i++) {
    //     wantedWebPages.add(books[i]);
    //   }
    // }
  }
}
