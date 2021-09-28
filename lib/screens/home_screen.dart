import 'package:aashroy/components.dart';
import 'package:aashroy/constants.dart';
import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/add_report.dart';
import 'package:aashroy/screens/org_screen.dart';
import 'package:aashroy/screens/post_screen.dart';
import 'package:aashroy/screens/shelters_screen.dart';
import 'package:aashroy/screens/user_details_screen.dart';
import 'package:aashroy/screens/user_posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController bodyScrollController = ScrollController();
    ScrollController eventsScrollController = ScrollController();
    ScrollController drawerMenuScrollController = ScrollController();
    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();
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
                        child: DrawerMenu(
                            authController: authController,
                            databaseController: databaseController),
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(30.0),
                    child: ActionCards(
                      constraints: constraints,
                      scrollController: bodyScrollController,
                      eventsScrollController: eventsScrollController,
                    ),
                    color: const Color(0xffF1EDFF),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Events(
                      constraints: constraints,
                      scrollController: eventsScrollController),
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
                child: DrawerMenu(
                    authController: authController,
                    databaseController: databaseController),
              ),
            ),
            body: Row(
              children: [
                Expanded(
                    child: Container(
                  child: ActionCards(
                    constraints: constraints,
                    scrollController: bodyScrollController,
                    eventsScrollController: eventsScrollController,
                  ),
                  color: const Color(0xffF1EDFF),
                )),
                Expanded(
                    child: Events(
                        constraints: constraints,
                        scrollController: eventsScrollController)),
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
                child: DrawerMenu(
                    authController: authController,
                    databaseController: databaseController),
              ),
            ),
            body: ActionCards(
              constraints: constraints,
              scrollController: bodyScrollController,
              eventsScrollController: eventsScrollController,
            ),
          );
        }
      },
    );
  }
}

class ActionCards extends StatelessWidget {
  const ActionCards(
      {Key? key,
      required this.constraints,
      required this.scrollController,
      required this.eventsScrollController})
      : super(key: key);
  final BoxConstraints constraints;
  final ScrollController scrollController;
  final ScrollController eventsScrollController;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    AuthController authController = Get.find<AuthController>();
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            children: [
              ActionCard(
                bgColor: const Color(0xff8EA0FF),
                mainText:
                    'Let us know about a shelter of homeless people in your area',
                buttonText: "Let's go",
                png: 'locate.png',
                constraints: constraints,
                onTap: () async {
                  String userName =
                      await databaseController.getName(authController.userUID);
                  Get.to(() => SheltersScreen(userName: userName));
                },
              ),
              ActionCard(
                bgColor: const Color(0xff5BD476),
                mainText:
                    "Know about organizations in your district and volunteer service or donation",
                buttonText: "Know more",
                png: 'donate.png',
                onTap: () {
                  Get.to(() => const OrgListScreen());
                },
                buttonRed: 27,
                buttonGreen: 181,
                buttonBlue: 61,
                constraints: constraints,
              ),
              ActionCard(
                bgColor: const Color(0xffFF7C7C),
                mainText: "Report crime or illegal activities anonymously",
                buttonText: "Report",
                png: 'report.png',
                onTap: () {
                  Get.to(() => const AddReportScreen());
                },
                buttonRed: 255,
                buttonGreen: 60,
                buttonBlue: 60,
                constraints: constraints,
              ),
              ActionCard(
                bgColor: const Color(0xffD57CFF),
                mainText: "Post about an event or a drive in your area",
                buttonText: "Post",
                png: 'post.png',
                onTap: () {
                  Get.to(() => const PostScreen());
                },
                buttonRed: 193,
                buttonGreen: 61,
                buttonBlue: 255,
                constraints: constraints,
              ),
              constraints.maxWidth < 600
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      height: 2.0,
                      width: double.infinity,
                      color: const Color(0xffD2D2D2),
                    )
                  : const SizedBox(),
              constraints.maxWidth < 600
                  ? EventButton(
                      constraints: constraints,
                      scrollController: eventsScrollController,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.authController,
    required this.databaseController,
  }) : super(key: key);

  final AuthController authController;
  final DatabaseController databaseController;

  @override
  Widget build(BuildContext context) {
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
              Icons.list_alt,
              color: Colors.white,
            ),
            title:
                const Text('My posts', style: TextStyle(color: Colors.white)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
            onTap: () async {
              authController.isLoading.value = true;
              String name =
                  await databaseController.getName(authController.userUID);
              authController.isLoading.value = false;
              Get.to(() => MyPostsScreen(name: name));
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

class EventButton extends StatelessWidget {
  const EventButton(
      {Key? key, required this.constraints, required this.scrollController})
      : super(key: key);
  final BoxConstraints constraints;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20.0, left: 20.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xff637CFF), width: 2.0),
        ),
        tileColor: const Color(0xffFFFFFF),
        title: const Text(
          'Events and drives in your district',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Color(0xff637CFF), fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Color(0xff637CFF),
        ),
        onTap: () {
          Get.to(() => Scaffold(
                backgroundColor: const Color(0xffEFF9FF),
                body: Events(
                  constraints: constraints,
                  scrollController: scrollController,
                ),
              ));
        },
        contentPadding:
            const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.bgColor,
    required this.mainText,
    required this.buttonText,
    required this.onTap,
    required this.png,
    required this.constraints,
    this.buttonRed = 136,
    this.buttonGreen = 99,
    this.buttonBlue = 255,
  }) : super(key: key);

  final Color bgColor;
  final String mainText;
  final String buttonText;
  final void Function()? onTap;
  final int buttonRed;
  final int buttonGreen;
  final int buttonBlue;
  final String png;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 13.0,
                ),
                RectButton(
                  onPressed: onTap,
                  text: buttonText,
                  width: 130.0,
                  padding: 5.0,
                  red: buttonRed,
                  green: buttonGreen,
                  blue: buttonBlue,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
                child: Image.asset(
              png,
              height: constraints.maxWidth >= 1250 ? 100.0 : 70.0,
              filterQuality: FilterQuality.medium,
            )),
          )
        ],
      ),
    );
  }
}

