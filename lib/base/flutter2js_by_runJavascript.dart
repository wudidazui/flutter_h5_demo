import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5Flutter2JsByRunJavascript = '''
<!DOCTYPE html>
<html lang="zh">
    <head>
        <meta charset="utf-8">
        <title>flutter向H5传递数据-通过runJavaScript</title>
        <script type="text/javascript">
           function hiCallJs(msg){
              document.getElementById("resultText").innerHTML = "flutter传递过来的数据：" + msg;
           }
           function hiCallJsWithResult(v1,v2){
              return parseInt(v1) + parseInt(v2);
           }
        </script>
    </head> 
    <body>
        <button id="resultText" style="font-size: 2.5em;">这里展示flutter传递过来的数据</button>
    </body>
</html>
''';

class Flutter2JsByRunJavascript extends StatefulWidget {
  const Flutter2JsByRunJavascript({super.key});

  @override
  State<Flutter2JsByRunJavascript> createState() =>
      _Flutter2JsByRunJavascriptState();
}

class _Flutter2JsByRunJavascriptState extends State<Flutter2JsByRunJavascript> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: () {
        controller.loadHtmlString(h5Flutter2JsByRunJavascript);
      },
      child: Text(
        "加载h5",
        style: TextStyle(color: Colors.white),
      ));

  get _fireData => FilledButton(
      onPressed: () async {
        var name = "111";
        controller.runJavaScript("hiCallJs('$name')");
        var result = await controller
            .runJavaScriptReturningResult("hiCallJsWithResult(1,2)");
        debugPrint("来自js的计算结果: $result");
      },
      child: Text(
        "发送数据",
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
        title: Text("flutter向js传递数据"),
        actions: [_loadBtn, _fireData],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
