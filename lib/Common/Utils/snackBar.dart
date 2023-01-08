import 'package:flutter/material.dart';
import 'package:whisper/Common/Utils/colors.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.primaryColor,
      shape: const StadiumBorder(),
      elevation: 10,
      duration: const Duration(seconds: 6),
      dismissDirection: DismissDirection.horizontal,
      content: Text(content)));
}
