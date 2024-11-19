import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterH5LoginCookie extends StatefulWidget {
  const FlutterH5LoginCookie({super.key});

  @override
  State<FlutterH5LoginCookie> createState() => _FlutterH5LoginCookieState();
}

class _FlutterH5LoginCookieState extends State<FlutterH5LoginCookie> {
  WebviewCookieManager cookieManager = WebviewCookieManager();

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

  get _setCookieBtn => FilledButton(
      onPressed: () async {
        _onSetCookie(context);
      },
      child: Text(
        "设置Cookie",
        style: TextStyle(color: Colors.white),
      ));

  get _clearCookieBtn => FilledButton(
      onPressed: () async {
        _onClearCookie(context);
      },
      child: Text(
        "清除Cookie",
        style: TextStyle(color: Colors.white),
      ));

  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      //开启js执行
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter通过cookie的方式将登录态同步给h5"),
        actions: [_loadBtn, _setCookieBtn, _clearCookieBtn],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

  void _onSetCookie(BuildContext context) async {
    await cookieManager.setCookies([
      Cookie('token', "1111")
        ..domain = "geekailab.com"
        ..expires = DateTime.now().add(Duration(days: 10))
        ..httpOnly = false
    ]);

    final Object cookies =
        await controller.runJavaScriptReturningResult("document.cookie");

    debugPrint(cookies.toString());
  }

  void _onClearCookie(BuildContext context) async {
    await cookieManager.clearCookies();
    debugPrint("清除成功");
  }
}
