import 'package:aashroy/components.dart';
import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/screens/set_location.dart';
import 'package:aashroy/screens/user_posts.dart';
import 'package:aashroy/utils/states_districts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SheltersScreen extends StatelessWidget {
  const SheltersScreen({Key? key, required this.userName}) : super(key: key);
  final String userName;

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
                          child: ShelterCards(
                              constraints: constraints, userName: userName),
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
                    child: ShelterCards(
                        constraints: constraints, userName: userName),
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
                  child: ShelterCards(
                      constraints: constraints, userName: userName),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ShelterCards extends StatelessWidget {
  const ShelterCards(
      {Key? key, required this.constraints, required this.userName})
      : super(key: key);
  final BoxConstraints constraints;
  final String userName;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SetLocation());
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          'Add new',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.deepPurple),
                      padding: MaterialStateProperty.resolveWith(
                          (states) => const EdgeInsets.all(10.0)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
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
              const SizedBox(height: 20.0),
              const Text(
                'You can verify authenticity of a shelter by upvoting or downvoting on it.',
                style: TextStyle(
                  color: Color(0xff476DB5),
                ),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'Shelters:',
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
            stream: databaseController.getShelterStream(),
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
                var shelters = snapshot.data.docs;
                List<ShelterCard> sheltersList = [];
                if (shelters == null) {
                  return Padding(
                    padding: EdgeInsets.all(
                        constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                    child: const Text('Some error ocurred at the servers'),
                  );
                } else {
                  for (var shelter in shelters) {
                    Map<String, dynamic> data =
                        shelter.data() as Map<String, dynamic>;
                    sheltersList.add(ShelterCard(
                        address: data['address'],
                        pin: data['pin'],
                        population: data['population'],
                        description: data['description'],
                        upVoters: data['upVoters'],
                        downVoters: data['downVoters'],
                        constraints: constraints,
                        documentId: shelter.id,
                        author: data['author'],
                        authorMail: data['authorMail'],
                        userName: userName,
                        state: data['state'],
                        district: data['district'],
                        stateOBS: state,
                        districtOBS: district));
                  }

                  if (sheltersList.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(
                          constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                      child: const Text('No data found in your district!'),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return sheltersList[index];
                    },
                    itemCount: sheltersList.length,
                    padding: EdgeInsets.all(
                        constraints.maxWidth >= 1024 ? 50.0 : 20.0),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

class ShelterCard extends StatelessWidget {
  const ShelterCard(
      {Key? key,
      required this.address,
      required this.pin,
      required this.population,
      required this.description,
      required this.upVoters,
      required this.downVoters,
      required this.constraints,
      required this.documentId,
      required this.author,
      required this.authorMail,
      required this.userName,
      required this.state,
      required this.district,
      required this.stateOBS,
      required this.districtOBS})
      : super(key: key);
  final String address,
      pin,
      population,
      description,
      documentId,
      author,
      authorMail,
      userName,
      state,
      district;
  final List upVoters, downVoters;
  final BoxConstraints constraints;
  final RxString stateOBS, districtOBS;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    AuthController authController = Get.find<AuthController>();
    var upVoteCount = upVoters.length.obs;
    var downVoteCount = downVoters.length.obs;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              'Address: $address',
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff31508C),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: address));
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
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Pin code: $pin',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff31508C),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: pin));
                            },
                            child: const Icon(Icons.content_copy,
                                color: Color(0xff637CFF)),
                          ),
                        ],
                      ),
                      Text(
                        'Population (approx.): $population',
                        maxLines: 2,
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
                      userName == author &&
                              authController.userEmail == authorMail
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => SetLocation(
                                          address: address,
                                          pin: pin,
                                          population: population,
                                          description: description,
                                          documentId: documentId,
                                          district: district,
                                          state: state,
                                        ));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Color(0xff637CFF),
                                  ),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    Get.back();
                                                    await databaseController
                                                        .deleteShelterInfo(
                                                            documentId,
                                                            authController);
                                                  },
                                                  child: const Text(
                                                    'Sure',
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                  style: ButtonStyle(
                                                    padding: MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical:
                                                                    20.0)),
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
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                  style: ButtonStyle(
                                                    padding: MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical:
                                                                    20.0)),
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
                            )
                          : const SizedBox(),
                      userName == author &&
                              authController.userEmail == authorMail
                          ? const SizedBox(height: 20.0)
                          : const SizedBox(),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: userName == author &&
                                        authController.userEmail == authorMail
                                    ? null
                                    : () async {
                                        await databaseController.upVote(
                                            documentId,
                                            authController.userUID,
                                            upVoters,
                                            downVoters,
                                            authController);
                                      },
                                child: Text(
                                  '${upVoteCount.value} - Upvote',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => const Color(0xffE1E5FF)),
                                ),
                              ),
                              authController.isLoading.value
                                  ? loader
                                  : const SizedBox(),
                            ],
                          )),
                      const SizedBox(height: 10.0),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: userName == author &&
                                        authController.userEmail == authorMail
                                    ? null
                                    : () async {
                                        await databaseController.downVote(
                                            documentId,
                                            authController.userUID,
                                            upVoters,
                                            downVoters,
                                            authController);
                                      },
                                child: Text(
                                  '${downVoteCount.value} - Downvote',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => const Color(0xffE1E5FF)),
                                ),
                              ),
                              authController.isLoading.value
                                  ? loader
                                  : const SizedBox(),
                            ],
                          )),
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
