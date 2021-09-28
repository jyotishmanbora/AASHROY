import 'package:aashroy/components.dart';
import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/utils/capitalize_name.dart';
import 'package:aashroy/utils/states_districts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {Key? key,
      required this.isNewUser,
      this.name = '',
      this.type = '',
      this.stateName = '',
      this.districtName = ''})
      : super(key: key);

  final bool isNewUser;
  final String name, type, stateName, districtName;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    DatabaseController databaseController = Get.find<DatabaseController>();
    TextEditingController nameController = TextEditingController();
    var userType = type.obs;
    var state = stateName.obs;
    var district = districtName.obs;
    if (name != '') {
      nameController.text = name;
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
                      padding: const EdgeInsets.symmetric(horizontal: 200.0),
                      child: FormColumn(
                        nameController: nameController,
                        userType: userType,
                        state: state,
                        district: district,
                        authController: authController,
                        databaseController: databaseController,
                        isNewUser: isNewUser,
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
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: FormColumn(
                        nameController: nameController,
                        userType: userType,
                        state: state,
                        district: district,
                        authController: authController,
                        databaseController: databaseController,
                        isNewUser: isNewUser,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (constraints.maxWidth >= 600) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
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
                  const Expanded(
                    flex: 4,
                    child: Brand(),
                  ),
                  Expanded(
                    flex: 5,
                    child: FormColumn(
                      nameController: nameController,
                      userType: userType,
                      state: state,
                      district: district,
                      mainAxisAlignment: MainAxisAlignment.center,
                      authController: authController,
                      databaseController: databaseController,
                      isNewUser: isNewUser,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xffEFF9FF),
                    Color(0xffF1EDFF),
                  ])),
              child: FormColumn(
                nameController: nameController,
                userType: userType,
                state: state,
                district: district,
                authController: authController,
                databaseController: databaseController,
                isNewUser: isNewUser,
              ),
            );
          }
        },
      ),
    );
  }
}

class FormColumn extends StatelessWidget {
  const FormColumn(
      {Key? key,
      required this.nameController,
      required this.userType,
      required this.state,
      required this.district,
      required this.authController,
      required this.databaseController,
      required this.isNewUser,
      this.mainAxisAlignment = MainAxisAlignment.center})
      : super(key: key);

  final TextEditingController nameController;
  final RxString userType;
  final RxString state;
  final RxString district;
  final MainAxisAlignment mainAxisAlignment;
  final AuthController authController;
  final DatabaseController databaseController;
  final bool isNewUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextField(
          controller: nameController,
          maxLines: 1,
          onChanged: (value) {
            nameController.text = capitalizeName(nameController.text);
            nameController.selection = TextSelection.fromPosition(
                TextPosition(offset: nameController.text.length));
          },
          decoration: const InputDecoration(
            label: Text('Your Name'),
            floatingLabelStyle: TextStyle(color: Color(0xff637CFF)),
            fillColor: Color.fromRGBO(99, 124, 255, 0.2),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          ),
          cursorColor: const Color(0xff637CFF),
        ),
        const SizedBox(height: 20.0),
        Obx(() => DropdownButton<String>(
              isExpanded: true,
              hint: const Text('I am joining as an'),
              value: userType.value == '' ? null : userType.value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                userType.value = newValue!;
              },
              items: <String>['Individual', 'Organization']
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
              hint: const Text('My State'),
              value: state.value == '' ? null : state.value,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                state.value = newValue!;
                district.value = '';
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
              hint: const Text('My District'),
              value: district.value == '' ? null : district.value,
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
        Obx(() => authController.isLoading.value
            ? loader
            : RectButton(
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    Get.snackbar('Error', 'Name cannot be empty');
                  } else if (userType.value.isEmpty) {
                    Get.snackbar('Error', 'User type not selected');
                  } else if (state.value.isEmpty) {
                    Get.snackbar('Error', 'State not selected');
                  } else if (district.value.isEmpty) {
                    Get.snackbar('Error', 'District not selected');
                  } else {
                    databaseController.setUserInfo(
                        isNewUser,
                        nameController.text,
                        userType.value,
                        state.value,
                        district.value,
                        authController);
                  }
                },
                text: 'Save',
                width: 130.0,
                padding: 10.0)),
      ],
    );
  }
}
