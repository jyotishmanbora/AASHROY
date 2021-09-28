import 'package:aashroy/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    List<Widget> getContent(
        var brandbgColor,
        var buttonbgColor,
        double brandWidth,
        double buttonGap,
        double buttonWidth,
        double buttonPadding,
        double? textFontSize,
        MainAxisAlignment buttonAxisAlignment,
        int brandFlex,
        int buttonFlex) {
      return [
        Expanded(
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
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: buttonbgColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0)),
            ),
            child: Column(
              mainAxisAlignment: buttonAxisAlignment,
              children: [
                Text(
                  'A verification email has been sent to your id. Please verify your email id and then click on proceed',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: textFontSize),
                ),
                SizedBox(height: buttonGap),
                Obx(() => authController.isLoading.value
                    ? loader
                    : RectButton(
                        onPressed: () {
                          authController.checkEmailVerified();
                        },
                        text: 'Proceed',
                        width: buttonWidth,
                        padding: buttonPadding,
                      )),
              ],
            ),
          ),
        ),
      ];
    }

    return Scaffold(
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
                    18.0,
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
                    15.0,
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
                children: getContent(null, null, 380.0, 20.0, 130.0, 10, 15.0,
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
                children: getContent(null, null, 300.0, 20.0, 130.0, 10, 15.0,
                    MainAxisAlignment.start, 1, 1),
              ),
            );
          }
        },
      ),
    );
  }
}
