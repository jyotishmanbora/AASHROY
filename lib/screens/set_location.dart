import 'package:aashroy/constants.dart';
import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/controllers/database_controller.dart';
import 'package:aashroy/utils/states_districts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components.dart';

class SetLocation extends StatelessWidget {
  const SetLocation(
      {Key? key,
      this.address = '',
      this.pin = '',
      this.population = '',
      this.description = '',
      this.documentId = '',
      this.district = 'none',
      this.state = 'none'})
      : super(key: key);
  final String address,
      pin,
      population,
      description,
      documentId,
      state,
      district;

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
                            child: ShelterForm(
                                address: address,
                                population: population,
                                description: description,
                                documentId: documentId,
                                district: district.obs,
                                state: state.obs,
                                horizontalPadding: 130.0,
                                verticalPadding: 40.0,
                                pin: pin),
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
                            child: ShelterForm(
                                address: address,
                                population: population,
                                description: description,
                                documentId: documentId,
                                district: district.obs,
                                state: state.obs,
                                horizontalPadding: 80.0,
                                verticalPadding: 30.0,
                                pin: pin),
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
                    child: ShelterForm(
                        address: address,
                        population: population,
                        description: description,
                        documentId: documentId,
                        district: district.obs,
                        state: state.obs,
                        horizontalPadding: 150.0,
                        verticalPadding: 30.0,
                        pin: pin),
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
                    child: ShelterForm(
                        address: address,
                        population: population,
                        description: description,
                        documentId: documentId,
                        district: district.obs,
                        state: state.obs,
                        horizontalPadding: 30.0,
                        verticalPadding: 30.0,
                        pin: pin),
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

class ShelterForm extends StatelessWidget {
  const ShelterForm(
      {Key? key,
      required this.address,
      required this.population,
      required this.description,
      required this.documentId,
      required this.district,
      required this.state,
      required this.horizontalPadding,
      required this.verticalPadding,
      required this.pin})
      : super(key: key);
  final String address, pin, population, description, documentId;
  final RxString state, district;
  final double horizontalPadding, verticalPadding;

  @override
  Widget build(BuildContext context) {
    DatabaseController databaseController = Get.find<DatabaseController>();
    AuthController authController = Get.find<AuthController>();
    TextEditingController addressController = TextEditingController();
    addressController.text = address;
    TextEditingController pinController = TextEditingController();
    pinController.text = pin;
    TextEditingController populationController = TextEditingController();
    populationController.text = population;
    TextEditingController descriptionController = TextEditingController();
    descriptionController.text = description;
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        children: [
          TextField(
            controller: addressController,
            decoration:
                postScreenTextFieldDecoration('Shelter Address/Location'),
            minLines: 1,
            maxLines: null,
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            decoration: postScreenTextFieldDecoration('Pin code'),
            maxLines: 1,
            maxLength: 6,
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: populationController,
            keyboardType: TextInputType.number,
            decoration: postScreenTextFieldDecoration('Population (approx.)'),
            maxLines: 1,
            cursorColor: const Color(0xff637CFF),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: postScreenTextFieldDecoration('Description'),
            maxLines: null,
            minLines: 4,
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
          const SizedBox(height: 40),
          Obx(() => authController.isLoading.value
              ? loader
              : Center(
                  child: RectButton(
                    text: 'Save',
                    width: 130.0,
                    padding: 10.0,
                    onPressed: () async {
                      if (addressController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Address/Location cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (populationController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Population cannot be empty',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white,
                        );
                      } else if (int.parse(pinController.text) < 110001) {
                        Get.snackbar(
                          'Error',
                          'Insert a valid pin code',
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
                        await databaseController.setShelter(
                            documentId,
                            state.value,
                            district.value,
                            addressController.text,
                            populationController.text,
                            descriptionController.text,
                            pinController.text,
                            authController);
                      }
                    },
                  ),
                )),
        ],
      ),
    );
  }
}
