class GroupModel {
  final String name;
  final String senderId;
  final String groupId;
  final String lastMessage;
  final String groupPic;
  final List<String> membersUid;

  GroupModel(
      {required this.name,
      required this.senderId,
      required this.groupPic,
      required this.lastMessage,
      required this.membersUid,
      required this.groupId});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "senderId": senderId,
      "lastMessage": lastMessage,
      "groupPic": groupPic,
      "membersUid": membersUid,
      "groupId": groupId,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      name: map["name"] ?? "",
      senderId: map["senderId"] ?? "",
      lastMessage: map["lastMessage"] ?? "",
      groupPic: map["groupPic"] ?? "",
      membersUid: List<String>.from(map["membersUid"]),
      groupId: map["groupId"] ?? "",
    );
  }
}
