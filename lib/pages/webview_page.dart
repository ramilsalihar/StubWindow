import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String url;

  WebviewPage({required this.url});

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
        },
        onPageFinished: (String url) {
          _updateUrl();
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url == widget.url) {
            return NavigationDecision.navigate;
          } else {
            _updateUrl();
            return NavigationDecision.prevent;
          }
        },
      ),
    );
  }

  Future<void> _updateUrl() async {
    String currentUrl = await _webViewController.currentUrl();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedLink', currentUrl);
  }
}
