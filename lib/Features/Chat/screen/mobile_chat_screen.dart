import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Features/Auth/controllers/auth_controller.dart';
import 'package:whisper/Features/Chat/widgets/bottomChatField.dart';
import 'package:whisper/Features/Chat/widgets/chat_list.dart';
import 'package:whisper/Models/userModel.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  final String name;
  final String uid;
  const MobileChatScreen({Key? key, required this.name, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader(radius: 20, color: AppColors.appBarColor);
              }
              return Column(
                children: [
                  Text(name),
                  Text(
                    snapshot.data!.isOnline ? "confidant" : "snitch",
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  )
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              receiverUserId: uid,
            ),
          ),
          BottomChatField(
            receiverUserId: uid,
          ),
        ],
      ),
    );
  }
}
