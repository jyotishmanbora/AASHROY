import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/utils/date_time_util.dart';
import 'package:aashroy/utils/states_districts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aashroy/constants.dart';

import '../components.dart';

class PostScreen extends StatelessWidget {
  const PostScreen(
      {Key? key,
      this.postUid,
      this.title = '',
      this.description = '',
      this.venue = '',
      this.date = '',
      this.host = '',
      this.contact = '',
      this.author = '',
      this.authorMail = '',
      this.state = '',
      this.district = ''})
      : super(key: key);
  final String? postUid;
  final String title,
      description,
      venue,
      date,
      host,
      contact,
      author,
      authorMail,
      state,
      district;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
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
                              child: PostColumn(
                            horizontalPadding: 130.0,
                            verticalPadding: 40.0,
                            postUid: postUid,
                            title: title,
                            description: description,
                            venue: venue,
                            host: host,
                            date: date,
                            contact: contact,
                            author: author,
                            authorMail: authorMail,
                            state: state.isEmpty
                                ? databaseController.userState.value == 'none'
                                    ? ''
                                    : databaseController.userState.value
                                : state,
                            district: district.isEmpty
                                ? databaseController.userDistrict.value ==
                                        'none'
                                    ? ''
                                    : databaseController.userDistrict.value
                                : district,
                          ))
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
                              child: PostColumn(
                            horizontalPadding: 80.0,
                            verticalPadding: 30.0,
                            postUid: postUid,
                            title: title,
                            description: description,
                            venue: venue,
                            host: host,
                            date: date,
                            contact: contact,
                            author: author,
                            authorMail: authorMail,
                            state: state.isEmpty
                                ? databaseController.userState.value == 'none'
                                    ? ''
                                    : databaseController.userState.value
                                : state,
                            district: district.isEmpty
                                ? databaseController.userDistrict.value ==
                                        'none'
                                    ? ''
                                    : databaseController.userDistrict.value
                                : district,
                          ))
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
                    child: PostColumn(
                      horizontalPadding: 150.0,
                      verticalPadding: 30.0,
                      postUid: postUid,
                      title: title,
                      description: description,
                      venue: venue,
                      host: host,
                      date: date,
                      contact: contact,
                      author: author,
                      authorMail: authorMail,
                      state: state.isEmpty
                          ? databaseController.userState.value == 'none'
                              ? ''
                              : databaseController.userState.value
                          : state,
                      district: district.isEmpty
                          ? databaseController.userDistrict.value == 'none'
                              ? ''
                              : databaseController.userDistrict.value
                          : district,
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
                      child: PostColumn(
                    horizontalPadding: 30.0,
                    verticalPadding: 30.0,
                    postUid: postUid,
                    title: title,
                    description: description,
                    venue: venue,
                    host: host,
                    date: date,
                    contact: contact,
                    author: author,
                    authorMail: authorMail,
                    state: state.isEmpty
                        ? databaseController.userState.value == 'none'
                            ? ''
                            : databaseController.userState.value
                        : state,
                    district: district.isEmpty
                        ? databaseController.userDistrict.value == 'none'
                            ? ''
                            : databaseController.userDistrict.value
                        : district,
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class PostColumn extends StatelessWidget {
  const PostColumn({
    Key? key,
    this.postUid,
    this.title = '',
    this.description = '',
    this.venue = '',
    this.date = '',
    this.host = '',
    this.contact = '',
    this.author = '',
    this.authorMail = '',
    this.state = '',
    this.district = '',
    required this.horizontalPadding,
    required this.verticalPadding,
  }) : super(key: key);
  final String? postUid;
  final String title,
      description,
      venue,
      date,
      host,
      contact,
      author,
      authorMail,
      state,
      district;
  final double horizontalPadding, verticalPadding;

  @override
  Widget build(BuildContext context) {
    RxString dateOBS = date.obs,
        stateOBS = state.obs,
        districtOBS = district.obs;
    int dateInt = dateTimeToInt(DateTime.now());
    if (date.isNotEmpty) {
      dateInt = int.parse(
          date.substring(6) + date.substring(3, 5) + date.substring(0, 2));
    } else {
      dateOBS.value = dateTimeToString(DateTime.now());
    }

    TextEditingController titleController = TextEditingController();
    titleController.text = title;
    TextEditingController descriptionController = TextEditingController();
    descriptionController.text = description;
    TextEditingController venueController = TextEditingController();
    venueController.text = venue;
    TextEditingController hostController = TextEditingController();
    hostController.text = host;
    TextEditingController contactController = TextEditingController();
    contactController.text = contact;

    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();

    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      children: [
        const Text(
          'Event details:',
          style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
        ),
        const SizedBox(height: 20),
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
        TextField(
          controller: hostController,
          minLines: 1,
          maxLines: null,
          decoration: postScreenTextFieldDecoration('Hosted by'),
          cursorColor: const Color(0xff637CFF),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: contactController,
          keyboardType: TextInputType.number,
          minLines: 1,
          maxLines: null,
          maxLength: 10,
          decoration: postScreenTextFieldDecoration('Contact number').copyWith(
              helperText: '10 digit phone number', prefix: const Text('+91-')),
          cursorColor: const Color(0xff637CFF),
        ),
        const SizedBox(height: 40),
        const Text(
          'Date and Venue:',
          style: TextStyle(fontSize: 20.0, color: Colors.deepPurple),
        ),
        const SizedBox(height: 20),
        Obx(() => Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: date.isEmpty
                                ? DateTime.now()
                                : DateTime.parse(date.substring(6) +
                                    ' ' +
                                    date.substring(3, 5) +
                                    ' ' +
                                    date.substring(0, 2) +
                                    ' 00:00:00'),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1, 12, 31))
                        .then((date) {
                      dateOBS.value = dateTimeToString(date);
                      dateInt = dateTimeToInt(date);
                      if (date == null) {
                        Get.snackbar('Error', 'Date was not set');
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        dateOBS.value.isEmpty
                            ? dateTimeToString(DateTime.now())
                            : dateOBS.value,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Color(0xff31508C), fontSize: 18.0),
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(
                        Icons.edit,
                        color: Color(0xff31508C),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith((states) =>
                          const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromRGBO(99, 124, 255, 0.2))),
                ),
              ],
            )),
        const SizedBox(height: 20),
        Obx(() => DropdownButton<String>(
              isExpanded: true,
              hint: const Text('State'),
              value: stateOBS.value == '' ? null : stateOBS.value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                districtOBS.value = '';
                stateOBS.value = newValue!;
              },
              items:
                  getStatesList().map<DropdownMenuItem<String>>((String value) {
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
              value: districtOBS.value == '' ? null : districtOBS.value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                districtOBS.value = newValue!;
              },
              items: getDistrictsList(stateOBS.value)
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
        const SizedBox(height: 20),
        TextField(
          controller: venueController,
          minLines: 1,
          maxLines: null,
          decoration: postScreenTextFieldDecoration('Venue'),
          cursorColor: const Color(0xff637CFF),
        ),
        const SizedBox(height: 40.0),
        Obx(() => authController.isLoading.value
            ? loader
            : Center(
                child: RectButton(
                  onPressed: () async {
                    if (titleController.text.isEmpty) {
                      Get.snackbar('Error', 'Title cannot be empty');
                    } else if (descriptionController.text.isEmpty) {
                      Get.snackbar('Error', 'Description cannot be empty');
                    } else if (hostController.text.isEmpty) {
                      Get.snackbar('Error', 'Host name cannot be empty');
                    } else if (contactController.text.length != 10) {
                      Get.snackbar(
                          'Error', 'Contact number must have 10 digits');
                    } else if (stateOBS.value.isEmpty) {
                      Get.snackbar('Error', 'State not selected');
                    } else if (districtOBS.value.isEmpty) {
                      Get.snackbar('Error', 'District not selected');
                    } else if (venueController.text.isEmpty) {
                      Get.snackbar('Error', 'Venue cannot be empty');
                    } else {
                      String userName = await databaseController
                          .getName(authController.userUID);
                      await databaseController.setPostInfo(
                          postUid,
                          titleController.text,
                          descriptionController.text,
                          venueController.text,
                          dateOBS.value,
                          hostController.text,
                          contactController.text,
                          userName,
                          authController.userEmail,
                          stateOBS.value,
                          districtOBS.value,
                          dateInt,
                          authController);
                    }
                  },
                  text: 'Save',
                  width: 130.0,
                  padding: 10.0,
                ),
              )),
      ],
    );
  }
}
