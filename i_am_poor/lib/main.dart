import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: Text('BOSZONE'),
          backgroundColor: Colors.green[900],
        ),
        body: Center(
          child: Image (
            image: AssetImage('images/BOSZONE_LOGO_270x50.png'),
          ),
        ),
      ),
    )
  );
}


