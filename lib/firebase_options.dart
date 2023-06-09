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
    apiKey: 'AIzaSyA9a7DHuz-aWfjr9n7ckCcpU0wlRUw1x6Y',
    appId: '1:833046224436:web:a2bf49b8af0fadf4fbf461',
    messagingSenderId: '833046224436',
    projectId: 'tiktok-rp0k',
    authDomain: 'tiktok-rp0k.firebaseapp.com',
    storageBucket: 'tiktok-rp0k.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6IL7w1FqGBUzgBiSjbdr23a7TnE3ECc8',
    appId: '1:833046224436:android:078470b8746cb497fbf461',
    messagingSenderId: '833046224436',
    projectId: 'tiktok-rp0k',
    storageBucket: 'tiktok-rp0k.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOAy5OPOEYkpOWCddWTdYdYFflmkx_CP8',
    appId: '1:833046224436:ios:44185a2bb9b236f3fbf461',
    messagingSenderId: '833046224436',
    projectId: 'tiktok-rp0k',
    storageBucket: 'tiktok-rp0k.appspot.com',
    iosClientId: '833046224436-dj8k75p0690a4o7nqhuv2p31btpsg86s.apps.googleusercontent.com',
    iosBundleId: 'com.mochafreddo.tiktokClone',
  );
}
