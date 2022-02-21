import 'package:flutter/material.dart';

class S1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Section2"),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Text("Section 0"),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "0",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
