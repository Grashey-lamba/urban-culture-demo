import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/modules/dashboard/controller/dashboard_controller.dart';
import 'package:urban_culture/utils/colors.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          // height: 70,
          decoration: BoxDecoration(
            color: bgcolor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      controller.updateIndex(0);
                    },
                    color: controller.currentIndex.value == 0 ? primaryColor : Colors.grey,
                  ),
                  Text(
                    'Routine',
                    style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: controller.currentIndex.value == 0 ? primaryColor : Colors.black54),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.person_outline),
                    onPressed: () => controller.updateIndex(1),
                    color: controller.currentIndex.value == 1 ? primaryColor : Colors.black54,
                  ),
                  Text(
                    'Streaks',
                    style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: controller.currentIndex.value == 1 ? primaryColor : Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
