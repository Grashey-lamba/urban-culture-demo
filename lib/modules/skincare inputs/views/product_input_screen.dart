import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urban_culture/modules/skincare%20inputs/controller/product_input_controller.dart';
import 'package:urban_culture/modules/skincare%20inputs/widgets/product_input_field_widget.dart';
import 'package:urban_culture/utils/colors.dart';

class ProductInputScreen extends StatefulWidget {
  const ProductInputScreen({super.key});

  @override
  State<ProductInputScreen> createState() => _ProductInputScreenState();
}

class _ProductInputScreenState extends State<ProductInputScreen> {
  String? selectedFaceWash;
  final controller = Get.put(ProductInputController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<ProductInputController>(builder: (cont) {
          return Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                width: 180,
                height: 180,
                child: ClipOval(
                  child: Image.asset(
                    'assets/img.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Hey Gorgeous! 🌟\nSelect your daily essentials from the dropdown menu below to unlock your personalized beauty journey!',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                // 'Enhance your daily skincare ritual with a carefully chosen face wash.',
                controller.getProductMessage(controller.products[controller.currentIndex.value]),
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 30),
              ProductInputFieldWidget(
                controller: controller,
              ),
              const Spacer(),

              //* ____________________________________________[Submit Btn]_________________________________________________
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.currentIndex.value == 4) {
                      List<Map<String, dynamic>> productListMap = [
                        {
                          "type": "Cleanser",
                          "name": controller.selectedFaceWash,
                        },
                        {
                          "type": "Toner",
                          "name": controller.selectedToner,
                        },
                        {
                          "type": "Moisturizer",
                          "name": controller.selectedMoisturizer,
                        },
                        {
                          "type": "Sunscream",
                          "name": controller.selectedSunscream,
                        },
                        {
                          "type": "Lip Balm",
                          "name": controller.selectedLipbalm,
                        },
                      ];

                      controller.submitProductsData(productListMap);
                    }
                    if (!(controller.isNotValidate.value) && controller.currentIndex.value < 4) {
                      controller.updateCurrentIndex(controller.currentIndex.value + 1);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shadowColor: const Color(0xff1C0D12),
                  ),
                  child: Text(
                    controller.currentIndex.value == 4 ? "Submit" : 'Next',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
