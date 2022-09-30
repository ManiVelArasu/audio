/*
import 'package:flutter/material.dart';

Widget screen(){
  return Container(
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                height: 48.0,
                decoration: BoxDecoration(color: Colors.red.shade300),
                child: Center(
                    child: Icon(

                        Icons.mic

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
            print("111111${audioPlayer.onDurationChanged}");
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
    ),
  )
}*/
