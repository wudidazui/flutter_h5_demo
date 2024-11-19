import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5JS2FlutterByUrl = '''
<!DOCTYPE html>
<html lang="zh">
    <head>
        <meta charset="utf-8">
        <title>通过URL向flutter传递数据</title>
    </head>
    <body>
        <button id="btn" style="font-size: 2.5em;">传递参数</button>
        <script type="text/javascript">
            var btn = document.getElementById("btn");
            btn.addEventListener("click",function(){
                document.location = "hi://webview?name=1111";
            },false)
        </script>
    </body>
</html>
''';

class JS2FlutterByUrl extends StatefulWidget {
  const JS2FlutterByUrl({super.key});

  @override
  State<JS2FlutterByUrl> createState() => _JS2FlutterByUrlState();
}

class _JS2FlutterByUrlState extends State<JS2FlutterByUrl> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
      onPressed: () {
        controller.loadHtmlString(h5JS2FlutterByUrl);
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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(onNavigationRequest: (NavigationRequest request) {
        //约定一个通信协议 hi://webview
        if (request.url.startsWith("hi://webview")) {
          debugPrint("处理js通过Url传递过来的数据：$request");
          Uri uri = Uri.parse(request.url);
          var name = uri.queryParameters["name"];
          debugPrint("name:$name");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("name:$name")));
          return NavigationDecision.prevent; //不跳转
        }
        debugPrint("非hi://webview开头的url放行 $request");
        return NavigationDecision.navigate;
      }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("js向flutter传递数据"),
        actions: [_loadBtn],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
