import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    // if (Platform.isIOS) {
    //   // iOS and MacOS
    //   return const FirebaseOptions(
    //     appId: '',
    //     apiKey: '',
    //     projectId: '',
    //     messagingSenderId: '',
    //     iosBundleId: '',
    //   );
    // } else {
    // Android
    return const FirebaseOptions(
      appId: '1:670958068251:android:ffafe193825544e1f50ebe',
      apiKey: 'AIzaSyDrHK4NDGaIcXMuxsRgL2vlqrUMZClbCEk',
      projectId: 'samay-be95f',
      messagingSenderId: '670958068251	',
    );
    // }
  }
}
