import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Features/SelectContact/repo/select_contact_repo.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepo = ref.watch(selectContactRepoProvider);
  return selectContactRepo.getContacts();
});

final selectedContactControllerProvider = Provider(
  (ref) {
    final selectContactRepo = ref.watch(selectContactRepoProvider);
    return SelectedContactController(
        ref: ref, selectContactRepo: selectContactRepo);
  },
);

class SelectedContactController {
  final ProviderRef ref;
  final SelectContactRepo selectContactRepo;

  SelectedContactController(
      {required this.ref, required this.selectContactRepo});

  void selectedContact(Contact selectedContact, BuildContext context) {
    selectContactRepo.selectedContact(selectedContact, context);
  }
}