class Events extends StatelessWidget {
  const Events(
      {Key? key, required this.constraints, required this.scrollController})
      : super(key: key);
  final BoxConstraints constraints;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    RxString searchedTerm = ''.obs;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
              right: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
              left: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
              bottom: constraints.maxWidth >= 1024 ? 25.0 : 20.0),
          child: TextField(
            decoration: textFieldDecoration('Search', null),
            onChanged: (value) {
              searchedTerm.value = value.trim().toLowerCase();
            },
          ),
        ),
        Container(
          height: 2.0,
          width: double.infinity,
          color: const Color(0xffD2D2D2),
        ),
        Container(
          padding: EdgeInsets.only(
              top: constraints.maxWidth >= 1024 ? 30.0 : 20.0,
              right: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
              left: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
              bottom: constraints.maxWidth >= 1024 ? 30.0 : 20.0),
          child: const Text(
            'Upcoming events and drives in your district:',
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

              if (databaseController.userState.value == 'none' &&
                  databaseController.userDistrict.value == 'none') {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Some error ocurred at the servers'),
                );
              }

              var events = snapshot.data.docs;
              List<EventCard> eventsList = [];
              if (events == null) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Some error ocurred at the servers'),
                );
              } else {
                for (var event in events) {
                  Map<String, dynamic> data =
                      event.data() as Map<String, dynamic>;
                  if (data['state'] == databaseController.userState.value &&
                      data['district'] ==
                          databaseController.userDistrict.value) {
                    eventsList.add(EventCard(
                      title: data['title'],
                      description: data['description'],
                      date: data['date'],
                      venue: data['venue'],
                      host: data['host'],
                      contact: data['contact'],
                      author: data['author'],
                      authorMail: data['authorMail'],
                      searchedTerm: searchedTerm,
                      constraints: constraints,
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
                controller: scrollController,
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

class EventCard extends StatelessWidget {
  const EventCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.date,
      required this.venue,
      required this.host,
      required this.contact,
      required this.author,
      required this.authorMail,
      required this.searchedTerm,
      required this.constraints})
      : super(key: key);

  final String title,
      description,
      date,
      venue,
      host,
      contact,
      author,
      authorMail;
  final RxString searchedTerm;
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
    return Obx(() => (title.toLowerCase().contains(searchedTerm.value) ||
            description.toLowerCase().contains(searchedTerm.value) ||
            date.toLowerCase().contains(searchedTerm.value) ||
            venue.toLowerCase().contains(searchedTerm.value) ||
            host.toLowerCase().contains(searchedTerm.value) ||
            author.toLowerCase().contains(searchedTerm.value))
        ? Container(
            margin: EdgeInsets.only(
                bottom: constraints.maxWidth >= 1024 ? 30.0 : 20.0,
                right: constraints.maxWidth >= 1024 ? 50.0 : 20.0,
                left: constraints.maxWidth >= 1024 ? 50.0 : 20.0),
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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Contact: +91- ' + contact,
                        maxLines: contactMaxLine.value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xff31508C),
                            height: 1.5,
                            fontSize: 16.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: contact));
                      },
                      child: const Icon(Icons.content_copy,
                          color: Color(0xff637CFF)),
                    )
                  ],
                ),
                Text(
                  'Posted by: ' + author,
                  maxLines: authorMaxLine.value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Color(0xff31508C), height: 1.5, fontSize: 16.0),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Email id: ' + authorMail,
                        maxLines: authorMailMaxLine.value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xff31508C),
                            height: 1.5,
                            fontSize: 16.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: authorMail));
                      },
                      child: const Icon(Icons.content_copy,
                          color: Color(0xff637CFF)),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
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
                  width: 130.0,
                  padding: 5.0,
                )
              ],
            ),
          )
        : const SizedBox());
  }
}
