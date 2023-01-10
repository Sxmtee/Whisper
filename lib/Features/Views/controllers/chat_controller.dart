import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            context: context,
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!));
  }
}
