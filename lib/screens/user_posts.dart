import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/home_screen.dart';
import 'package:aashroy/screens/post_screen.dart';
import 'package:aashroy/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components.dart';
import 'admin_home_screen.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({Key? key, required this.name}) : super(key: key);
  final String name;

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
                    child: MyEvents(
                      name: name,
                      constraints: constraints,
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
                    child: MyEvents(
                      name: name,
                      constraints: constraints,
                    ),
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
                  child: MyEvents(
                    name: name,
                    constraints: constraints,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class MyPostsDrawer extends StatelessWidget {
  const MyPostsDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Image.asset(
            'brand.png',
            filterQuality: FilterQuality.medium,
          ),
          const SizedBox(height: 15.0),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            leading: const Icon(
              Icons.face,
              color: Colors.white,
            ),
            title: const Text('Update Info',
                style: TextStyle(color: Colors.white)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            onTap: () async {
              authController.isLoading.value = true;
              String name =
                  await databaseController.getName(authController.userUID);
              String type =
                  await databaseController.getUserType(authController.userUID);
              String state =
                  await databaseController.getState(authController.userUID);
              String district =
                  await databaseController.getDistrict(authController.userUID);
              authController.isLoading.value = false;
              Get.to(() => DetailsScreen(
                    isNewUser: false,
                    name: name,
                    type: type,
                    stateName: state,
                    districtName: district,
                  ));
            },
            tileColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 15.0),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text('Go back home',
                style: TextStyle(color: Colors.white)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            onTap: () {
              if (authController.userEmail == 'jyotishman353@gmail.com' &&
                  authController.userUID == 'ETcj3CsFDmO1ZVIoR0vqndYfANs2') {
                Get.offAll(() => const AdminHomeScreen());
              } else {
                Get.offAll(() => const HomeScreen());
              }
            },
            tileColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 15.0),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text('Log Out', style: TextStyle(color: Colors.white)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            onTap: () {
              authController.signOut();
            },
            tileColor: const Color(0xffFF6584),
          ),
          const SizedBox(height: 15.0),
          Obx(() => authController.isLoading.value ? loader : const SizedBox()),
        ],
      ),
    );
  }
}

