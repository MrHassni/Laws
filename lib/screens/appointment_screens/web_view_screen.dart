import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:laws/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  final String appointmentId;
  final String userId;
  final String lawyerId;

  const WebViewScreen(
      {super.key, required this.appointmentId, required this.userId, required this.lawyerId});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {

  int load = 0;
  late InAppWebViewController _webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(
                        'https://immig-assist.co.uk/proceed-payment/${widget.appointmentId}/${widget.lawyerId}/${widget.userId}'),
                  ),
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialSettings: settings,
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, Uri? url) {
                    log(url.toString());
                  },
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                        );
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (InAppWebViewController controller, Uri? url) async {
                    log(url.toString());
                    if (url.toString() == 'https://immig-assist.co.uk/' ||
                        url.toString() == 'https://immig-assist.co.uk' ||
                        url.toString() == 'https://immig-assist.co.uk/thank-you' ||
                        url.toString() == 'https://immig-assist.co.uk/thank-you/') {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Appointment created successfully')));
                    }
                  },
                  onReceivedError: (controller, request, error) {
                    log(error.description);
                  },
                    onProgressChanged: (controller, progress){
                    setState(() {
                      load = progress;
                    });
                    log(progress.toString());
                    }

                ),
              ),
            ],
          ),
          load < 80 ?   Center(
            child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
                width: MediaQuery.sizeOf(context).width * 0.15,
                child: FittedBox(child: CircularProgressIndicator(color: kAppBrown,))),
          ) : const SizedBox() ,
        ],
      ),
    );
  }
}
