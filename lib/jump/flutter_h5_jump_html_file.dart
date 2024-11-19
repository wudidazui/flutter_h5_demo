import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5String = '''
<!DOCTYPE html>
<html lang="zh">
    <head>
        <meta charset="utf-8">
        <title>通过URL向flutter传递数据</title>
    </head>
    <body>
        <button id="btn" style="font-size: 2.5em;">传递参数666</button>
        <script type="text/javascript">
            var btn = document.getElementById("btn");
            btn.addEventListener("click",function(){
                document.location = "hi://webview?name=1111";
            },false)
        </script>
    </body>
</html>
''';

class FlutterH5JumpHtmlFile extends StatefulWidget {
  const FlutterH5JumpHtmlFile({super.key});

  @override
  State<FlutterH5JumpHtmlFile> createState() => _FlutterH5JumpHtmlFileState();
}

class _FlutterH5JumpHtmlFileState extends State<FlutterH5JumpHtmlFile> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: () {
        _loadLoadFileExample(context);
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
        title: Text("loadFile的方式加载h5"),
        actions: [_loadBtn],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  _loadLoadFileExample(BuildContext context) async {
    final String path = await _prepareFile();
    debugPrint(path);
    await controller.loadFile(path);
  }

  _prepareFile() async {
    final tempDir = (await getTemporaryDirectory()).path;
    //创建文件
    final File file = File(
        <String>{tempDir, "hi", "index.html"}.join(Platform.pathSeparator));
    await file.create(recursive: true);
    //向文件写入H5 string数据
    await file.writeAsString(h5String);
    return file.path;
  }
}
