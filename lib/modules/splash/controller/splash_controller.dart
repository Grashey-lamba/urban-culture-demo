// ignore_for_file: avoid_print

import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urban_culture/modules/dashboard/view/dashboard.dart';
import 'package:urban_culture/modules/skincare%20inputs/views/product_input_screen.dart';
import 'package:urban_culture/routes/route_endpoints.dart';
import 'package:urban_culture/utils/storage.dart';

class SplashController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxInt streakCount = 0.obs;

  bool? isRegistered = getData('registered');
  @override
  void onInit() {
    super.onInit();
    isRegistered == true ? updateStreak() : null;
    Future.delayed(Duration(seconds: 5), () {
      isRegistered == true ? Get.toNamed(dashboard) : Get.toNamed(productInputScreen);
    });
  }

  String? uid = getData('uid');
  Future<void> updateStreak() async {
    print("updateStreak called");
    QuerySnapshot<Map<String, dynamic>> streakSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('user_streak')
        .get();
    DateTime? lastVisitedDate;
    DocumentReference? docRef;

    for (QueryDocumentSnapshot<Map<String, dynamic>> userDocSnapshot in streakSnapshot.docs) {
      docRef = userDocSnapshot.reference;
      lastVisitedDate = userDocSnapshot['lastVisitedDate']?.toDate();
      streakCount.value = userDocSnapshot['streakCount'] ?? 0;
      print("streakCount ${streakCount.value} doc ref:::: ${docRef.id}");
    }

    // Checking if last visited date is today
    DateTime today = DateTime.now();
    if (lastVisitedDate != null &&
        lastVisitedDate.year == today.year &&
        lastVisitedDate.month == today.month &&
        lastVisitedDate.day == today.day) {
      // User visited the app today, don't update streak count
      streakCount.value += 2; // added only for testing purpose
      updateStreakData(docRef, today, streakCount.value);
      print("streakCount::::::::: ${streakCount.value}");
    } else {
      // User missed a day, reset streak count
      if (lastVisitedDate != null &&
          lastVisitedDate.year == today.year &&
          lastVisitedDate.month == today.month &&
          lastVisitedDate.day == today.day - 1) {
        // User visited the app yesterday, increment streak count
        streakCount.value++;
        updateStreakData(docRef, today, streakCount.value);

        print("streakCount --------------${streakCount.value}");
      } else {
        streakCount.value = 0;
        updateStreakData(docRef, today, streakCount.value);

        print("streakCount************* ${streakCount.value}");
      }
    }
  }

  void updateStreakData(DocumentReference? docRef, DateTime today, int streakCountValue) async {
    try {
      if (docRef != null) {
        await docRef.update({
          'lastVisitedDate': today,
          'streakCount': streakCountValue,
        });
        print('Data updated successfully.');
      } else {
        print('Document reference is null.');
      }
    } catch (e) {
      print('Error updating data: $e');
    }
  }
}
