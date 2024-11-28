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
    apiKey: 'AIzaSyDZ4xT5fUVMjsUa1PHqRxxEsd3cpHrQQqk',
    appId: '1:715264276621:web:1519b74d53a3a237accac4',
    messagingSenderId: '715264276621',
    projectId: 'motopeekproject',
    authDomain: 'motopeekproject.firebaseapp.com',
    storageBucket: 'motopeekproject.firebasestorage.app',
    measurementId: 'G-J0F2NR1CK7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBX1muCJ8ouZjjSqSpLtXIPnJB3v-U_O7w',
    appId: '1:715264276621:android:9a307479ec801354accac4',
    messagingSenderId: '715264276621',
    projectId: 'motopeekproject',
    storageBucket: 'motopeekproject.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN5loY6DlEDnzAj50hdnntgOZ0mgQNNGs',
    appId: '1:715264276621:ios:591729f45a6520c5accac4',
    messagingSenderId: '715264276621',
    projectId: 'motopeekproject',
    storageBucket: 'motopeekproject.firebasestorage.app',
    iosBundleId: 'com.example.capston',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDN5loY6DlEDnzAj50hdnntgOZ0mgQNNGs',
    appId: '1:715264276621:ios:591729f45a6520c5accac4',
    messagingSenderId: '715264276621',
    projectId: 'motopeekproject',
    storageBucket: 'motopeekproject.firebasestorage.app',
    iosBundleId: 'com.example.capston',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDZ4xT5fUVMjsUa1PHqRxxEsd3cpHrQQqk',
    appId: '1:715264276621:web:23c0af63a8759c96accac4',
    messagingSenderId: '715264276621',
    projectId: 'motopeekproject',
    authDomain: 'motopeekproject.firebaseapp.com',
    storageBucket: 'motopeekproject.firebasestorage.app',
    measurementId: 'G-NEC41FH49H',
  );
}