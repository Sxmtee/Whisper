import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Providers/message_reply_provider.dart';

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
          Text(messageReply.message)
        ],
      ),
    );
  }
}
