import 'package:flutter/material.dart';
import 'package:flutter_module/texture/image_texture.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? pageId;
  String? url;

  @override
  void initState() {
    ModuleChannel moduleChannel = ModuleChannel();
    moduleChannel.registerMethod((call) async {
      switch (call.method) {
        case "init":
          pageId = call.arguments["pageId"];
          url = call.arguments["url"];
          break;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pageId == null
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
          )
        : Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.green,
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: ImageTexture(
                  pageId: pageId,
                  url: url,
                ),
              ),
            ),
          );
  }
}
