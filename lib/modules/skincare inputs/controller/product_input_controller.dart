// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_culture/modules/dashboard/view/dashboard.dart';
import 'package:urban_culture/routes/route_endpoints.dart';
import 'package:urban_culture/utils/storage.dart';

class ProductInputController extends GetxController {
  RxBool isNotValidate = false.obs;
  String? selectedFaceWash;
  String? selectedToner;
  String? selectedMoisturizer;
  String? selectedSunscream;
  String? selectedLipbalm;
  RxInt currentIndex = 0.obs;
  List<Map<String, dynamic>>? selectedValues;
  List<BeautyProduct> products = [
    BeautyProduct.FaceWash,
    BeautyProduct.Toner,
    BeautyProduct.Moisturizer,
    BeautyProduct.Sunscream,
    BeautyProduct.LipBalm,
  ];

  // void setShowErrorValue(bool value) {
  //   showError = value;
  //   update();
  // }

//__________________________________[FIREBASE SECTION]_____________________________________________

  submitProductsData(List<Map<String, dynamic>> productListMap) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('user').add({'productList': productListMap});
    String id = docRef.id;
    setData("uid", id);
    setData("registered", true);
    DateTime today = DateTime.now();

    await FirebaseFirestore.instance.collection('user').doc(id).collection('user_streak').add({
      'uid': id,
      'lastVisitedDate': today,
      'streakCount': 1,
    });

    print("--------------------------${getData('uid')}----------------");
    // Get.to(Dashboard());
    Get.toNamed(dashboard);
    update();
  }

//_______________________________________________________________________________
//* setting value
  void setSelectedFacewash({String? facewash}) {
    selectedFaceWash = facewash;
    update();
  }

  void setSelectedToner({String? toner}) {
    selectedToner = toner;
    update();
  }

  void setSelectedMoisturizer({String? moisturizer}) {
    selectedMoisturizer = moisturizer;
    update();
  }

  void setSelectedSunscream({String? sunscream}) {
    selectedSunscream = sunscream;
    update();
  }

  void setSelectedLipbalm({String? lipbalm}) {
    selectedLipbalm = lipbalm;
    update();
  }

  void updateCurrentIndex(int value) {
    currentIndex.value = value;
    update();
    print("current index is $currentIndex");
  }

  void addSelectedValues({required String key, required String value}) {
    Map<String, dynamic> data = {key: value};
    selectedValues?.add(data);
    update();
  }

  Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Function to get error message for selected product
  String getErrorMessage() {
    switch (currentIndex.value) {
      case 0:
        return "*Please select a face wash.";
      case 1:
        return "*Please select a toner.";
      case 2:
        return "*Please select a moisturizer.";
      case 3:
        return "*Please select a sunscreen.";
      case 4:
        return "*Please select a lip balm.";
      default:
        return "";
    }
  }

  bool showerror() {
    switch (currentIndex.value) {
      case 0:
        return isNotValidate.value = selectedFaceWash != null ? false : true;
      case 1:
        return isNotValidate.value = selectedToner != null ? false : true;
      case 2:
        return isNotValidate.value = selectedMoisturizer != null ? false : true;
      case 3:
        return isNotValidate.value = selectedSunscream != null ? false : true;
      case 4:
        return isNotValidate.value = selectedLipbalm != null ? false : true;
      default:
        return isNotValidate.value = false;
    }
  }

  List<String> getProductList() {
    switch (products[currentIndex.value]) {
      case BeautyProduct.FaceWash:
        return faceWashes;
      case BeautyProduct.Toner:
        return tonerList;
      case BeautyProduct.Moisturizer:
        return moisturizerList;
      case BeautyProduct.Sunscream:
        return sunscreenList;
      case BeautyProduct.LipBalm:
        return lipBalmList;
      default:
        return [];
    }
  }

  String? getSelectitem() {
    switch (products[currentIndex.value]) {
      case BeautyProduct.FaceWash:
        return selectedFaceWash;
      case BeautyProduct.Toner:
        return selectedToner;
      case BeautyProduct.Moisturizer:
        return selectedMoisturizer;
      case BeautyProduct.Sunscream:
        return selectedSunscream;
      case BeautyProduct.LipBalm:
        return selectedLipbalm;
      default:
        return "";
    }
  }

  String getProductMessage(BeautyProduct product) {
    switch (product) {
      case BeautyProduct.FaceWash:
        return "Using a face wash regularly can improve the appearance of the skin, making it look cleaner, brighter, and more youthful";
      case BeautyProduct.Toner:
        return "Toner can help to tighten enlarged pores, giving the skin a smoother appearance.";
      case BeautyProduct.Moisturizer:
        return "Well-hydrated skin appears more radiant and youthful, as moisturizers help to plump up the skin and minimize the appearance of fine lines and wrinkles.";
      case BeautyProduct.Sunscream:
        return "Sunscreen helps to prevent hyperpigmentation and uneven skin tone caused by sun exposure, such as sunspots and melasma";
      case BeautyProduct.LipBalm:
        return "Lip balm helps to prevent dry, cracked, and flaky lips, keeping them soft, smooth, and supple..";
      default:
        return "";
    }
  }
}

