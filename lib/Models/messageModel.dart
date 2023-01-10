import 'package:whisper/Common/Enums/message_enum.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  MessageModel(
      {required this.senderId,
      required this.receiverId,
      required this.text,
      required this.type,
      required this.timeSent,
      required this.messageId,
      required this.isSeen});

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "type": type.type,
      "timeSent": timeSent.millisecondsSinceEpoch,
      "messageId": messageId,
      "isSeen": isSeen
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map["senderId"],
      receiverId: map["receiverId"],
      text: map["text"],
      type: (map["type"] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map["timeSent"]),
      messageId: map["messageId"],
      isSeen: map["isSeen"],
    );
  }
}
