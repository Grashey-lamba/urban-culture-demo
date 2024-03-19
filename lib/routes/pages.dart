import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:urban_culture/modules/dashboard/view/dashboard.dart';
import 'package:urban_culture/modules/routine/view/routine_screen.dart';
import 'package:urban_culture/modules/skincare%20inputs/views/product_input_screen.dart';
import 'package:urban_culture/modules/splash/view/splash_screen.dart';
import 'package:urban_culture/modules/streak/view/streak_screen.dart';
import 'package:urban_culture/routes/route_endpoints.dart';

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._internal();

  factory AppRoutes() {
    return _instance;
  }

  AppRoutes._internal();

  static List<GetPage<dynamic>>? allPages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: productInputScreen, page: () => const ProductInputScreen()),
    GetPage(name: routineScreen, page: () => RoutineScreen()),
    GetPage(name: dashboard, page: () => Dashboard()),
    GetPage(name: streakScreen, page: () => StreakScreen()),
  ];
}
