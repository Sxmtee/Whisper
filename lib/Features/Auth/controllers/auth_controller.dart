import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Features/Auth/repositories/auth_repo.dart';
import 'package:whisper/Models/userModel.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepo = ref.watch(authRepoProvider);
    return AuthController(authRepo: authRepo, ref: ref);
  },
);

final userDataAuthProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserData();
  },
);

class AuthController {
  final AuthRepo authRepo;
  final ProviderRef ref;

  AuthController({
    required this.authRepo,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepo.getCurrentUserData();
    return user;
  }

  void signInwithPhone(
    BuildContext context,
    String phoneNumber,
  ) {
    authRepo.signInwithPhone(context, phoneNumber);
  }

  void verifyOTP(
    BuildContext context,
    String verificationId,
    String userOTP,
  ) {
    authRepo.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
    String name,
    File? profilePic,
    BuildContext context,
  ) {
    authRepo.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepo.userData(userId);
  }

  void setUserState(bool isOnline) {
    return authRepo.setUserState(isOnline);
  }
}