enum BeautyProduct {
  FaceWash,
  Toner,
  Moisturizer,
  Sunscream,
  LipBalm,
}

List<String> tonerList = [
  'Rosewater Toner',
  'Witch Hazel Toner',
  'Aloe Vera Toner',
  'Green Tea Toner',
  'Apple Cider Vinegar Toner',
  'Chamomile Toner',
  'Cucumber Toner',
  'Glycolic Acid Toner',
  'Hyaluronic Acid Toner',
  'Tea Tree Oil Toner',
];

List<String> moisturizerList = [
  'Nivea Soft Moisturizing Cream',
  'Pond\'s Moisturizing Cold Cream',
  'Himalaya Herbals Nourishing Skin Cream',
  'Neutrogena Hydro Boost Water Gel',
  'Cetaphil Moisturizing Cream',
  'Lakmé Absolute Skin Gloss Gel Crème',
  'VLCC Honey Moisturizer',
  'Lotus Herbals Alphamoist Alpha Hydroxy Skin Renewal Oil-Free Moisturizer',
  'Olay Regenerist Micro-Sculpting Cream',
  'Biotique Morning Nectar Flawless Skin Lotion',
];
List<String> sunscreenList = [
  'Neutrogena Ultra Sheer Dry-Touch Sunscreen',
  'Lotus Herbals Safe Sun UV Screen Matte Gel',
  'Lakmé Sun Expert Ultra Matte SPF 50 PA+++ Gel Sunscreen',
  'Biotique Bio Sandalwood Sunscreen Ultra Soothing Face Lotion SPF 50+',
  'VLCC Matte Look Sunscreen Cream SPF 30',
  'Mamaearth Ultra-Light Indian Sunscreen SPF 50 PA+++',
  'Himalaya Herbals Protective Sunscreen Lotion SPF 15',
  'Aroma Magic Sunblock Lotion SPF 30 PA++',
  'Wow Skin Science Anti-Pollution Sunscreen SPF 40 PA+++',
  'Kaya Youth Protect Sunscreen SPF 50',
];
List<String> lipBalmList = [
  'Maybelline New York Baby Lips Lip Balm',
  'Nivea Lip Care Essential Lip Balm',
  'Himalaya Herbals Natural Soft Vanilla Lip Care',
  'Vaseline Lip Therapy Petroleum Jelly',
  'Burt\'s Bees Beeswax Lip Balm',
  'Lotus Herbals Lip Therapy Cherry',
  'Forest Essentials Luscious Sugared Rose Petal Lip Balm',
  'Neutrogena Norwegian Formula Lip Moisturizer SPF 15',
  'The Body Shop Vitamin E Lip Care SPF 15',
  'Palmer\'s Cocoa Butter Formula Swivel Stick',
];
List<String> faceWashes = [
  "Himalaya Herbals Purifying Neem Face Wash",
  "Pond's White Beauty Daily Spotless Lightening Face Wash",
  "Garnier Skin Naturals Light Complete Fairness Face Wash",
  "Neutrogena Oil-Free Acne Wash",
  "Cetaphil Gentle Skin Cleanser",
  "VLCC Ayurveda Deep Pore Cleansing & Brightening Haldi & Tulsi Face Wash",
  "Patanjali Neem & Tulsi Face Wash",
  "Lakmé Blush & Glow Strawberry Gel Face Wash",
  "Nivea Milk Delights Fine Gramflour Face Wash",
  "Lotus Herbals Teatreewash Tea Tree & Cinnamon Anti-Acne Oil Control Face Wash",
  "Biotique Bio Neem Purifying Face Wash",
  "Clean & Clear Foaming Face Wash",
  "Dove Deep Pure Oil Control Face Wash",
  "Fair & Lovely Multivitamin Daily Fairness Expert Face Wash",
  "L'Oréal Paris Men Expert White Active Bright Face Wash",
  "Ayush Anti Pimple Turmeric Face Wash",
  "Mamaearth Ubtan Face Wash with Turmeric & Saffron for Tan Removal",
  "Wow Skin Science Apple Cider Vinegar Foaming Face Wash",
  "Khadi Natural Herbal Neem Face Wash",
  "Jovees Tea Tree Oil Control Face Wash",
];