class MyEvents extends StatelessWidget {
  const MyEvents({Key? key, required this.name, required this.constraints})
      : super(key: key);
  final String name;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
            left: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
            top: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
          ),
          child: const Text(
            'Your posts:',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff31508C),
              fontSize: 20.0,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: databaseController.getEventsStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Some error ocurred at the servers'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loader;
              }
              var events = snapshot.data.docs;
              List<MyEventCard> eventsList = [];
              if (events == null) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Some error ocurred at the servers'),
                );
              } else {
                for (var event in events) {
                  Map<String, dynamic> data =
                      event.data() as Map<String, dynamic>;
                  if (data['author'] == name &&
                      data['authorMail'] == authController.userEmail) {
                    eventsList.add(MyEventCard(
                      postUid: event.id,
                      title: data['title'],
                      description: data['description'],
                      date: data['date'],
                      venue: data['venue'],
                      host: data['host'],
                      contact: data['contact'],
                      author: data['author'],
                      authorMail: data['authorMail'],
                      constraints: constraints,
                      state: data['state'],
                      district: data['district'],
                    ));
                  }
                }
              }

              if (eventsList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'no_events.png',
                    filterQuality: FilterQuality.medium,
                  ),
                );
              }

              return ListView.builder(
                padding:
                    EdgeInsets.all(constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                itemBuilder: (context, index) {
                  return eventsList[index];
                },
                itemCount: eventsList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class MyEventCard extends StatelessWidget {
  const MyEventCard(
      {Key? key,
      required this.postUid,
      required this.title,
      required this.description,
      required this.date,
      required this.venue,
      required this.host,
      required this.contact,
      required this.author,
      required this.authorMail,
      required this.constraints,
      required this.state,
      required this.district})
      : super(key: key);
  final String postUid;
  final String title,
      description,
      date,
      state,
      district,
      venue,
      host,
      contact,
      author,
      authorMail;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    RxInt titleMaxLine = 1.obs;
    RxInt descriptionMaxLine = 3.obs;
    RxInt dateMaxLine = 1.obs;
    RxInt venueMaxLine = 1.obs;
    RxInt hostMaxLine = 1.obs;
    RxInt contactMaxLine = 1.obs;
    RxInt authorMaxLine = 1.obs;
    RxInt authorMailMaxLine = 1.obs;
    RxString buttonText = 'More'.obs;

    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();
    return Obx(() => Container(
          margin: EdgeInsets.only(
              bottom: constraints.maxWidth >= 1024 ? 30.0 : 20.0),
          padding: EdgeInsets.all(constraints.maxWidth >= 1024 ? 30.0 : 20.0),
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
                maxLines: titleMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
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
                maxLines: descriptionMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                height: 1.0,
                color: const Color(0xffD2D2D2),
              ),
              Text(
                'Date: ' + date,
                maxLines: dateMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              Text(
                'Venue: ' + venue,
                maxLines: venueMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                height: 1.0,
                color: const Color(0xffD2D2D2),
              ),
              Text(
                'Host: ' + host,
                maxLines: hostMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              Text(
                'Contact: +91- ' + contact,
                maxLines: contactMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              Text(
                'Posted by: ' + author,
                maxLines: authorMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              Text(
                'Email id: ' + authorMail,
                maxLines: authorMailMaxLine.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RectButton(
                    onPressed: () {
                      if (titleMaxLine.value == 1 &&
                          descriptionMaxLine.value == 3 &&
                          dateMaxLine.value == 1 &&
                          venueMaxLine.value == 1 &&
                          hostMaxLine.value == 1 &&
                          contactMaxLine.value == 1 &&
                          authorMaxLine.value == 1 &&
                          authorMailMaxLine.value == 1 &&
                          buttonText.value == 'More') {
                        titleMaxLine.value = 4;
                        descriptionMaxLine.value = 30;
                        dateMaxLine.value = 2;
                        venueMaxLine.value = 3;
                        hostMaxLine.value = 3;
                        contactMaxLine.value = 2;
                        authorMaxLine.value = 3;
                        authorMailMaxLine.value = 2;
                        buttonText.value = 'Less';
                      } else {
                        titleMaxLine.value = 1;
                        descriptionMaxLine.value = 3;
                        dateMaxLine.value = 1;
                        venueMaxLine.value = 1;
                        hostMaxLine.value = 1;
                        contactMaxLine.value = 1;
                        authorMaxLine.value = 1;
                        authorMailMaxLine.value = 1;
                        buttonText.value = 'More';
                      }
                    },
                    text: buttonText.value,
                    width: 110.0,
                    padding: 5.0,
                  ),
                  Obx(() => authController.isLoading.value
                      ? loader
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(() => PostScreen(
                                      postUid: postUid,
                                      title: title,
                                      description: description,
                                      host: host,
                                      contact: contact,
                                      date: date,
                                      venue: venue,
                                      state: state,
                                      district: district,
                                      author: author,
                                      authorMail: authorMail,
                                    ));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Color(0xff637CFF),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Get.bottomSheet(
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30.0),
                                        const Text(
                                          'Once deleted, the post cannot be recovered. Are you sure to proceed?',
                                          style: TextStyle(fontSize: 20.0),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () async {
                                                Get.back();
                                                await databaseController
                                                    .deletePost(postUid,
                                                        authController);
                                              },
                                              child: const Text(
                                                'Sure',
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 20.0,
                                                            vertical: 20.0)),
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            const Color
                                                                    .fromRGBO(
                                                                99,
                                                                124,
                                                                255,
                                                                0.2)),
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            TextButton(
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 20.0,
                                                            vertical: 20.0)),
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            const Color
                                                                    .fromRGBO(
                                                                99,
                                                                124,
                                                                255,
                                                                0.2)),
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
                            ),
                          ],
                        )),
                ],
              )
            ],
          ),
        ));
  }
}
