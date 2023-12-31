// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyAaecTT9Ey4NYjhnUJxHMrZlDE6eRc7u3w',
    appId: '1:871037032513:web:827fffd534c3fae0190ec0',
    messagingSenderId: '871037032513',
    projectId: 'cognitivestudio-3119e',
    authDomain: 'cognitivestudio-3119e.firebaseapp.com',
    databaseURL: 'https://cognitivestudio-3119e-default-rtdb.firebaseio.com',
    storageBucket: 'cognitivestudio-3119e.appspot.com',
    measurementId: 'G-LM0G1ELRZV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVaoaC6HwTCO8KJWa7PS7x-33i_TURpyQ',
    appId: '1:871037032513:android:4a32ac6030dfe118190ec0',
    messagingSenderId: '871037032513',
    projectId: 'cognitivestudio-3119e',
    databaseURL: 'https://cognitivestudio-3119e-default-rtdb.firebaseio.com',
    storageBucket: 'cognitivestudio-3119e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLC6wFlyJv_QGjbOsFw5NcUtL3inEzeo8',
    appId: '1:871037032513:ios:7a5cc977ebea7402190ec0',
    messagingSenderId: '871037032513',
    projectId: 'cognitivestudio-3119e',
    databaseURL: 'https://cognitivestudio-3119e-default-rtdb.firebaseio.com',
    storageBucket: 'cognitivestudio-3119e.appspot.com',
    iosClientId: '871037032513-cq3bmejv12c5211ibc1ts0og9nn82mqp.apps.googleusercontent.com',
    iosBundleId: 'com.example.cognitivestudio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLC6wFlyJv_QGjbOsFw5NcUtL3inEzeo8',
    appId: '1:871037032513:ios:9035377a059708e0190ec0',
    messagingSenderId: '871037032513',
    projectId: 'cognitivestudio-3119e',
    databaseURL: 'https://cognitivestudio-3119e-default-rtdb.firebaseio.com',
    storageBucket: 'cognitivestudio-3119e.appspot.com',
    iosClientId: '871037032513-4e2ljb3ob2ani705am3t87vjh892dq1u.apps.googleusercontent.com',
    iosBundleId: 'com.example.cognitivestudio.RunnerTests',
  );
}
