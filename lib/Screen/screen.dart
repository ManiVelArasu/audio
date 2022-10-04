/*
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';

class page8 extends StatefulWidget {
  const page8({super.key});

  @override
  State<page8> createState() => _page8State();
}

class _page8State extends State<page8> {
  AudioPlayer audioPlayer = AudioPlayer();
  List audio = [];
  Color x = Color.fromRGBO(255, 255, 255, 1);
  bool plps = false;
  bool blay = false;
  bool bass = false;
  bool valuee = false;

  var position = 0.0;
  var totduration = 0.10;
  @override
  void initState() {
    audioPlayer.onDurationChanged.listen((event1) {
      setState(() {
        totduration = event1.inSeconds.toDouble();
      });
    });
    audioPlayer.onPositionChanged.listen((event) {
      print(
          "changing potition..................................@initstate...................................${event.inSeconds.toDouble()}");

      setState(() {
        position = event.inSeconds.toDouble();
      });

      if (totduration == position) {
        setState(() {
          blay = false;
          position = 0.0;
        });
      }

      print(
          ".....${totduration}.${position}...................... blay${blay}..........................playing completed");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 250, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(255, 192, 117, 1),
                ),
                margin: EdgeInsets.only(top: 10, left: 20),
                width: MediaQuery.of(context).size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            CircleAvatar(),
                            Column(
                              children: [
                                Container(
                                  // color: Colors.green,
                                  width: 250 - 40,
                                  child: Column(
                                    children: [
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          // activeTrackColor: Colors.white,
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 5.0),
                                          overlayShape: RoundSliderOverlayShape(
                                              overlayRadius: 10.0),
                                          thumbColor:
                                          Color.fromRGBO(255, 255, 255, 1),
                                        ),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              child: Container(
                                                margin:
                                                EdgeInsets.only(left: 10),
                                                child: blay == false
                                                    ? Icon(Icons.play_arrow)
                                                    : Icon(Icons.pause),
                                              ),
                                              onTap: () {
                                                if (audio.isNotEmpty) {
                                                  print(
                                                      "the audio list................@emphtycheck..................${audio}");
                                                  if (blay == false &&
                                                      bass == false) {
                                                    setState(() {
                                                      blay = true;
                                                    });
                                                    print(
                                                        "................. blay${blay}..........................playing started");
                                                    audioplay();
                                                  } else if (blay == true &&
                                                      bass == false) {
                                                    setState(() {
                                                      blay = false;
                                                      bass = true;
                                                    });
                                                    print(
                                                        "play........${blay}..........................@audiopause");
                                                    audiopausee();
                                                  } else if (blay == false &&
                                                      bass == true) {
                                                    setState(() {
                                                      blay = true;
                                                      bass = false;
                                                    });
                                                    audiores();
                                                  } else {
                                                    setState(() {
                                                      blay = false;
                                                      bass = false;
                                                    });
                                                    print(
                                                        "..............................nothing to do.................");
                                                  }
                                                } else {
                                                  print(
                                                      "nothing to play...................................@ontap .............audioplayerr");
                                                }
                                              },
                                            ),
                                            Slider(
                                              // min: 0.0,
                                              max: totduration,
                                              // divisions: 10,
                                              activeColor: Colors.green,
                                              inactiveColor: Color.fromRGBO(
                                                  243, 122, 54, 1),
                                              value: position,
                                              onChanged: (double value) {
                                                setState(() {
                                                  position = value;
                                                  seeksom(value.toInt());
                                                });
                                                print(
                                                    "......vvvvvvvvvvvvvv,,,,,,,,,,,,,${blay}");
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 12),
                                        width: 140,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // margin: EdgeInsets.only(left: 45),
                                              child: Text(
                                                "10:02",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "12:26 pm",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width * 0.69,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            InkWell(
                              child: Container(
                                height: 30,
                                width: 30,
                                margin: EdgeInsets.only(
                                  left:
                                  MediaQuery.of(context).size.width * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    color: x,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(Icons.mic),
                              ),
                              onTap: () {
                                print("plps......>>>>>>>>>>>${plps}");
                                print("blay......>>>>>>>>>>>${blay}");
                                print("bass......>>>>>>>>>>>${bass}");
                                if(blay==true||bass==true){
                                  print("play or pause is true");
                                }
                                else if (plps == false) {
                                  print(
                                      ".......................Record audio...................");
                                  setState(() {
                                    plps = true;
                                    x = Colors.green;
                                  });
                                  startRecord();
                                } else if (plps == true) {
                                  print(
                                      ".......................stop audio recoord...................");
                                  setState(() {
                                    plps = false;
                                    x = Color.fromRGBO(255, 255, 255, 1);
                                  });
                                  stopRecord();
                                  audio.add(recordFilePath);
                                  setState(() {
                                    recordFilePath = "";
                                  });
                                }
                                print(
                                    "audio list............@recorder..................${audio}");
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var recordFilePath;
//Getting Path
  int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

//Checking mic Permision
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

//starting recording
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();
      print(
          "Start recording record path...........................${recordFilePath}");
      RecordMp3.instance.start(recordFilePath, (type) {
        setState(() {});
      });
    } else {}
    setState(() {});
  }

  void stopRecord() {
    RecordMp3.instance.stop();
  }

  void audioplay() async {
    if (audio.isNotEmpty) {
      print("Audio player playing.........................................");
      var path = audio[i - 1];
      audioPlayer.play(DeviceFileSource(path));
      await audioPlayer
          .play(DeviceFileSource(path))
          .then((value1) => audioPlayer.getDuration().then((value2) {
        print("duration....${value2!.inSeconds.toDouble()}");
        setState(() {
          totduration = value2!.inSeconds.toDouble();
        });
        print("duration....${value2!.inSeconds.toDouble()}");
        print("duration....${totduration}");
      }));
    } else {
      print(
          "................................what do I play...................................");
    }
  }

  void audiopausee() {
    audioPlayer.pause();
    print("Audio player paused.........................................");
  }

  Future<void> audiores() async {
    audioPlayer.resume();
    print(
        "Audio player started again.........................................");
  }

  void seeksom(var val) {
    Duration duration = new Duration(seconds: val);
    audioPlayer.seek(duration);
  }
}
*/
