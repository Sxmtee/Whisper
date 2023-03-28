import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Features/Chat/repo/message_reply_provider.dart';
import 'package:whisper/Features/Chat/widgets/display_message_type.dart';

class ReplyPreview extends ConsumerWidget {
  const ReplyPreview({super.key});

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                messageReply!.isMe ? "Me" : "Opposite",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              GestureDetector(
                onTap: () {
                  cancelReply(ref);
                },
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          DisplayMessageType(
              message: messageReply.message, type: messageReply.messageEnum)
        ],
      ),
    );
  }
}
