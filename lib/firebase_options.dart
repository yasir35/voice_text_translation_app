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
    apiKey: 'AIzaSyCbaOAe9bNlXxPtJVSH3bgY8cauVg_5f_M',
    appId: '1:196392488329:web:f7541076037db3331fa558',
    messagingSenderId: '196392488329',
    projectId: 'voice-and-text-translati-4665c',
    authDomain: 'voice-and-text-translati-4665c.firebaseapp.com',
    storageBucket: 'voice-and-text-translati-4665c.appspot.com',
    measurementId: 'G-E4N208D6PT',
    databaseURL:
        'https://voice-and-text-translati-4665c-default-rtdb.firebaseio.com/',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzenJx8yLQ1dQY5JvQoM6MgcfOrOPH0hg',
    appId: '1:196392488329:android:e103fb35ada166f61fa558',
    messagingSenderId: '196392488329',
    projectId: 'voice-and-text-translati-4665c',
    storageBucket: 'voice-and-text-translati-4665c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByqvwfzKw0ELkoeQZvFqAPL7ob607V6F8',
    appId: '1:196392488329:ios:e946ec38bdf14bbc1fa558',
    messagingSenderId: '196392488329',
    projectId: 'voice-and-text-translati-4665c',
    storageBucket: 'voice-and-text-translati-4665c.appspot.com',
    iosBundleId: 'com.example.voiceTextTranslationApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByqvwfzKw0ELkoeQZvFqAPL7ob607V6F8',
    appId: '1:196392488329:ios:01860dd2ba0261101fa558',
    messagingSenderId: '196392488329',
    projectId: 'voice-and-text-translati-4665c',
    storageBucket: 'voice-and-text-translati-4665c.appspot.com',
    iosBundleId: 'com.example.voiceTextTranslationApp.RunnerTests',
  );
}
