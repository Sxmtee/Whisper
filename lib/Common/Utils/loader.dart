import 'package:flutter/cupertino.dart';
import 'package:whisper/Common/Utils/colors.dart';

class Loader extends StatelessWidget {
  final double radius;
  final Color color;
  const Loader({super.key, required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        child: CupertinoActivityIndicator(
          color: AppColors.primaryColor,
          radius: radius,
        ),
      ),
    );
  }
}
