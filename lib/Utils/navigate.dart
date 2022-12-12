import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void NavigateToPage(BuildContext context, Widget child) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rotate,
          duration: Duration(milliseconds: 500),
          child: child));
}
