import 'dart:math';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:url_launcher/url_launcher.dart';

class SpaceBooks extends StatefulWidget {
  @override
  _SpaceBooksState createState() => _SpaceBooksState();
}

final fb = FirebaseDatabase.instance;
bool loading = false;

class _SpaceBooksState extends State<SpaceBooks> {
  final ref = fb.reference();
  List<Map> books = [];
  List<Map> wantedBooks = [];
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Books For The Month".toUpperCase(),
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
                                  launch(wantedBooks[count]["URL"]);
                                },
                                leading: Icon(
                                  Icons.book,
                                  color: colors[random.nextInt(6)],
                                  size: 35,
                                ),
                                title: Text(
                                  wantedBooks[count]["Name"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                subtitle: Text(
                                  "Author: ${wantedBooks[count]["Author"]}\nLanguage: ${wantedBooks[count]["Language"]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                                trailing: Text(
                                  wantedBooks[count]["Availability"]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: wantedBooks[count]
                                                  ["Availability"] ==
                                              "Free"
                                          ? Colors.green
                                          : Colors.orange),
                                ),
                              );
                            },
                            separatorBuilder: (context, count) {
                              return Divider(
                                height: 10,
                                thickness: 1,
                                color: Colors.grey.withOpacity(0.4),
                              );
                            },
                            itemCount: wantedBooks.length,
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
    wantedBooks = [];
    if (await InternetConnectionChecker().hasConnection) {
      setState(() {
        loading = true;
      });
      await ref.child("Books").once().then((value) {
        List result = value.value;
        for (var i = 0; i < result.length; i++) {
          books.add(result.reversed.toList()[i]);
          print(books);
        }
      });
      wantedBooks = books;
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
    //     wantedBooks.add(books[i]);
    //   }
    // } else {
    //   for (var i = 0; i < books.length; i++) {
    //     wantedBooks.add(books[i]);
    //   }
    // }
  }
}

// class BookViewer extends StatefulWidget {
//   final String? url;
//   BookViewer({this.url});
//   @override
//   State<StatefulWidget> createState() {
//     return BookViewerState(url: url);
//   }
// }

// class BookViewerState extends State<BookViewer> {
//   final String? url;
//   BookViewerState({this.url});
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Book Viewer".toUpperCase(),
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.blueGrey.shade800,
//           elevation: 0,
//         ),
//         body: PDF().fromUrl(url!));
//   }
// }
