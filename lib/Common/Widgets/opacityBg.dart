import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:whisper/Common/Utils/dimensions.dart';

Widget OpacityBg(BuildContext context, Widget body) {
  return Stack(
    children: [
      // Positioned(
      //   width: Dimensions.getSize(context).width * 1.7,
      //   bottom: 200,
      //   left: 100,
      //   child: Image.asset("assets/Backgrounds/Splash"),
      // ),
      // Positioned.fill(
      //     child: BackdropFilter(
      //   filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
      // )),
      const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
      Positioned.fill(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: const SizedBox(),
      ))
    ],
  );
}
