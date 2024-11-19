import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterH5JumpAsset extends StatefulWidget {
  const FlutterH5JumpAsset({super.key});

  @override
  State<FlutterH5JumpAsset> createState() => _FlutterH5JumpAssetState();
}

class _FlutterH5JumpAssetState extends State<FlutterH5JumpAsset> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: () async {
        await controller.loadRequest(Uri.parse(
            "https://www.geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=111"));
      },
      child: Text(
        "加载h5",
        style: TextStyle(color: Colors.white),
      ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      //开启js执行
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("loadFlutterAssets的方式加载H5"),
        actions: [_loadBtn],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
