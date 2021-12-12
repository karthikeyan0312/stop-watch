// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: StopWatch(title: 'Stop Watch',),
    );
  }
}

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
    Timer? _timer;
    int _countedSeconds=0;
    Duration timedDuration=Duration.zero;
    bool _timerRunning=false;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void startTimer(){
      _timerRunning=true;
      _timer?.cancel();
      _countedSeconds=0;
      _timer=Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _countedSeconds++;
          //print(_countedSeconds);
          timedDuration=Duration(seconds: _countedSeconds);
        });
      });
  }
    void stopTimer() { // stop the timer
      _timerRunning = false; // set the state of the timer running to false
      _timer?.cancel(); // cancel the running timer, so the callback stops firing
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(90.0),
                child: AspectRatio(
                  child: CircularProgressIndicator(
                    // backgroundColor: Colors.black,
                    strokeWidth: 15,
                    // Below, we work out the progress for the circular progress indicator
                    // We do so by getting the total amount of seconds so far, and then
                    // we use the .remainder function to get only the seconds component of the
                    // current minute being counted. We then divide it by 60 to work out how far
                    // through the progress should be (so, 30 would be 0.5, or 50% of a minute)
                    value: _countedSeconds.remainder(60) / 60,
                    color: Colors.black,
                  ),
                  aspectRatio: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timedDuration.inMinutes.toString(),
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontWeight: FontWeight.w300, color: Colors.blue
                    ),
                  ),
                  Text(
                    ":",
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.red),

                  ),
                  Text(
                    timedDuration.inSeconds.remainder(60).toString().padLeft(2, '0'),
                    style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.deepPurple),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_timerRunning) {
              setState(() {
                stopTimer();
              });
            } else {
              setState(() {
                startTimer();
              });
            }
          },
          // onPressed: _incrementCounter,
          child: Icon(_timerRunning ? Icons.pause : Icons.play_arrow),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );

  }


}
