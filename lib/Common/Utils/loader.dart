import 'package:flutter/cupertino.dart';
import 'package:whisper/Common/Utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RepaintBoundary(
        child: CupertinoActivityIndicator(
          color: AppColors.primaryColor,
          radius: 60,
        ),
      ),
    );
  }
}
