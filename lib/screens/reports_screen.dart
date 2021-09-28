import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/user_posts.dart';
import 'package:aashroy/utils/states_districts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../components.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController drawerMenuScrollController = ScrollController();
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return Scaffold(
            backgroundColor: const Color(0xffEFF9FF),
            body: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Scrollbar(
                      controller: drawerMenuScrollController,
                      child: Padding(
                        padding: EdgeInsets.all(
                            constraints.maxWidth >= 1250 ? 30.0 : 0.0),
                        child: const MyPostsDrawer(),
                      ),
                    )),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: ReportCards(constraints: constraints),
                        ),
                      ],
                    ),
                    color: const Color(0xffF1EDFF),
                  ),
                ),
              ],
            ),
          );
        } else if (constraints.maxWidth >= 600) {
          return Scaffold(
            backgroundColor: const Color(0xffEFF9FF),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Color(0xff8863FF)),
              title: const Text(
                'AASHROY',
                style: TextStyle(
                  color: Color(0xff8863FF),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              backgroundColor: const Color(0xffEFF9FF),
            ),
            drawer: Drawer(
              child: Scrollbar(
                controller: drawerMenuScrollController,
                child: const MyPostsDrawer(),
              ),
            ),
            body: Row(
              children: [
                Expanded(
                  child: Container(
                    child: ReportCards(constraints: constraints),
                    color: const Color(0xffF1EDFF),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: const Color(0xffEFF9FF),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Color(0xff8863FF)),
              title: const Text(
                'AASHROY',
                style: TextStyle(
                  color: Color(0xff8863FF),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              backgroundColor: const Color(0xffEFF9FF),
            ),
            drawer: Drawer(
              child: Scrollbar(
                controller: drawerMenuScrollController,
                child: const MyPostsDrawer(),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ReportCards(constraints: constraints),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ReportCards extends StatelessWidget {
  const ReportCards({Key? key, required this.constraints}) : super(key: key);
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    RxString state = databaseController.userState.value.obs;
    RxString district = databaseController.userDistrict.value.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
            left: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
            right: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
          ),
          child: Column(
            children: [
              const Text(
                'Filters:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff31508C),
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 40.0),
              const Text(
                'Reports:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff31508C),
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: databaseController.getReportsStream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(
                        constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                    child: const Text('Some error ocurred at the servers'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loader;
                }
                if (databaseController.userState.value == 'none' ||
                    databaseController.userDistrict.value == 'none') {
                  return Padding(
                    padding: EdgeInsets.all(
                        constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                    child: const Text('Some error ocurred at the servers'),
                  );
                } else {
                  var reports = snapshot.data.docs;
                  List<ReportCard> reportsList = [];
                  if (reports == null) {
                    return Padding(
                      padding: EdgeInsets.all(
                          constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                      child: const Text('Some error ocurred at the servers'),
                    );
                  } else {
                    for (var report in reports) {
                      Map<String, dynamic> data =
                          report.data() as Map<String, dynamic>;
                      reportsList.add(ReportCard(
                          title: data['title'],
                          description: data['description'],
                          location: data['location'],
                          state: data['state'],
                          district: data['district'],
                          author: data['author'],
                          authorMail: data['authorMail'],
                          authorContact: data['contact'],
                          stateOBS: state,
                          districtOBS: district,
                          constraints: constraints,
                          documentId: report.id));
                    }
                    if (reportsList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(
                            constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                        child: const Text('No data found in your district!'),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return reportsList[index];
                      },
                      itemCount: reportsList.length,
                      padding: EdgeInsets.all(
                          constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                    );
                  }
                }
              }),
        ),
      ],
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.location,
      required this.state,
      required this.district,
      required this.author,
      required this.authorMail,
      required this.authorContact,
      required this.stateOBS,
      required this.districtOBS,
      required this.constraints,
      required this.documentId})
      : super(key: key);
  final String title,
      description,
      location,
      state,
      district,
      author,
      authorMail,
      authorContact,
      documentId;
  final RxString stateOBS, districtOBS;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    AuthController authController = Get.find<AuthController>();
    return Obx(() => stateOBS.value == state && districtOBS.value == district
        ? Row(
            children: [
              Expanded(
                flex: constraints.maxWidth >= 600 ? 3 : 1,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: constraints.maxWidth >= 1024 ? 30.0 : 20.0),
                  padding: EdgeInsets.all(
                      constraints.maxWidth >= 1024 ? 30.0 : 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xff637CFF),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xff637CFF),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        height: 1.0,
                        color: const Color(0xffD2D2D2),
                      ),
                      Text(
                        description,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xff31508C),
                          fontSize: 16.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        height: 1.0,
                        color: const Color(0xffD2D2D2),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Location: $location',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff31508C),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: location));
                            },
                            child: const Icon(Icons.content_copy,
                                color: Color(0xff637CFF)),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        height: 1.0,
                        color: const Color(0xffD2D2D2),
                      ),
                      Text(
                        'Posted by: $author',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xff31508C),
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Email id: $authorMail',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff31508C),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: authorMail));
                            },
                            child: const Icon(Icons.content_copy,
                                color: Color(0xff637CFF)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Contact: $authorContact',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff31508C),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: authorContact));
                            },
                            child: const Icon(Icons.content_copy,
                                color: Color(0xff637CFF)),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        height: 1.0,
                        color: const Color(0xffD2D2D2),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 30.0),
                                  const Text(
                                    'Once deleted, the information cannot be recovered. Are you sure to proceed?',
                                    style: TextStyle(fontSize: 20.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          Get.back();
                                          await databaseController.deleteReport(
                                              documentId, authController);
                                        },
                                        child: const Text(
                                          'Sure',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty
                                              .resolveWith((states) =>
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 20.0)),
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      const Color.fromRGBO(
                                                          99, 124, 255, 0.2)),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      TextButton(
                                        onPressed: () async {
                                          Get.back();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty
                                              .resolveWith((states) =>
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 20.0)),
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) =>
                                                      const Color.fromRGBO(
                                                          99, 124, 255, 0.2)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            isDismissible: false,
                            enableDrag: false,
                            backgroundColor: const Color(0xffEFF9FF),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Color(0xffFF6584),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                          elevation: MaterialStateProperty.resolveWith(
                              (states) => 3.0),
                          padding: MaterialStateProperty.resolveWith(
                              (states) => const EdgeInsets.all(10.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              constraints.maxWidth >= 600
                  ? const Expanded(flex: 2, child: SizedBox())
                  : const SizedBox(),
            ],
          )
        : const SizedBox());
  }
}
