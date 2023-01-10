enum MessageEnum {
  text("text"),
  image("image"),
  audio("audio"),
  video("video"),
  gif("gif");

  const MessageEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case "text":
        return MessageEnum.text;
      case "image":
        return MessageEnum.image;
      case "audio":
        return MessageEnum.audio;
      case "video":
        return MessageEnum.video;
      case "gif":
        return MessageEnum.gif;
      default:
        return MessageEnum.text;
    }
  }
}
