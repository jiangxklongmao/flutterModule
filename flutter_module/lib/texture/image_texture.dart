import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///    author : jiangxk
///    e-mail : jxklongmao@gmai.com
///    date   : 7/11/21 18:15
///    desc   :
///    version: 1.0

class ImageTexture extends StatefulWidget {
  final String? url;
  final String? pageId;

  ImageTexture({this.pageId, this.url});

  @override
  _ImageTextureState createState() => _ImageTextureState();
}

class _ImageTextureState extends State<ImageTexture> {
  int textureId = -1;
  String? url;
  String? pageId;

  @override
  void initState() {
    url = widget.url;
    pageId = widget.pageId;
    getData();
    super.initState();
  }

  void getData() async {
    if (url == null) {
      textureId = -1;
    } else {
      textureId = await TextureManager().getTextureId(
        pageId,
        url,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // return RepaintBoundary(
    //     child: textureId == -1
    //         ? Container(
    //             width: 100,
    //             height: 100,
    //             color: Colors.pink,
    //           )
    //         : Texture(
    //             textureId: textureId,
    //           ));
    return textureId == -1
        ? Container(
            width: 200,
            height: 200,
            color: Colors.pink,
          )
        : SizedBox(
            width: 200,
            height: 200,
            child: Texture(
              textureId: textureId,
            ),
          );
  }
}

class TextureManager {
  ModuleChannel _channel = ModuleChannel();

  factory TextureManager() => _getInstance();

  static TextureManager get instance => _getInstance();

  TextureManager._internal();

  static TextureManager _getInstance() {
    return TextureManager._internal();
  }

  Future<int> getTextureId(String? pageId, String? url) async {
    if (pageId == null || pageId.isEmpty || url == null || url.isEmpty) {
      return -1;
    }

    return await _channel.getImageTextureIdByUrl(pageId, url);
  }
}

class ModuleChannel {
  MethodChannel _channel = MethodChannel("demo_channel");
  List<Future<dynamic> Function(MethodCall call)> methodList = [];

  Future<dynamic> handleMassage(MethodCall call) async {
    methodList.forEach((element) {
      element.call(call);
    });
  }

  void registerMethod(Future<dynamic> Function(MethodCall call) method) {
    methodList.add(method);
    if (!_channel.checkMethodCallHandler(handleMassage)) {
      _channel.setMethodCallHandler(handleMassage);
    }
  }

  Future<int> getImageTextureIdByUrl(String pageId, String url) async {
    return await _channel.invokeMethod("getTexture", {
      'pageId': pageId,
      'url': url,
    });
  }

  void openFlutterPage(String pageId) async {
    return await _channel.invokeMethod("openFlutterPage", {
      'pageId': pageId,
    });
  }
}
