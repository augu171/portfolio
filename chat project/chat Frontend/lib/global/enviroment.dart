import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid
      ? 'https://flutter-chat-backend-a60hm3srd-tolabaaugusto-gmailcom.vercel.app/api'
      : 'https://flutter-chat-backend-a60hm3srd-tolabaaugusto-gmailcom.vercel.app/api';
  static String socketUrl = Platform.isAndroid
      ? 'https://flutter-chat-backend-a60hm3srd-tolabaaugusto-gmailcom.vercel.app'
      : 'https://flutter-chat-backend-a60hm3srd-tolabaaugusto-gmailcom.vercel.app';
  // static String apiUrl = Platform.isAndroid
  //     ? 'http://10.0.2.2:3000/api'
  //     : 'http://10.0.2.2:3000/api';
  // static String socketUrl =
  //     Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://10.0.2.2:3000';
}
