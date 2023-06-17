import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Features/Call/controller/call_controller.dart';
import 'package:whisper/Features/Call/screen/call_screen.dart';
import 'package:whisper/Models/callModel.dart';

class CallPickupScreen extends ConsumerWidget {
  final Widget child;
  const CallPickupScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<DocumentSnapshot>(
      stream: ref.read(callControllerProvider).callStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          CallModel call = CallModel.fromMap(
            snapshot.data!.data() as Map<String, dynamic>,
          );

          if (!call.hasDialled) {
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Incoming Call",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(call.callerPic),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      call.callerName,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call_end,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        IconButton(
                          onPressed: () {
                            var route = MaterialPageRoute(
                              builder: (context) => CallScreen(
                                channelId: call.callId,
                                call: call,
                                isGroupChat: false,
                              ),
                            );
                            Navigator.push(context, route);
                          },
                          icon: const Icon(
                            Icons.call_end,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        }
        return child;
      },
    );
  }
}
