import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void NavigateToPage(BuildContext context, Widget child) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rotate,
          alignment: Alignment.center,
          duration: const Duration(seconds: 1),
          child: child));
}