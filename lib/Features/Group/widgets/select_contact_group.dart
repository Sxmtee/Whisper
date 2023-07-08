import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Common/Widgets/generalWidgets/error_screen.dart';
import 'package:whisper/Features/SelectContact/controller/select_contact_controller.dart';

final selectedGroupContacts = StateProvider<List<Contact>>(
  (ref) => [],
);

class SelectContactGroup extends ConsumerStatefulWidget {
  const SelectContactGroup({super.key});

  @override
  ConsumerState<SelectContactGroup> createState() => _SelectContactGroupState();
}

class _SelectContactGroupState extends ConsumerState<SelectContactGroup> {
  List<int> selectedContactsIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.removeAt(index);
    } else {
      selectedContactsIndex.add(index);
    }
    setState(() {});
    ref
        .read(selectedGroupContacts.notifier)
        .update((state) => [...state, contact]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
          data: (contactList) => Expanded(
            child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(index, contact),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: selectedContactsIndex.contains(index)
                          ? const Icon(Icons.done)
                          : null,
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          error: (err, trace) {
            return ErrorScreen(error: err.toString());
          },
          loading: () {
            return const Loader();
          },
        );
  }
}
