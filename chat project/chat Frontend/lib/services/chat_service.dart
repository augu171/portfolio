import 'dart:convert';
import 'dart:io';

import 'package:chat/models/messages_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/enviroment.dart';
import 'package:chat/models/user.dart';

class ChatService with ChangeNotifier {
  User? userTo;
  bool isSaving = false;
  File? newPictureFile;

  Future<List<Last30>> getChat(String userId) async {
    final resp = await http.get(
      Uri.parse('${Enviroment.apiUrl}/messages/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? ''
      },
    );
    print('id: $userId y token: ${await AuthService.getToken()}');

    final messagesResp = messagesResponseFromJson(resp.body);

    return messagesResp.last30;
  }

  Future<String> uploadImage(String image) async {
    isSaving = true;
    notifyListeners();
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dggj8up0v/image/upload?upload_preset=opdxulkj',
    );

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return '';
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }

  Future sendMessageNotification(User user) async {
    print('Ahora si manda');
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-type': 'application/json',
        'Authorization':
            'key=AAAALJWtCpw:APA91bEpqWSemZLFmdn-kNY3UdApyHcd2fDRL_9_oB23QDHltY0-8Y9RstPC77qGpUZbUDdNrGg2IrcBJPpNzHCO2ecsRYIrvwbh_sgdbH51qeJ7WUsxAnrNYjQtUKUhP9SXnnA0LdTM',
      },
      body: json.encode(
        {
          "notification": {
            "title": "Mensaje nuevo de: ",
            "body": "Alguien",
            "image":
                "https://beplic.com/wp-content/uploads/2021/06/abeja-ATENCION.png"
          },
          "priority": "high",
          "data": {
            "uid": user.uid,
            "name": user.name,
            "email": user.email,
            "online": false
          },
          "to":
              "fWnuDEvjRiqXyPOc7bBRge:APA91bEBQ9TGPnB9G_fkusV41HKlT1mhpACdiA5M7X2ta4AZMAirQfOnST6nwNksK2Zv_83c5kXgPhriX2gCefwQcWfgSKShQ1EsTAmzVh3g0HdKQFRz_XMw3S2binW3okAP54dRgQ3L"
        },
      ),
    );
  }
}
