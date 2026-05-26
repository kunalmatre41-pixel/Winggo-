import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WinggoApp(),
  ));
}

class WinggoApp extends StatefulWidget {
  const WinggoApp({Key? key}) : super(key: key);
  @override
  State<WinggoApp> createState() => _WinggoAppState();
}

class _WinggoAppState extends State<WinggoApp> {
  InAppWebViewController? _controller;
  bool _showLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller != null && await _controller!.canGoBack()) {
          _controller!.goBack(); // Back button se app band nahi hoga, game back hoga
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0F),
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri("https://winggo.netlify.app/")),
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  domStorageEnabled: true, // Login session save rakhne ke liye
                  supportZoom: false,
                ),
                onWebViewCreated: (ctr) => _controller = ctr,
                onLoadStop: (ctr, url) => setState(() => _showLoading = false),
              ),
              if (_showLoading)
                Container(
                  color: const Color(0xFF0A0A0F),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFD700)), // Gold Spinner
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
