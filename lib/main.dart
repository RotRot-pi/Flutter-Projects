import 'package:flutter/material.dart';
import 'dart:async';
import 'package:timer/section%201.dart';

main() => runApp(MyApp());

String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes:$seconds";
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Section1': (context) => S1(),
        '/': (context) => MyHomePage(),
      },
      title: ("Chronometer"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  List _savedTime = [];
  var _stm;
  Stopwatch _stopwatch;
  Timer _timer;
  bool isSelected = true;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void handleStartStop() {
    _stopwatch.isRunning ? _stopwatch.stop() : _stopwatch.start();

    setState(() {});
  }

  void handleReset() {
    if (_stopwatch.isRunning) {
      _stopwatch.reset();
      _stopwatch.stop();
    }
    if (!_stopwatch.isRunning) {
      _stopwatch.reset();
      _stopwatch.stop();
    }
  }

  void handleSave() {
    setState(() {
      if (_stopwatch.isRunning) {
        _savedTime.contains(formatTime(_stopwatch.elapsedMilliseconds))
            ? null
            : _savedTime.add(formatTime(_stopwatch.elapsedMilliseconds));
        _stm = _savedTime.last;
      }
    });
  }

  Icon darkIcon = Icon(Icons.wb_incandescent_outlined);
  Icon lightIcon = Icon(Icons.wb_incandescent);

  Color p = Colors.deepPurpleAccent;
  Color r = Colors.redAccent;
  Color b = Colors.black;
  Color pk = Colors.pink.shade300;


  _onSelected(dynamic val) {
    setState(() => _savedTime.removeWhere((_stm) => _stm == val));
  }

  @override
  Widget build(BuildContext context) {  
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                r,
                p,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chronometer",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  // padding: EdgeInsets.only(left: 10, top: 7),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isSelected) {
                                      r = b;
                                      p = b;
                                      pk = b;
                                    }
                                    if (!isSelected) {
                                      r = Colors.redAccent;
                                      p = Colors.deepPurpleAccent;
                                      pk = Colors.pink.shade300;
                                    }
                      
                                    isSelected = !isSelected;
                                  });
                                },
                                child: isSelected ? darkIcon : lightIcon,
                              ),
                    ],
                    
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 180, height: 180),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Colors.white,
                          ),
                          onPressed: handleStartStop,
                          child: Text(
                            _stopwatch.isRunning ? 'Stop' : 'Run',
                            style: TextStyle(fontSize: 35, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  formatTime(_stopwatch.elapsedMilliseconds),
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // ignore: deprecated_member_use
                          TextButton(
                            onPressed: handleReset,
                            child: Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          TextButton(
                            onPressed: handleSave,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: ListView.builder(
                    itemCount: _savedTime.length,
                    shrinkWrap: true,
                    itemBuilder:(context,e){
                      var item = _savedTime[e];
                      return Column(
                        children: [
                          
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item,
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _onSelected(item)),
                                ],
                              )
                           
                        ],
                      ) ;
                    } ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
