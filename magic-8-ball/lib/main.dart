import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
          home: Scaffold(
        backgroundColor: Colors.blue.shade300,
        appBar: AppBar(
          title: Text('Ask me anything'),
          backgroundColor: Colors.blue.shade900,
        ),
        body: BallPage(),
      )),
    );

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Ball();
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  int ballNumber = 1;

  void changeBall() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1; // 1 - 5
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                onPressed: () {
                  print('I got clicked');
                  setState(() {
                    changeBall();
                  });
                },
                child: Image.asset('images/ball$ballNumber.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
