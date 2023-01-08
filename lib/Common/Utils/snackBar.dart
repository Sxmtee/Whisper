import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color(0xFFF77D8E),
      shape: const StadiumBorder(),
      elevation: 10,
      duration: const Duration(seconds: 6),
      dismissDirection: DismissDirection.horizontal,
      content: Text(content)));
}
