import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Gallery extends StatefulWidget {
  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WebView(
          initialUrl: 'https://mega.nz/embed/N1tGhCTJ#gu8owBJMUL0a6YdeOJNqnDIJHA0vsVgPcxbPiX7-sPo',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
