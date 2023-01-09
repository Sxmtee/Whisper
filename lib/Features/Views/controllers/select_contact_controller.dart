import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Features/Views/repositories/select_contact_repo.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactRepo = ref.watch(selectContactRepoProvider);
  return selectContactRepo.getContacts();
});
