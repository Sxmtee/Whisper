import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:whisper/Common/Enums/message_enum.dart';
import 'package:whisper/Features/Chat/repo/message_reply_provider.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Common/Widgets/generalWidgets/error_screen.dart';
import 'package:whisper/Features/Chat/controller/chat_controller.dart';
import 'package:whisper/Features/Chat/widgets/my_message_card.dart';
import 'package:whisper/Features/Chat/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;
  final bool isGroupChat;
  const ChatList({
    Key? key,
    required this.receiverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message,
            isMe,
            messageEnum,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.isGroupChat
          ? ref
              .read(chatControllerProvider)
              .groupChatStream(widget.receiverUserId)
          : ref
              .read(chatControllerProvider)
              .getChatStream(widget.receiverUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader(
            radius: 60,
            color: AppColors.primaryColor,
          );
        }
        if (snapshot.hasError) {
          return ErrorScreen(error: snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return Center(
            child: SvgPicture.asset(
              "assets/icons/whisper4a.svg",
              color: AppColors.primaryColor,
              height: 340,
              width: 340,
            ),
          );
        }

        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageController.jumpTo(messageController.position.maxScrollExtent);
        });

        return ListView.builder(
          controller: messageController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final messageData = snapshot.data![index];
            final timeSent = DateFormat.Hm().format(messageData.timeSent);

            if (!messageData.isSeen &&
                messageData.receiverId ==
                    FirebaseAuth.instance.currentUser!.uid) {
              ref.read(chatControllerProvider).setChatMessageSeen(
                    context,
                    widget.receiverUserId,
                    messageData.messageId,
                  );
            }
            if (messageData.senderId ==
                FirebaseAuth.instance.currentUser!.uid) {
              return MyMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                onLeftSwipe: () {
                  onMessageSwipe(
                    messageData.text,
                    true,
                    messageData.type,
                  );
                },
                repliedMessageType: messageData.repliedMessageType,
                repliedText: messageData.repliedMessage,
                username: messageData.repliedTo,
                isSeen: messageData.isSeen,
              );
            }
            return SenderMessageCard(
              message: messageData.text,
              date: timeSent,
              type: messageData.type,
              onRightSwipe: () {
                onMessageSwipe(
                  messageData.text,
                  false,
                  messageData.type,
                );
              },
              repliedMessageType: messageData.repliedMessageType,
              repliedText: messageData.repliedMessage,
              username: messageData.repliedTo,
            );
          },
        );
      },
    );
  }
}
