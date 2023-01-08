import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Features/Auth/repositories/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo);
});

class AuthController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  void signInwithPhone(BuildContext context, String phoneNumber) {
    authRepo.signInwithPhone(context, phoneNumber);
  }

  void verifyOTP(
    BuildContext context,
    String verificationId,
    String userOTP,
  ) {
    authRepo.verifyOTP(
        context: context, verificationId: verificationId, userOTP: userOTP);
  }
}
