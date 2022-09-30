import 'dart:io';
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
String playerid="";
var path;
AudioPlayer audioPlayer = new AudioPlayer();
class _HomepageState extends State<Homepage> {
  Duration duration = new Duration();
  Duration position = new Duration();
  String statusText = "";
  bool isComplete = false;
  bool played=true;
  bool paused=true;
  bool _value = false;
  double val = 1;

  @override
  void initState() {
    // TODO: implement initState
    audioPlayer = new AudioPlayer();

    audioPlayer.onDurationChanged.listen((d){setState(() {
      duration=d;
    });});

    audioPlayer.onPositionChanged.listen((d){setState(() {
      duration=d;
    });});

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
                    decoration: BoxDecoration(color: Colors.red.shade300),
                    child: Center(
                      child: Icon(Icons.mic

                      )
                    ),
                  ),
                  onTap: () async {
                    startRecord();
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
                            ? Icons.pause:Icons.play_arrow

                           ,
                      ),
                    ),
                  ),
                  onTap: () {
                    pauseRecord();
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 48.0,
                    decoration: BoxDecoration(color: Colors.green.shade300),
                    child: Center(
                      child: Icon(Icons.stop
                      )
                    ),
                  ),
                  onTap: () {
                    stopRecord();
                  },
                ),
              ),

            ],
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
              if(played==true && paused == true){
                setState(() {
                  paused=false;
                });
             play();
              }
              else{
                setState(() {
                  paused=true;
                });
                pause();
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 30),
              alignment: AlignmentDirectional.center,
              width: 100,
              height: 50,
              child:Icon(
                  played==true && paused == true?
                      Icons.play_arrow:Icons.pause
              )

            ),
          ),
          Container(
            child: slider(),
          )


        ]),
      ),
    );
  }
  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.blue,
        inactiveColor: Colors.orange,
        min: 0.0,
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
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
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {

        });
      });
    } else {
      statusText = "No microphone permission";
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
      print("${ audioPlayer.playerId}");
      var path = recordFilePath;
      getFilePath().then((v) => path=v);
      print("dfdfdsfdsfdsfds");
      audioPlayer.play(DeviceFileSource(path));
      slider();
    }
  }
  void pause() {
      print("ffffffffffff");
      audioPlayer.pause();
  }
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
}