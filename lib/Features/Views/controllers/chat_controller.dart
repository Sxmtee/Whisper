import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Enums/message_enum.dart';
import 'package:whisper/Common/Providers/message_reply_provider.dart';
import 'package:whisper/Features/Auth/controllers/auth_controller.dart';
import 'package:whisper/Features/Views/repositories/chat_repo.dart';
import 'package:whisper/Models/chatcontactModel.dart';
import 'package:whisper/Models/messageModel.dart';

final chatControllerProvider = Provider(
  (ref) {
    final chatRepository = ref.watch(chatRepoProvider);
    return ChatController(chatRepository: chatRepository, ref: ref);
  },
);

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  Stream<List<ChatContactModel>> chatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<MessageModel>> getChatStream(String receiverUserId) {
    return chatRepository.getChatStream(receiverUserId);
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String receiverUserId,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            context: context,
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!,
            messageReply: messageReply));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage(BuildContext context, File file, String receiverUserId,
      MessageEnum messageEnum) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepository.sendFileMessage(
            context: context,
            file: file,
            receiverUserId: receiverUserId,
            senderUserData: value!,
            ref: ref,
            messageEnum: messageEnum,
            messageReply: messageReply));
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String receiverUserId,
  ) {
    final messageReply = ref.read(messageReplyProvider);
    int gifUrlPartIndex = gifUrl.lastIndexOf("_") + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newGifUrl = "https://i.giphy.com/media/$gifUrlPart/200.gif";

    ref.read(userDataAuthProvider).whenData((value) {
      chatRepository.sendGIFMessage(
          context: context,
          gifUrl: newGifUrl,
          receiverUserId: receiverUserId,
          senderUser: value!,
          messageReply: messageReply);
    });
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void setChatMessageSeen(
      BuildContext context, String receiverUserId, String messageId) {
    chatRepository.setChatMessageSeen(context, receiverUserId, messageId);
  }
}
