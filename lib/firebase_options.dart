import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBPNsKWW4q5DAC7rBAIMvAmVUArIEeh864',
    appId: '1:34893350382:web:064dbc34ceea65310afaff',
    messagingSenderId: '34893350382',
    projectId: 'colibri-noticias-app',
    authDomain: 'colibri-noticias-app.firebaseapp.com',
    storageBucket: 'colibri-noticias-app.firebasestorage.app',
    measurementId: 'G-8ZJGCF51YE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPX4wqecoOymVvekzyKBUAeB-F4x54ri8',
    appId: '1:34893350382:android:1543f2958cf941bc0afaff',
    messagingSenderId: '34893350382',
    projectId: 'colibri-noticias-app',
    storageBucket: 'colibri-noticias-app.firebasestorage.app',
  );
}
