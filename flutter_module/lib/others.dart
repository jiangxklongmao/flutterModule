import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_module/texture/image_texture.dart';

@pragma('vm:entry-point')
void others() {
  runApp(OthersApp());
}

class OthersApp extends StatefulWidget {
  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<OthersApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Others"),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                color: Colors.orangeAccent),
            child: Text(
              "others.dart -> others()",
              style: TextStyle(color: Colors.red, fontSize: 30),
            ),
          )),
    );
  }
}
