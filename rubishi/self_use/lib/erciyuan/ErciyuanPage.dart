import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Live2dPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Live2dPageState();

}

class Live2dPageState extends State<Live2dPage> with SingleTickerProviderStateMixin {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  String text = "asdad";
  bool showText = true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: (){

          },
        ),
      ),
      body: GestureDetector(
        onTap: (){
            showText = !showText;
            setState(() {
              if(showText == false)
              text = "早上好";
            });
        },
        child: Container(
          decoration: BoxDecoration(
             gradient: LinearGradient(
                  colors: [
                    Color(0xFF2C7EDF),
                    Color(0xFFA6CFFF),
                    // 用来挡下面圆角左右的空
                    Colors.white
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // 在0.7停止同理
                  stops: [0, 0.53, 0.7])
          ),
          child: Column(
            children: [
              Container(
                height: 60,
                margin: EdgeInsets.only(left: 30, top: 10),
                alignment: Alignment.centerLeft,
                child: AnimatedDefaultTextStyle(
                  style: showText
                      ? TextStyle(fontSize: 22,color: Colors.white)
                      : TextStyle(fontSize: 22,color: Colors.black),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                  child: SizedBox(
                    width: 320,
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    child: WebView(
                      initialUrl: "https://xdh13.gitee.io/live2d/",
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
                      onProgress: (int progress) {
                        print('WebView is loading (progress : $progress%)');
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: false,
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    width: 20,
                    height: 20,
                  )
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

}