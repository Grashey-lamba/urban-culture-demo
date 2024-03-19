import 'package:get/get.dart';
import 'package:urban_culture/modules/routine/view/routine_screen.dart';
import 'package:urban_culture/modules/streak/view/streak_screen.dart';

class DashboardController extends GetxController {
  var pages = [RoutineScreen(), StreakScreen()];
  RxInt currentIndex = 0.obs;

  updateIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
