import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar profileAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: const Icon(CupertinoIcons.arrow_left_circle_fill),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [IconButton(onPressed: () {}, icon: const Icon(icon))],
  );
}
