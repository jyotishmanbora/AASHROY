import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/utils/date_time_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components.dart';

class ClearDataScreen extends StatelessWidget {
  const ClearDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffE0D7FF),
                              Color(0xffEFF9FF),
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0)),
                      ),
                      child: const Brand(
                        brandWidth: 400.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffEFF9FF),
                              Color(0xffE0D7FF),
                            ]),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 130.0, vertical: 40.0),
                                children: const [
                                  ClearForm(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffE0D7FF),
                              Color(0xffEFF9FF),
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0)),
                      ),
                      child: const Brand(
                        brandWidth: 400.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffEFF9FF),
                              Color(0xffE0D7FF),
                            ]),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0, vertical: 30.0),
                                children: const [
                                  ClearForm(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (constraints.maxWidth >= 600) {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xffEFF9FF),
                    Color(0xffF1EDFF),
                  ])),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 150.0, vertical: 30.0),
                        children: const [
                          ClearForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xffEFF9FF),
                    Color(0xffF1EDFF),
                  ])),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        children: const [
                          ClearForm(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ClearForm extends StatelessWidget {
  const ClearForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    AuthController authController = Get.find<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Events: Delete already done events and drives',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff31508C),
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 15.0),
        TextButton(
          onPressed: () async {
            await databaseController.deleteOldEvents(
                dateTimeToInt(DateTime.now()), authController);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.deepPurple),
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(10.0)),
          ),
        ),
        const SizedBox(height: 40.0),
        const Text(
          'Reports: Delete reports older than today',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff31508C),
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 15.0),
        TextButton(
          onPressed: () async {
            await databaseController.deleteOldReports(
                dateTimeToInt(DateTime.now()), authController);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.deepPurple),
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(10.0)),
          ),
        ),
        const SizedBox(height: 40.0),
        const Text(
          'Shelters: Delete shelter posts older than 15 days with upvote to downvote ratio less than 3',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff31508C),
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 15.0),
        TextButton(
          onPressed: () async {
            var date = DateTime.now();
            await databaseController.deleteOldShelters(
                dateTimeToInt(DateTime(date.year, date.month, date.day - 15)),
                3,
                authController);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.deepPurple),
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(10.0)),
          ),
        ),
        Obx(() => authController.isLoading.value ? loader : const SizedBox()),
      ],
    );
  }
}
