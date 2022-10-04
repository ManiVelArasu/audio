import 'dart:io';
import 'package:audio/Constants/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import 'package:record_mp3/record_mp3.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

late String recordFilePath;
String playerid = "";
var path;
AudioPlayer audioPlayer = new AudioPlayer();

class _HomepageState extends State<Homepage> {
  Duration duration = new Duration();
  Duration position = new Duration();
  String statusText = "";
  bool isComplete = false;
  var isplaying = false;
  var ispaused = false;
  var played = false;
  Color x = Colors.red;
  bool sound = true;
  bool values = true;
  double val = 1;
  List audioplayerss = [];
  var player;

  @override
  void initState() {
    // TODO: implement initState

    audioPlayer.onDurationChanged.listen((d) {
      setState(
        () {
          duration = d;
        },
      );
      print("lllllld${duration.inSeconds.toDouble()}");
      print("sfdcsdfdfssdf scffdfsc afdgvrett${audioplayerss}");
    });
    audioPlayer.onPositionChanged.listen((d) {
      setState(() {
        position = d;
        print("llllll${position.inSeconds.toDouble()}");
      });
    });
    audioPlayer.onPlayerComplete.listen((event) {
      isplaying = false;
      setState(() {});
      setState(() {
        position = Duration(seconds: 0);
      });
    });
    super.initState();
    setState(() {
      print("object");
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(color: x),
                    child: Center(child: Icon(Icons.mic)),
                  ),
                  onTap: () async {
                    if (played == false) {
                      setState(() {
                        played = true;
                        x = Colors.green;
                      });
                      startRecord();
                    } else if (played == true) {
                      stopRecord();
                      setState(() {
                        played = false;
                        x = Colors.red;
                      });
                    }
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(color: Colors.blue.shade300),
                    child: Center(
                      child: Icon(
                        RecordMp3.instance.status == RecordStatus.PAUSE
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  ),
                  onTap: () {
                    pauseRecord();
                  },
                ),
              ),
              /*    Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(color: Colors.green.shade300),
                    child: Center(child: Icon(Icons.stop)),
                  ),
                  onTap: () {
                  },
                ),
              ),*/
            ],
          ),
          Container(
            child: audio(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              statusText,
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isplaying == false && ispaused == false) {
                setState(() {
                  isplaying = true;
                });
                play();
              } else if (ispaused == false && isplaying == true) {
                pause();
                setState(() {
                  ispaused = true;
                  isplaying = false;
                });
              } else if (ispaused == true && isplaying == false) {
                setState(() {
                  ispaused = false;
                  isplaying = true;
                });
                resume();
              } else {
                setState(() {
                  ispaused = false;
                  isplaying = false;
                });
              }
            },
            child: Container(
                margin: EdgeInsets.only(top: 30),
                alignment: AlignmentDirectional.center,
                width: 100,
                height: 50,
                child: Icon(!isplaying ? Icons.play_arrow : Icons.pause)),
          ),
          Container(
            child: slider(),
          ),
           Container(
            child: list(),
          )
        ]),
      ),
    );
  }
  Widget slider() {
    print("${position.inSeconds.toDouble()}  $duration");
    return Slider(
        activeColor: Colors.blue,
        inactiveColor: Colors.orange,
        //min: 0.0,
        /*divisions: 1,*/
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) async {
          setState(() {
            seekToSecond(value.toInt());
            print("time${value}");
          });
        });
  }
  Widget audio() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              position.toString().split(".")[0],
              style: TextStyle(fontSize: 20),
            ),
            Text(
              duration.toString().split(".")[0],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }

  Widget list() {
    return Container(
      height: 400,
      child: ListView.builder(
          itemCount: audioplayerss.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) {
                setState(() {
                  audioplayerss.removeAt(index);
                });
              },
              child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.list),
                      trailing: const Text(
                        "GFG",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: InkWell(
                        child: Text("List item $index"),
                      ),
                      onTap: () {
                        print("12345678098765432${index}");
                        print("12345678098765432${isplaying}");
                        print("12345678098765432bbbbbbb${ispaused}");
                       if(isplaying==false&&ispaused==false && index!=player){
                         setState(() {
                           print("123432423");
                           print("123432423");
                           player=index;
                         });
                         play();
                       }
                       else {
                         setState(() {
                           print("aaaaaaaaaaa");
                           position = Duration(seconds: 0);
                           player=index;
                           isplaying==true;
                           ispaused==false;
                         });
                         play();
                       }

                      },
                    ),
                  ),
              background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            );
          }),
    );
  }
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission && isplaying != true && ispaused != true) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      audioplayerss.add(recordFilePath);
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "Do Not Recorded";
    }
    setState(() {});
  }
  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }
  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }
  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }
  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      print("${audioPlayer.playerId}");
      var path = audioplayerss[player];
      print("maniii${player}");
      getFilePath().then((v) => path = v);
      print("123dfghj${recordFilePath}");
      print("dfdfdsfdsfdsfds");
      audioPlayer.play(DeviceFileSource(path)).then((value) => audioPlayer
          .getDuration()
          .then((value) => print("12323232${value!.inSeconds}")));
      print("kkskskksk${slider()}");
      print("kkskskksk${slider()}");
      isplaying = true;
      setState(() {});
    }
  }
  void pause() {
    print("ffffffffffff");
    audioPlayer.pause();
    isplaying = false;
    setState(() {});
    setState(() {
      if (isplaying == true && ispaused == false) {
        play();
      }
    });
  }
  void resume() {
    print("ffffffffffff");
    audioPlayer.resume();
    isplaying = true;
    setState(() {});
  }
  int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    print("skadksdksdkksadkdkd${sdPath}");
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
}
