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
  late ModuleChannel moduleChannel;

  @override
  void initState() {
    moduleChannel = ModuleChannel();
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: pageId == null
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.green,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: ImageTexture(
                        pageId: pageId,
                        url: url,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        moduleChannel.openFlutterPage(pageId ?? "");
                      },
                      child: Text(
                        "Open Flutter Page",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
