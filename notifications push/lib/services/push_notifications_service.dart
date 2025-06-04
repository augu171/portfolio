import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// SHA1: F3:76:7E:FA:6E:9E:C2:F5:4E:EC:D1:A1:D2:29:9B:AF:70:02:B0:23

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream =
      StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print('background Handler ${message.messageId}');

    _messageStream.add(
        message.data['product'] + ' ' + message.data['alago'] ?? 'No data');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // print('onMessage Handler ${message.messageId}');
    // print(message.data);
    _messageStream.add(
        message.data['product'] + ' ' + message.data['alago'] ?? 'No data');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp Handler ${message.messageId}');
    _messageStream.add(
        message.data['product'] + ' ' + message.data['alago'] ?? 'No data');
  }

  static Future initializeApp() async {
    // push notification

    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // local notification
  }

  static closeStreams() {
    _messageStream.close();
  }
}
