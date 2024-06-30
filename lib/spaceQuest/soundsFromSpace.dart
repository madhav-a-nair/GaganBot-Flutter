import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio/just_audio.dart';

class SoundsFromSpace extends StatefulWidget {
  @override
  _SoundsFromSpaceState createState() => _SoundsFromSpaceState();
}

class _SoundsFromSpaceState extends State<SoundsFromSpace> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
    player.positionStream.listen((event) async {
      if (player.duration != null) {
        if (player.duration!.inSeconds == player.position.inSeconds) {
          await player.seek(Duration(seconds: 0));
          await player.pause();
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  AudioPlayer player = AudioPlayer();
  List sounds = [
    {
      "Name": "Wind Of Mars",
      "URL":
          "https://static.wixstatic.com/mp3/0cb73c_f7a3334a65a142ebbf2c571c8adbd732.mp3",
      "Description":
          "Sound of the wind on Mars recorded by NASA's Perseverance rover on Feb. 22, 2021",
      "Credit": "NASA",
      "Image": "mars",
    },
    {
      "Name": "'Thats One Small Step For Man' - Neil Amstrong",
      "URL": "https://www.nasa.gov/mp3/590331main_ringtone_smallStep.mp3",
      "Description":
          "Radio communication from Neil Amstrong after Apollo 11 landing on Moon on 24 July 1969",
      "Credit": "NASA",
      "Image": "moon",
    },
    {
      "Name": "Sputnik Beep Sound",
      "URL": "https://www.nasa.gov/mp3/578626main_sputnik-beep.mp3",
      "Description":
          "A simple beeping radio signal that captivated the world after 5th October 1957. Yes, it is the radio beeps from Sputnik, the first man made satlight by Soviet Union",
      "Credit": "NASA",
      "Image": "earth",
    },
    {
      "Name": "Saturn's Radio Emission",
      "URL": "https://www.nasa.gov/wav/123160main_cas-skr2-072504.wav",
      "Description":
          "Saturn is a source of intense radio emissions which is closely related to the auroras near the poles of the planet. This is an audio file of Saturn's radio emissions",
      "Credit": "NASA",
      "Image": "saturn",
    },
    {
      "Name": "Sound Of The Big Bang",
      "URL":
          "http://faculty.washington.edu/jcramer/BigBang/WMAP_2003/BBSnd50.wav",
      "Description":
          "Using data from a NASA satellite called WMAP, John G. Cramer plugged in the frequency spectrum from the Big Bang into some software to turn the data into a sound file. Search the web to know more.",
      "Credit": "John G. Cramer - 2003",
      "Image": "galaxy",
    },
    {
      "Name": "Sound Of The Vela Pulsar",
      "URL":
          "https://www.parkes.atnf.csiro.au/people/sar049/eternal_life/supernova/vela.wav",
      "Description":
          "THis is the radio emission from Vela Pulsar.A pulsar is a highly magnetised neutron star. Radiation is beamed out along the magnetic poles and pulses of radiation are received as the beam crosses the Earth.",
      "Credit": "Australia Telescope National Facility",
      "Image": "galaxy",
    }
  ];
  int? selectedSound;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    print(player.duration);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sounds From Space".toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "Headphone Recommended",
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 0,
        leading: IconButton(
            onPressed: () async {
              await player.pause();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
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
            child: Column(children: [
              loading
                  ? LinearProgressIndicator(
                      color: Colors.redAccent,
                      backgroundColor: Colors.grey.shade300,
                    )
                  : SizedBox(),
              player.duration != null
                  ? Image(
                      image: AssetImage(
                          "assets/images/${sounds[selectedSound!]["Image"]}.png"),
                      height: 100,
                    )
                  : SizedBox(),
              player.duration != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Slider(
                            value: double.parse(
                                player.position.inSeconds.toString()),
                            max: double.parse(
                                player.duration!.inSeconds.toString()),
                            min: 0,
                            onChanged: (value) {
                              player.seek(Duration(seconds: value.round()));
                            }),
                        Text(
                          player.duration!.inSeconds.toString() + " sec",
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              if (player.playing) {
                                player.pause();
                              } else {
                                player.play();
                              }
                            },
                            icon: Icon(
                              player.playing ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            )),
                      ],
                    )
                  : SizedBox(),
              player.duration != null
                  ? Text(
                      sounds[selectedSound!]["Name"],
                      style: TextStyle(fontSize: 25, color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox(),
              player.duration != null
                  ? Text(
                      sounds[selectedSound!]["Description"],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: ListView.separated(
                  itemCount: sounds.length,
                  separatorBuilder: (context, count) {
                    return Divider(
                      height: 5,
                      thickness: 1,
                    );
                  },
                  itemBuilder: (context, count) {
                    List<Color> colors = [
                      Colors.purple.shade800,
                      Colors.indigo,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow.shade700,
                      Colors.orange,
                      Colors.red
                    ];
                    final random = Random();
                    return ListTile(
                        leading: Icon(
                          Icons.music_note,
                          color: colors[random.nextInt(6)],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        title: Text(sounds[count]["Name"]),
                        subtitle: Text("Source: " + sounds[count]["Credit"]),
                        onTap: () async {
                          if (loading == false) {
                            if (await InternetConnectionChecker()
                                .hasConnection) {
                              setState(() {
                                selectedSound = count;
                                loading = true;
                              });
                              await player.setUrl(sounds[count]["URL"]);
                              await player.load();
                              setState(() {
                                loading = false;
                              });
                              print(player.duration);
                              await player.play();
                              setState(() {});
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Internet Connection!"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ));
                            }
                          }
                        });
                  },
                ),
              ))
            ])),
      ),
    );
  }
}
