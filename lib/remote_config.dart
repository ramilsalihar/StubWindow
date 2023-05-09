import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigSettings {
  static const String stubUrl = 'stub_url';

  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> setup() async {
    await remoteConfig.setDefaults(<String, dynamic>{
      stubUrl: '',
    });
    await remoteConfig.fetchAndActivate();
  }

  static String get stubUrlValue => remoteConfig.getString(stubUrl);
}
