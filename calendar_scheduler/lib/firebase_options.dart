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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3NaDyJrZ9nDFjXz_RaFsH3dPObCPyX-U',
    appId: '1:834919745048:android:3ecc5ac9903c1aa88c656d',
    messagingSenderId: '834919745048',
    projectId: 'innate-watch-425605-r9',
    storageBucket: 'innate-watch-425605-r9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEKq1I_wzDJOTxa3AmigR26OLpdHDSKR0',
    appId: '1:834919745048:ios:90c20b8b7dc0d7838c656d',
    messagingSenderId: '834919745048',
    projectId: 'innate-watch-425605-r9',
    storageBucket: 'innate-watch-425605-r9.appspot.com',
    iosClientId: '834919745048-lbioc7aae3fr8lfibknt437ppqhs9d6r.apps.googleusercontent.com',
    iosBundleId: 'com.example.calendarScheduler',
  );

}