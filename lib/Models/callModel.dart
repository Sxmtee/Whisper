class CallModel {
  final String callerId;
  final String callerName;
  final String callerPic;
  final String receiverId;
  final String receiverName;
  final String receiverPic;
  final String callId;
  final bool hasDialled;

  CallModel({
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
    required this.callId,
    required this.hasDialled,
  });

  Map<String, dynamic> toMap() {
    return {
      "callerId": callId,
      "callerName": callerName,
      "callerPic": callerPic,
      "receiverId": receiverId,
      "receiverName": receiverName,
      "receiverPic": receiverPic,
      "callId": callId,
      "hasDialled": hasDialled,
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      callerId: map["callerId"] ?? "",
      callerName: map["callerName"] ?? "",
      callerPic: map["callerPic"] ?? "",
      receiverId: map["receiverId"] ?? "",
      receiverName: map["receiverName"] ?? "",
      receiverPic: map["receiverPic"] ?? "",
      callId: map["callId"] ?? "",
      hasDialled: map["hasDialled"] ?? "",
    );
  }
}
