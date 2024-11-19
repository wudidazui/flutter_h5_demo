import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5LoginInfo = '''
  <!DOCTYPE html>
  <html lang="zh">
      <head>
          <meta charset="utf-8">
          <title>flutter通过channel的方式将登录态同步给h5</title>
  
      </head> 
      <body>
          <button id="btn" style="font-size: 2.5em;">获取登录信息</button>
          <div id="resultTxt" style="font-size: 2.5em;">这里展示flutter传递过来的数据</div>
           <script type="text/javascript">
             var btn = document.getElementById("btn");
             btn.addEventListener("click",function(){
                getLoginInfo.postMessage("");
             },false)
             function hiCallJs(msg){
                document.getElementById("resultTxt").innerHTML = "flutter传递过来的数据：" + msg;
             }
          </script>
      </body>
  </html>
''';

class FlutterH5LoginChannel extends StatefulWidget {
  const FlutterH5LoginChannel({super.key});

  @override
  State<FlutterH5LoginChannel> createState() => _FlutterH5LoginChannelState();
}

class _FlutterH5LoginChannelState extends State<FlutterH5LoginChannel> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: () {
        controller.loadHtmlString(h5LoginInfo);
      },
      child: Text(
        "加载h5",
        style: TextStyle(color: Colors.white),
      ));

  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      //开启js执行
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel("getLoginInfo",
          onMessageReceived: (JavaScriptMessage message) {
        var info = {"token": "111111", "uid": "2222222"};
        var infoString = json.encode(info);
        controller.runJavaScript("hiCallJs('$infoString')");
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter通过channel的方式将登录态同步给h5"),
        actions: [_loadBtn],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
