import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Common/Widgets/error_screen.dart';
import 'package:whisper/Features/Views/controllers/select_contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  static const String routeName = "/select-contact";
  const SelectContactScreen({super.key});

  void selectContact(
      WidgetRef ref, BuildContext context, Contact selectedContact) {
    ref
        .read(selectedContactControllerProvider)
        .selectedContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Whispermates"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (() {}), icon: const Icon(Icons.search)),
          IconButton(
              onPressed: (() {}), icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: ref.watch(getContactsProvider).when(data: ((contactList) {
        return ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            final contact = contactList[index];
            return GestureDetector(
              onTap: () {
                selectContact(ref, context, contact);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Text(
                    contact.displayName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  leading: contact.photo == null
                      ? null
                      : CircleAvatar(
                          backgroundImage: MemoryImage(contact.photo!),
                          radius: 30,
                        ),
                ),
              ),
            );
          },
        );
      }), error: ((error, stackTrace) {
        return ErrorScreen(error: error.toString());
      }), loading: () {
        return const Loader(radius: 60, color: AppColors.primaryColor);
      }),
    );
  }
}
