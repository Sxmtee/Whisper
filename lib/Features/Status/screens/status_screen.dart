import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Features/Status/controller/status_controller.dart';
import 'package:whisper/Features/Status/screens/status_screen2.dart';
import 'package:whisper/Models/statusModel.dart';

class StatusScreen extends ConsumerWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.read(statusControllerProvider).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, StatusScreen2.routeName,
                        arguments: statusData);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        statusData.username,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          statusData.profilePic,
                        ),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
                const Divider(color: AppColors.dividerColor, indent: 85),
              ],
            );
          },
        );
      },
    );
  }
}
