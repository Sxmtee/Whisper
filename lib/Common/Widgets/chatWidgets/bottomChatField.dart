import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Enums/message_enum.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/pickfile.dart';
import 'package:whisper/Features/Views/controllers/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  const BottomChatField({
    Key? key,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  void sendTextMessage() {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
          context, _messageController.text.trim(), widget.receiverUserId);
    }
    setState(() {
      _messageController.text = "";
    });
  }

  void sendFileMessage(File file, MessageEnum messageEnum) {
    ref
        .read(chatControllerProvider)
        .sendFileMessage(context, file, widget.receiverUserId, messageEnum);
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      // ignore: use_build_context_synchronously
      ref
          .read(chatControllerProvider)
          .sendGIFMessage(context, gif.url, widget.receiverUserId);
    }
  }

  void hideEmojiCharacter() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiCharacter() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() {
    focusNode.requestFocus();
  }

  void hideKeyboard() {
    focusNode.unfocus();
  }

  void toggleEmojiKeyboard() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiCharacter();
    } else {
      hideKeyboard();
      showEmojiCharacter();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.mobileChatBoxColor,
                  prefixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: toggleEmojiKeyboard,
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        IconButton(
                          onPressed: selectVideo,
                          icon: const Icon(
                            Icons.attach_file,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Whisper!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, right: 2.0, left: 2.0),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 25,
                child: GestureDetector(
                  onTap: () {
                    sendTextMessage();
                  },
                  child: Icon(
                    isShowSendButton ? Icons.send : Icons.mic,
                    color: AppColors.backgroundColorLight,
                  ),
                ),
              ),
            )
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });

                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  },
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
