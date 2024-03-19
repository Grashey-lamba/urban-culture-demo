import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urban_culture/firebase_options.dart';
import 'package:urban_culture/modules/routine/view/routine_screen.dart';
import 'package:urban_culture/modules/skincare%20inputs/views/product_input_screen.dart';
import 'package:urban_culture/modules/splash/view/splash_screen.dart';
import 'package:urban_culture/routes/pages.dart';
import 'package:urban_culture/routes/route_endpoints.dart';
import 'package:urban_culture/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: bgcolor,
    statusBarColor: primaryColor,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff11071F))),
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff11071F)),
          // useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
      initialRoute: splashScreen,
      getPages: AppRoutes.allPages,
    );
  }
}
