import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/utils/states_districts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components.dart';
import '../constants.dart';

class AddReportScreen extends StatelessWidget {
  const AddReportScreen({Key? key}) : super(key: key);

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
                        children: const [
                          Expanded(
                            child: ReportColumn(
                                horizontalPadding: 130.0,
                                verticalPadding: 40.0),
                          ),
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
                        children: const [
                          Expanded(
                            child: ReportColumn(
                                horizontalPadding: 80.0, verticalPadding: 30.0),
                          ),
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
                children: const [
                  Expanded(
                    child: ReportColumn(
                        horizontalPadding: 150.0, verticalPadding: 30.0),
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
                children: const [
                  Expanded(
                    child: ReportColumn(
                        horizontalPadding: 30.0, verticalPadding: 30.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ReportColumn extends StatelessWidget {
  const ReportColumn(
      {Key? key,
      required this.horizontalPadding,
      required this.verticalPadding})
      : super(key: key);
  final double horizontalPadding, verticalPadding;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController contactController = TextEditingController();

    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();
    RxString state = databaseController.userState.value.obs;
    RxString district = databaseController.userDistrict.value.obs;
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        children: [
          TextField(
            controller: titleController,
            minLines: 1,
            maxLines: null,
            decoration: postScreenTextFieldDecoration('Title'),
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            minLines: 4,
            maxLines: null,
            decoration: postScreenTextFieldDecoration('Description'),
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 20),
          Obx(() => DropdownButton<String>(
                isExpanded: true,
                hint: const Text('State'),
                value: state.value == 'none' ? null : state.value,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  district.value = 'none';
                  state.value = newValue!;
                },
                items: getStatesList()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          const SizedBox(height: 20.0),
          Obx(() => DropdownButton<String>(
                isExpanded: true,
                hint: const Text('District'),
                value: district.value == 'none' ? null : district.value,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  district.value = newValue!;
                },
                items: getDistrictsList(state.value)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          const SizedBox(height: 20),
          TextField(
            controller: locationController,
            minLines: 1,
            maxLines: null,
            decoration: postScreenTextFieldDecoration('Location'),
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: contactController,
            keyboardType: TextInputType.number,
            minLines: 1,
            maxLines: null,
            maxLength: 10,
            decoration:
                postScreenTextFieldDecoration('Your contact number').copyWith(
              helperText: '10 digit phone number',
              prefix: const Text('+91-'),
            ),
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 40),
          Obx(() => authController.isLoading.value
              ? loader
              : Center(
                  child: RectButton(
                    text: 'Save',
                    width: 130.0,
                    padding: 10.0,
                    onPressed: () async {
                      if (titleController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Title cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (descriptionController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Description cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (locationController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Location cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (contactController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Contact cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (state.value == 'none') {
                        Get.snackbar(
                          'Error',
                          'State not selected',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (district.value == 'none') {
                        Get.snackbar(
                          'Error',
                          'District not selected',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else {
                        authController.isLoading.value = true;
                        String name = await databaseController
                            .getName(authController.userUID);
                        await databaseController.addReport(
                            authController,
                            titleController.text,
                            descriptionController.text,
                            state.value,
                            district.value,
                            locationController.text,
                            contactController.text,
                            name,
                            authController.userEmail);
                      }
                    },
                  ),
                )),
        ],
      ),
    );
  }
}
