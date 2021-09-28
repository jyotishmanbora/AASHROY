import 'package:aashroy/constants.dart';
import 'package:aashroy/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components.dart';
import 'dart:ui';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    List<Widget> getContent(
        var brandbgColor,
        var buttonbgColor,
        double brandWidth,
        double contentGap,
        double buttonWidth,
        double buttonPadding,
        MainAxisAlignment buttonAxisAlignment,
        int brandFlex,
        int buttonFlex) {
      return [
        Flexible(
          flex: brandFlex,
          child: Container(
            decoration: BoxDecoration(
              gradient: brandbgColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0)),
            ),
            child: Center(
              child: Image.asset(
                'brand.png',
                width: brandWidth,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
        Expanded(
          flex: buttonFlex,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            decoration: BoxDecoration(
              gradient: buttonbgColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
            ),
            child: Column(
              mainAxisAlignment: buttonAxisAlignment,
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      textFieldDecoration('Email id', 'Enter a valid email id'),
                ),
                SizedBox(height: contentGap),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: textFieldDecoration(
                      'Create password', 'Minimum 6 characters required'),
                ),
                SizedBox(height: contentGap),
                Obx(
                  () => authController.isLoading.value
                      ? loader
                      : RectButton(
                          onPressed: () {
                            if (_emailController.text.trim() == '') {
                              Get.snackbar(
                                'Error',
                                'Email id cannot be empty',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.white,
                              );
                            } else if (_passwordController.text.length < 6) {
                              Get.snackbar(
                                'Error',
                                'Password must contain at least 6 characters',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.white,
                              );
                            } else {
                              authController.signUp(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim());
                            }
                          },
                          text: 'Sign up',
                          width: buttonWidth,
                          padding: buttonPadding,
                        ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return Scrollbar(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 1440) {
              return Container(
                padding: const EdgeInsets.all(50.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xff123456),
                      Color(0xff8FD5FD),
                    ])),
                child: Row(
                  children: getContent(
                      const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffE0D7FF),
                            Color(0xffEFF9FF),
                          ]),
                      const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffEFF9FF),
                            Color(0xffE0D7FF),
                          ]),
                      380.0,
                      30.0,
                      200.0,
                      15.0,
                      MainAxisAlignment.center,
                      1,
                      1),
                ),
              );
            } else if (constraints.maxWidth >= 1024) {
              return Container(
                padding: const EdgeInsets.all(50.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xff123456),
                      Color(0xff8FD5FD),
                    ])),
                child: Row(
                  children: getContent(
                      const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffE0D7FF),
                            Color(0xffEFF9FF),
                          ]),
                      const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffEFF9FF),
                            Color(0xffE0D7FF),
                          ]),
                      380.0,
                      20.0,
                      130.0,
                      10.0,
                      MainAxisAlignment.center,
                      1,
                      1),
                ),
              );
            } else if (constraints.maxWidth >= 600) {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xffEFF9FF),
                      Color(0xffF1EDFF),
                    ])),
                child: Column(
                  children: getContent(null, null, 380.0, 20.0, 130.0, 10,
                      MainAxisAlignment.start, 3, 2),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color(0xffEFF9FF),
                      Color(0xffF1EDFF),
                    ])),
                child: Column(
                  children: getContent(null, null, 300.0, 20.0, 130.0, 10,
                      MainAxisAlignment.start, 1, 1),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
