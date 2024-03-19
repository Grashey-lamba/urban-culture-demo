import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/modules/splash/controller/splash_controller.dart';
import 'package:urban_culture/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Spacer(),
            SizedBox(
              width: 250,
              height: 250,
              child: ClipOval(
                child: Image.asset(
                  'assets/img.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'URBAN CULTURE',
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                textStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "INDIA'S 2ND LARGEST HOME SALON",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: primaryColor,
                letterSpacing: 0.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
