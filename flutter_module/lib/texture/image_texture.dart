import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///    author : jiangxk
///    e-mail : jxklongmao@gmai.com
///    date   : 7/11/21 18:15
///    desc   :
///    version: 1.0

class ImageTexture extends StatefulWidget {
  final String? url;

  ImageTexture({this.url});

  @override
  _ImageTextureState createState() => _ImageTextureState();
}

class _ImageTextureState extends State<ImageTexture> {
  int textureId = -1;
  String? url;

  @override
  void initState() {
    url = widget.url;
    getData();
    super.initState();
  }

  void getData() async {
    if (url == null) {
      textureId = -1;
    } else {
      textureId = await TextureManager().getTextureId(url);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child: textureId == -1
            ? Container(
                width: 100,
                height: 100,
                color: Colors.pink,
              )
            : Texture(
                textureId: textureId,
              ));
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

  Future<int> getTextureId(String? url) async {
    if (url == null || url.isEmpty) {
      return -1;
    }

    return await _channel.getImageTextureIdByUrl(url);
  }
}

class ModuleChannel {
  MethodChannel _channel = const MethodChannel("demo_channel");

  Future<int> getImageTextureIdByUrl(String url) async {
    return await _channel.invokeMethod("getTexture", {'url': url});
  }
}
