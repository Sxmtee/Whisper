import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(10),
          constraints: BoxConstraints(minWidth: 200),
          decoration: BoxDecoration(
              color: isMe ? Colors.teal : Colors.brown,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
