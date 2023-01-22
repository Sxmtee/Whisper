import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whisper/Common/Enums/message_enum.dart';
import 'package:whisper/Common/Widgets/chatWidgets/video_player_item.dart';

class DisplayMessageType extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayMessageType(
      {super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(videoUrl: message)
            : type == MessageEnum.gif
                ? CachedNetworkImage(imageUrl: message)
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  }
}
