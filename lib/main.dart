import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stub_window/remote_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StubWindow',
      home: StreamBuilder(
        stream: RemoteConfigSettings.remoteConfig.onConfigUpdated,
        builder: (BuildContext context,AsyncSnapshot<RemoteConfig> snapshot){
          if(snapshot.hasData){
            final brand = 'google';
            final shouldUseStab = RemoteConfigService().shouldUseStub(brand);

            if(shouldUseStab){
              return Center(child: Text('Should use Implementation'),)
            } else {
              final url = snapshot.data.getString('url');
              return WebViewWidget(controller: controller)
            }
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
