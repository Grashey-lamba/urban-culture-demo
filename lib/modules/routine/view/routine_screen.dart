import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/modules/routine/controller/routine_controller.dart';
import 'package:urban_culture/utils/colors.dart';
import 'package:urban_culture/utils/storage.dart';

import '../../skincare inputs/controller/product_input_controller.dart';

class RoutineScreen extends StatefulWidget {
  RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  bool isChecked = false;
  final controller = Get.put(RoutineController());

  @override
  void initState() {
    super.initState();
    print(getData('uid'));
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: SafeArea(child: GetBuilder<RoutineController>(
        builder: (cont) {
          if (!controller.isDataLoaded) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // var products = controller.products;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Center(
                  child: Text(
                    'Daily Skincare',
                    style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w700, fontSize: 18.0, color: Color(0xff1C0D12)),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "What specific skincare routine did you follow today?",
                  style: GoogleFonts.epilogue(
                      fontWeight: FontWeight.w400, fontSize: 16.0, color: Color(0xff1C0D12)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.productList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // var product = products?['productList'];
                      // print("products:: ${products}");
                      return ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            controller.toggleChecked(index);
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: controller.isChecked(index)
                                  ? Color(0xFFF2E8EB)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    controller.isChecked(index) ? Colors.transparent : Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: controller.isChecked(index)
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  )
                                : null,
                          ),
                        ),
                        title: Text(
                          controller.productList[index].type ?? "",
                          style: GoogleFonts.epilogue(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: Color(0xff1C0D12)),
                        ),
                        subtitle: Text(
                          controller.productList[index].name ?? "",
                          // products?[index]['name'] ?? 'Cetaphil Gentle Skin Cleanser',
                          style: GoogleFonts.epilogue(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              height: 1.5,
                              color: primaryColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.pickImage(index);
                              },
                              child: Image.asset(
                                'assets/camera.png',
                                height: 27,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${DateTime.now().hour.toString()}: ${DateTime.now().minute.toString()}",
                              style: GoogleFonts.epilogue(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  height: 1.5,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 45,
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.submitSkincareRoutine();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      // padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shadowColor: const Color(0xff1C0D12),
                    ),
                    child: controller.isLoading
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color: Colors.white),
                            ),
                          )
                        : Text(
                            "Submit",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                // Expanded(
                //   child: StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection('skincare')
                //         .doc(getData('uid'))
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       }
                //       var products = snapshot.data?.data()?['productList'];

                //       return ListView.builder(
                //         itemCount: products?.length,
                //         itemBuilder: (context, index) {
                //           // var product = products?['productList'];
                //           print("products:: ${products}");
                //           return ListTile(
                //             leading: GestureDetector(
                //               onTap: () {
                //                 setState(() {
                //                   isChecked = !isChecked;
                //                 });
                //               },
                //               child: Container(
                //                 width: 48,
                //                 height: 48,
                //                 decoration: BoxDecoration(
                //                   color: isChecked ? Color(0xFFF2E8EB) : Colors.transparent,
                //                   borderRadius: BorderRadius.circular(8),
                //                   border: Border.all(
                //                     color: isChecked ? Colors.transparent : Colors.black,
                //                     width: 1.0,
                //                   ),
                //                 ),
                //                 child: isChecked
                //                     ? const Icon(
                //                         Icons.check,
                //                         color: Colors.black,
                //                       )
                //                     : null,
                //               ),
                //             ),
                //             title: Text(
                //               'Cleanser',
                //               style: GoogleFonts.epilogue(
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 16.0,
                //                   color: Color(0xff1C0D12)),
                //             ),
                //             subtitle: Text(
                //               products?[index]['name'] ?? 'Cetaphil Gentle Skin Cleanser',
                //               style: GoogleFonts.epilogue(
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: 14.0,
                //                   height: 1.5,
                //                   color: primaryColor),
                //             ),
                //             trailing: Row(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     controller.pickImage(index);
                //                   },
                //                   child: Image.asset(
                //                     'assets/camera.png',
                //                     height: 27,
                //                     fit: BoxFit.cover,
                //                   ),
                //                 ),
                //                 SizedBox(width: 8),
                //                 Text(
                //                   "${DateTime.now().hour.toString()}: ${DateTime.now().minute.toString()}",
                //                   style: GoogleFonts.epilogue(
                //                       fontWeight: FontWeight.w400,
                //                       fontSize: 14.0,
                //                       height: 1.5,
                //                       color: primaryColor),
                //                 ),
                //               ],
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          );
        },
      )),
    );
  }
}
