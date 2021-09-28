import 'package:aashroy/controllers/auth_controller.dart';
import 'package:aashroy/screens/admin_home_screen.dart';
import 'package:aashroy/screens/home_screen.dart';
import 'package:aashroy/utils/date_time_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString userState = 'none'.obs, userDistrict = 'none'.obs;

  Future<void> setStreams(String? uid, RxBool isLoading) async {
    isLoading.value = true;
    userState.value = await getState(uid);
    userDistrict.value = await getDistrict(uid);
    isLoading.value = false;
    Get.offAll(() => const HomeScreen());
  }

  Future<void> setStreamsAdmin(String? uid, RxBool isLoading) async {
    isLoading.value = true;
    userState.value = await getState(uid);
    userDistrict.value = await getDistrict(uid);
    isLoading.value = false;
    Get.offAll(() => const AdminHomeScreen());
  }

  Future<String> getName(String? uid) async {
    String name = 'Error';
    await _firestore
        .collection('userInfo')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        name = (snapshot.data() as dynamic)['name'];
        return name;
      } else {
        return name;
      }
    }).catchError((e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
      return name;
    });
    return name;
  }

  Future<String> getUserType(String? uid) async {
    String userType = '';
    await _firestore
        .collection('userInfo')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        userType = (snapshot.data() as dynamic)['userType'];
        return userType;
      } else {
        return userType;
      }
    }).catchError((e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
      return userType;
    });
    return userType;
  }

  Future<String> getState(String? uid) async {
    String state = '';
    await _firestore
        .collection('userInfo')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        state = (snapshot.data() as dynamic)['state'];
        return state;
      } else {
        return state;
      }
    }).catchError((e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
      return state;
    });
    return state;
  }

  Future<String> getDistrict(String? uid) async {
    String district = '';
    await _firestore
        .collection('userInfo')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        district = (snapshot.data() as dynamic)['district'];
        return district;
      } else {
        return district;
      }
    }).catchError((e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
      return district;
    });
    return district;
  }

  void setUserInfo(bool isNewUser, String name, String userType, String state,
      String district, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore.collection('userInfo').doc(authController.userUID).set({
      'email': authController.userEmail,
      'name': name,
      'userType': userType,
      'state': state,
      'district': district
    }).then((value) {
      if (isNewUser) {
        userState.value = state;
        userDistrict.value = district;
        Get.offAll(() => const HomeScreen());
      } else {
        userState.value = state;
        userDistrict.value = district;
        Get.back();
      }
    }).catchError((e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    });
    authController.isLoading.value = false;
  }

  Future<void> setPostInfo(
      String? postId,
      String title,
      description,
      venue,
      date,
      host,
      contact,
      author,
      authorMail,
      state,
      district,
      int dateInt,
      AuthController authController) async {
    authController.isLoading.value = true;
    if (postId != null) {
      await _firestore.collection('events').doc(postId).set({
        'title': title,
        'description': description,
        'venue': venue,
        'date': date,
        'host': host,
        'contact': contact,
        'author': author,
        'authorMail': authorMail,
        'state': state,
        'district': district,
        'dateInt': dateInt,
      }).then((value) {
        authController.isLoading.value = false;
        Get.back();
      }).catchError((e) {
        authController.isLoading.value = false;
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        );
      });
    } else {
      await _firestore.collection('events').add({
        'title': title,
        'description': description,
        'venue': venue,
        'date': date,
        'host': host,
        'contact': contact,
        'author': author,
        'authorMail': authorMail,
        'state': state,
        'district': district,
        'dateInt': dateInt,
      }).then((value) {
        authController.isLoading.value = false;
        Get.back();
      }).catchError((e) {
        authController.isLoading.value = false;
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
        );
      });
    }
    authController.isLoading.value = false;
  }

  Future<void> deletePost(String uid, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore.collection('events').doc(uid).delete().then((value) {
      authController.isLoading.value = false;
      Get.snackbar(
        'Deleted',
        'Post successfully deleted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }).catchError((e) {
      authController.isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    });
    authController.isLoading.value = false;
  }

  Future<void> addReport(
      AuthController authController,
      String title,
      description,
      state,
      district,
      location,
      contact,
      author,
      authorMail) async {
    authController.isLoading.value = true;
    await _firestore.collection('reports').add({
      'title': title,
      'description': description,
      'state': state,
      'district': district,
      'location': location,
      'contact': contact,
      'author': author,
      'authorMail': authorMail,
      'dateInt': dateTimeToInt(DateTime.now())
    }).then((value) {
      authController.isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        'Report added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }).catchError((e) {
      authController.isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    });
    authController.isLoading.value = false;
  }

  Future<void> setShelter(String documentId, state, district, address,
      population, description, pin, AuthController authController) async {
    authController.isLoading.value = true;
    String name = await getName(authController.userUID);
    if (documentId.isNotEmpty) {
      await _firestore.collection('shelters').doc(documentId).set({
        'address': address,
        'pin': pin,
        'population': population,
        'description': description,
        'state': state,
        'district': district,
        'author': name,
        'authorMail': authController.userEmail,
        'dateInt': dateTimeToInt(DateTime.now()),
        'upVoters': [],
        'downVoters': []
      }).then((value) {
        authController.isLoading.value = false;
        Get.back();
        Get.snackbar('Success', 'Shelter information added successfully',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      }).catchError((e) {
        authController.isLoading.value = false;
        Get.snackbar('Error', e.toString());
      });
    } else {
      await _firestore.collection('shelters').add({
        'address': address,
        'pin': pin,
        'population': population,
        'description': description,
        'state': state,
        'district': district,
        'author': name,
        'authorMail': authController.userEmail,
        'dateInt': dateTimeToInt(DateTime.now()),
        'upVoters': [],
        'downVoters': []
      }).then((value) {
        authController.isLoading.value = false;
        Get.back();
        Get.snackbar('Success', 'Shelter information added successfully',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      }).catchError((e) {
        authController.isLoading.value = false;
        Get.snackbar('Error', e.toString());
      });
    }
    authController.isLoading.value = false;
  }

  Future<void> upVote(String documentId, userUid, List upVoters, downVoters,
      AuthController authController) async {
    authController.isLoading.value = true;
    if (upVoters.contains(userUid)) {
      upVoters.remove(userUid);
    } else if (downVoters.contains(userUid)) {
      downVoters.remove(userUid);
      upVoters.add(userUid);
    } else {
      upVoters.add(userUid);
    }
    await _firestore
        .collection('shelters')
        .doc(documentId)
        .update({'upVoters': upVoters, 'downVoters': downVoters}).then((value) {
      authController.isLoading.value = false;
    }).catchError((e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    });
    authController.isLoading.value = false;
  }

  Future<void> downVote(String documentId, userUid, List upVoters, downVoters,
      AuthController authController) async {
    authController.isLoading.value = true;
    if (downVoters.contains(userUid)) {
      downVoters.remove(userUid);
    } else if (upVoters.contains(userUid)) {
      upVoters.remove(userUid);
      downVoters.add(userUid);
    } else {
      downVoters.add(userUid);
    }
    await _firestore
        .collection('shelters')
        .doc(documentId)
        .update({'upVoters': upVoters, 'downVoters': downVoters}).then((value) {
      authController.isLoading.value = false;
    }).catchError((e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    });
    authController.isLoading.value = false;
  }

  Future<void> deleteShelterInfo(
      String documentId, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore
        .collection('shelters')
        .doc(documentId)
        .delete()
        .then((value) {
      authController.isLoading.value = false;
      Get.snackbar('Success', 'Successfully deleted',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    }).catchError((e) {
      authController.isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    });
    authController.isLoading.value = false;
  }

  Future<void> deleteOldEvents(
      int dateInt, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore
        .collection('events')
        .get()
        .then((QuerySnapshot snapshot) async {
      for (var doc in snapshot.docs) {
        if (doc['dateInt'] < dateInt) {
          await _firestore
              .collection('events')
              .doc(doc.id)
              .delete()
              .then((value) {
            Get.snackbar('Success', 'Successfully deleted',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white);
          }).catchError((e) {
            Get.snackbar('Error', e.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white);
          });
        }
      }
      authController.isLoading.value = false;
    }).catchError((e) {
      authController.isLoading.value = false;
    });
    authController.isLoading.value = false;
  }

  Future<void> deleteOldReports(
      int dateInt, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore
        .collection('reports')
        .get()
        .then((QuerySnapshot snapshot) async {
      for (var doc in snapshot.docs) {
        if (doc['dateInt'] < dateInt) {
          await _firestore
              .collection('reports')
              .doc(doc.id)
              .delete()
              .then((value) {
            Get.snackbar('Success', 'Successfully deleted',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white);
          }).catchError((e) {
            Get.snackbar('Error', e.toString(),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white);
          });
        }
      }
      authController.isLoading.value = false;
    }).catchError((e) {
      authController.isLoading.value = false;
    });
    authController.isLoading.value = false;
  }

  Future<void> deleteOldShelters(
      int dateInt, double ratio, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore
        .collection('shelters')
        .get()
        .then((QuerySnapshot snapshot) async {
      for (var doc in snapshot.docs) {
        if (doc['dateInt'] <= dateInt) {
          if (doc['upVoters'].length / doc['downVoters'].length < ratio) {
            await _firestore
                .collection('shelters')
                .doc(doc.id)
                .delete()
                .then((value) {
              Get.snackbar('Success', 'Successfully deleted',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white);
            }).catchError((e) {
              Get.snackbar('Error', e.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white);
            });
          }
        }
      }
      authController.isLoading.value = false;
    }).catchError((e) {
      authController.isLoading.value = false;
    });
    authController.isLoading.value = false;
  }

  Future<void> deleteReport(
      String documentId, AuthController authController) async {
    authController.isLoading.value = true;
    await _firestore
        .collection('reports')
        .doc(documentId)
        .delete()
        .then((value) {
      authController.isLoading.value = false;
      Get.snackbar(
        'Success',
        'Successfully deleted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    }).catchError((e) {
      authController.isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    });
    authController.isLoading.value = false;
  }

  Stream getEventsStream() {
    return _firestore.collection('events').orderBy('dateInt').snapshots();
  }

  Stream getUsersStream() {
    return _firestore.collection('userInfo').orderBy('name').snapshots();
  }

  Stream getReportsStream() {
    return _firestore
        .collection('reports')
        .orderBy('dateInt', descending: true)
        .snapshots();
  }

  Stream getShelterStream() {
    return _firestore
        .collection('shelters')
        .orderBy('dateInt', descending: true)
        .snapshots();
  }
}
