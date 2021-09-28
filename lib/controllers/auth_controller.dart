import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/user_details_screen.dart';
import 'package:aashroy/screens/verify_screen.dart';
import 'package:aashroy/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  String? userUID, userEmail;
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  void signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        user = _auth.currentUser;
        await user?.sendEmailVerification();
        isLoading.value = false;
        Get.to(() => const VerifyEmailScreen());
      }).catchError((e) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        );
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }
  }

  void checkEmailVerified() async {
    isLoading.value = true;
    user = _auth.currentUser;
    await user?.reload().then((value) {
      user = _auth.currentUser;
      bool? verificationStatus = user?.emailVerified;
      if (verificationStatus != null) {
        if (verificationStatus) {
          userEmail = user?.email;
          userUID = user?.uid;
          isLoading.value = false;
          Get.offAll(() => const DetailsScreen(isNewUser: true));
        }
      }
    }).catchError((e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    });
    isLoading.value = false;
  }

  Future<void> signIn(String email, String password,
      DatabaseController databaseController) async {
    isLoading.value = true;
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }).then((value) async {
      user = _auth.currentUser;
      userEmail = user?.email;
      userUID = user?.uid;
      isLoading.value = false;
      if (user?.email == 'jyotishman353@gmail.com' &&
          user?.uid == 'ETcj3CsFDmO1ZVIoR0vqndYfANs2') {
        await databaseController.setStreamsAdmin(user?.uid, isLoading);
      } else {
        await databaseController.setStreams(user?.uid, isLoading);
      }
    });
    isLoading.value = false;
  }

  void signOut() async {
    isLoading.value = true;
    await _auth.signOut().catchError((e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }).then((value) {
      user = null;
      userEmail = null;
      userUID = null;
      Get.offAll(() => const WelcomeScreen());
      isLoading.value = false;
    });
    isLoading.value = false;
  }
}
