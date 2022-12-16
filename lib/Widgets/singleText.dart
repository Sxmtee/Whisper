import 'package:flutter/material.dart';
import 'package:whisper/Utils/colors.dart';

class SingleText extends StatelessWidget {
  // const SingleText({super.key});
  final String message;
  final bool isMe;
  SingleText({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minWidth: 200),
          // alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              color: isMe ? AppColors.primaryColor : Colors.blueGrey,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 50),
            child: Text(
              message,
              style:
                  const TextStyle(color: Colors.white, fontFamily: "Poppins"),
            ),
          ),
        )
      ],
    );
  }
}
