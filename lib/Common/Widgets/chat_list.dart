import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Common/Widgets/error_screen.dart';
import 'package:whisper/Common/Widgets/my_message_card.dart';
import 'package:whisper/Common/Widgets/sender_message_card.dart';
import 'package:whisper/Features/Views/controllers/chat_controller.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;
  const ChatList({
    Key? key,
    required this.receiverUserId,
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref
            .read(chatControllerProvider)
            .getChatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader(radius: 60, color: AppColors.primaryColor);
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
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              final timeSent = DateFormat.Hm().format(messageData.timeSent);
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
              );
            },
          );
        });
  }
}
