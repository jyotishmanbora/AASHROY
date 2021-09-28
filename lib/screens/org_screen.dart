import 'package:aashroy/components.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/user_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrgListScreen extends StatelessWidget {
  const OrgListScreen({Key? key}) : super(key: key);

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
                        Expanded(child: OrgCards(constraints: constraints)),
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
                    child: OrgCards(constraints: constraints),
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
                  child: OrgCards(constraints: constraints),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class OrgCards extends StatelessWidget {
  const OrgCards({Key? key, required this.constraints}) : super(key: key);
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    return StreamBuilder(
      stream: databaseController.getUsersStream(),
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
        if (databaseController.userState.value == 'none' ||
            databaseController.userDistrict.value == 'none') {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Some error ocurred at the servers'),
          );
        } else {
          var users = snapshot.data.docs;
          List<OrgCard> usersList = [];
          if (users == null) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Some error ocurred at the servers'),
            );
          } else {
            for (var user in users) {
              Map<String, dynamic> data = user.data() as Map<String, dynamic>;
              if (data['userType'] == 'Organization' &&
                  data['state'] == databaseController.userState.value &&
                  data['district'] == databaseController.userDistrict.value) {
                usersList.add(OrgCard(
                    name: data['name'],
                    email: data['email'],
                    constraints: constraints));
              }
            }

            if (usersList.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('No organizations found in your district!'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return usersList[index];
              },
              itemCount: usersList.length,
              padding:
                  EdgeInsets.all(constraints.maxWidth >= 1024 ? 50.0 : 20.0),
            );
          }
        }
      },
    );
  }
}

class OrgCard extends StatelessWidget {
  const OrgCard(
      {Key? key,
      required this.name,
      required this.email,
      required this.constraints})
      : super(key: key);
  final String name, email;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                  name,
                  maxLines: 3,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        email,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xff31508C), fontSize: 16.0),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: email));
                      },
                      child: const Icon(Icons.content_copy,
                          color: Color(0xff637CFF)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        constraints.maxWidth >= 600
            ? const Expanded(child: SizedBox())
            : const SizedBox(),
      ],
    );
  }
}
