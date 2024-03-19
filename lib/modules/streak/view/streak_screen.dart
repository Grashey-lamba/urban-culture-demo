import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/modules/streak/controller/streak_controller.dart';

class StreakScreen extends StatefulWidget {
  StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  final controller = Get.put(StreakController());
  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Center(
                  child: Text(
                    'Streaks',
                    style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                        color: const Color(0xff1C0D12)),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Today's Goal: 3 streak days",
                  style: GoogleFonts.epilogue(
                      fontWeight: FontWeight.w700, fontSize: 21.0, color: const Color(0xff1C0D12)),
                ),
                const SizedBox(height: 16),
                Container(
                  width: Get.width,
                  // height: 110,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xffF2E8EB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Streak Days',
                        style: GoogleFonts.epilogue(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: const Color(0xff1C0D12)),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          controller.streakCount.value.toString() ?? '2',
                          style: GoogleFonts.epilogue(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0,
                              color: const Color(0xff1C0D12)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Streak Days',
                  style: GoogleFonts.epilogue(
                      fontWeight: FontWeight.w500, fontSize: 16.0, color: const Color(0xff1C0D12)),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    controller.streakCount.value.toString() ?? '2',
                    style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w700,
                        fontSize: 32.0,
                        color: const Color(0xff1C0D12)),
                  ),
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Last 30 Days ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF964F66),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '+100%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF088759),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: Get.width,
                  // height: 180,
                  child: Image.asset(
                    'assets/chart.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Keep it up! You're on a roll.",
                  style: GoogleFonts.epilogue(
                      fontWeight: FontWeight.w400, fontSize: 16.0, color: const Color(0xff1C0D12)),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: Get.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: const Color(0xffF2E8EB),
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.epilogue(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                          color: const Color(0xff1C0D12)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
