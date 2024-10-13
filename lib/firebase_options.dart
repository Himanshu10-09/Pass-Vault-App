// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDrtulBtVXPHDPZP7hw_-Oi4uQkhHPBW7A',
    appId: '1:837486489823:web:007f3f0b0cdfcd9372796a',
    messagingSenderId: '837486489823',
    projectId: 'passvault-app-a66c3',
    authDomain: 'passvault-app-a66c3.firebaseapp.com',
    storageBucket: 'passvault-app-a66c3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrYoeyE9zXb7JxXAXqiphjxP0Vsi3vTc4',
    appId: '1:837486489823:android:6a9b0ab14177565072796a',
    messagingSenderId: '837486489823',
    projectId: 'passvault-app-a66c3',
    storageBucket: 'passvault-app-a66c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZs40_CtwSysrH_5NcIcjAkIX45gfdBKQ',
    appId: '1:837486489823:ios:f2ad057a796e564572796a',
    messagingSenderId: '837486489823',
    projectId: 'passvault-app-a66c3',
    storageBucket: 'passvault-app-a66c3.appspot.com',
    iosBundleId: 'com.example.passwordVaultApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZs40_CtwSysrH_5NcIcjAkIX45gfdBKQ',
    appId: '1:837486489823:ios:f2ad057a796e564572796a',
    messagingSenderId: '837486489823',
    projectId: 'passvault-app-a66c3',
    storageBucket: 'passvault-app-a66c3.appspot.com',
    iosBundleId: 'com.example.passwordVaultApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDrtulBtVXPHDPZP7hw_-Oi4uQkhHPBW7A',
    appId: '1:837486489823:web:a551007882a91b1072796a',
    messagingSenderId: '837486489823',
    projectId: 'passvault-app-a66c3',
    authDomain: 'passvault-app-a66c3.firebaseapp.com',
    storageBucket: 'passvault-app-a66c3.appspot.com',
  );
}
