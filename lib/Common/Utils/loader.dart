import 'package:flutter/cupertino.dart';
import 'package:whisper/Common/Utils/colors.dart';

class Loader extends StatelessWidget {
  final double radius;
  final Color color;
  const Loader({
    super.key,
    this.radius = 60,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        child: CupertinoActivityIndicator(
          color: color,
          radius: radius,
        ),
      ),
    );
  }
}
