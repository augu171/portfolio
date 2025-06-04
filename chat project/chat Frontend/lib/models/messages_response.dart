// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    required this.ok,
    required this.last30,
  });

  bool ok;
  List<Last30> last30;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        ok: json["ok"],
        last30:
            List<Last30>.from(json["last30"].map((x) => Last30.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "last30": List<dynamic>.from(last30.map((x) => x.toJson())),
      };
}

class Last30 {
  Last30({
    required this.from,
    required this.to,
    required this.msg,
    required this.createdAt,
    required this.updatedAt,
  });

  String from;
  String to;
  String msg;
  DateTime createdAt;
  DateTime updatedAt;

  factory Last30.fromJson(Map<String, dynamic> json) => Last30(
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
