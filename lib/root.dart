import 'package:aashroy/components.dart';
import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    AuthController authController = Get.put(AuthController());
    DatabaseController databaseController = Get.put(DatabaseController());
    if (user != null) {
      authController.user = user;
      authController.userEmail = user.email;
      authController.userUID = user.uid;
      if (user.email == 'jyotishman353@gmail.com' &&
          user.uid == 'ETcj3CsFDmO1ZVIoR0vqndYfANs2') {
        databaseController.setStreamsAdmin(user.uid, authController.isLoading);
      } else {
        databaseController.setStreams(user.uid, authController.isLoading);
      }
      return Scaffold(
        body: Center(
          child: loader,
        ),
      );
    } else {
      return const WelcomeScreen();
    }
  }
}
