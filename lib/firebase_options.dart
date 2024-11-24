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
    apiKey: 'AIzaSyAf5efieu9-ObYIe7cVC0gRWWlqDNk6Lew',
    appId: '1:183110709275:web:05954e44e969d8f8f088be',
    messagingSenderId: '183110709275',
    projectId: 'authtutorial-2222b',
    authDomain: 'authtutorial-2222b.firebaseapp.com',
    storageBucket: 'authtutorial-2222b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOcRRM8zhQybq1MHjKvLu9P42LnxxAxnY',
    appId: '1:183110709275:android:edfd5b4a4283d224f088be',
    messagingSenderId: '183110709275',
    projectId: 'authtutorial-2222b',
    storageBucket: 'authtutorial-2222b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0i5kLkG8f8Ldf2iXb12fvmVisC8KABr8',
    appId: '1:183110709275:ios:6b1e4324ce324c46f088be',
    messagingSenderId: '183110709275',
    projectId: 'authtutorial-2222b',
    storageBucket: 'authtutorial-2222b.firebasestorage.app',
    iosBundleId: 'com.example.pokemon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0i5kLkG8f8Ldf2iXb12fvmVisC8KABr8',
    appId: '1:183110709275:ios:6b1e4324ce324c46f088be',
    messagingSenderId: '183110709275',
    projectId: 'authtutorial-2222b',
    storageBucket: 'authtutorial-2222b.firebasestorage.app',
    iosBundleId: 'com.example.pokemon',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAf5efieu9-ObYIe7cVC0gRWWlqDNk6Lew',
    appId: '1:183110709275:web:e6ea86a7a6a48e85f088be',
    messagingSenderId: '183110709275',
    projectId: 'authtutorial-2222b',
    authDomain: 'authtutorial-2222b.firebaseapp.com',
    storageBucket: 'authtutorial-2222b.firebasestorage.app',
  );
}
