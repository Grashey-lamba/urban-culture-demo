// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:urban_culture/utils/storage.dart';

class StreakController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxInt streakCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  String? uid = getData('uid');

  void fetchData() async {
    print("fetch data called");
    try {
      QuerySnapshot<Map<String, dynamic>> streakSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('user_streak')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> streakDocSnapshot in streakSnapshot.docs) {
        String documentId = streakDocSnapshot.id;
        Map<String, dynamic> streakData = streakDocSnapshot.data();

        streakCount.value = streakData['streakCount'];
        // String lastVisitedDate = streakData['lastVisitedDate'];

        print("Streak count: ${streakCount.value},  Document ID: $documentId");
      }
      update();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
