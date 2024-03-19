// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:urban_culture/utils/colors.dart';

import '../../../utils/storage.dart';

class RoutineController extends GetxController {
  RxList<ProductInfo> productList = <ProductInfo>[].obs;
  bool isDataLoaded = false;
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('user').doc(getData('uid')).get();

      var productsData = snapshot.data()?['productList'] ?? [];
      List<ProductInfo> products = productsData
          .map<ProductInfo>((product) => ProductInfo(
                name: product['name'],
                type: product['type'],
              ))
          .toList();
      // List<ProductInfo> products =
      //     productsData.map<ProductInfo>((product) => ProductInfo(name: product['name'])).toList();
      productList.assignAll(products);
      isDataLoaded = true;
      update();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void toggleChecked(int index) {
    productList[index].isChecked = !productList[index].isChecked;
    update();
  }

  bool isChecked(int index) {
    return productList[index].isChecked;
  }

  void pickImage(int index) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Fluttertoast.showToast(
        msg: "Image selected successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      final imageFile = pickedImage.path;
      print('Image Path: ${imageFile}');
      productList[index].imagePath = imageFile;
      update();
    } else {
      Fluttertoast.showToast(
        msg: "Oops, No image selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('No image selected.');
      productList[index].imagePath = null;
      update();
    }
  }

  Future<void> submitSkincareRoutine() async {
    isLoading = true;
    update();
    try {
      String uid = getData('uid');
      if (uid.isNotEmpty) {
        List<Map<String, dynamic>> routineList = await Future.wait(productList.map((product) async {
          String? base64Image;
          String? imageUrl;
          if (product.imagePath != null) {
            File imageFile = File(product.imagePath!);
            String imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
            firebase_storage.Reference ref =
                firebase_storage.FirebaseStorage.instance.ref('/images/$imageName');

            firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
            await Future.value(uploadTask);
            imageUrl = await ref.getDownloadURL();
            print("-----------newurl $imageUrl----------------");
            // Get download URL of uploaded image
            // imageUrl = await ref.getDownloadURL();
            // File imageFile = File(product.imagePath!);
            // List<int> imageBytes = imageFile.readAsBytesSync();
            // base64Image = base64Encode(imageBytes);
          }
          return {
            'type': product.type,
            'name': product.name,
            'isUsed': product.isChecked,
            'createdAt': Timestamp.now(),
            'image': imageUrl, // Include base64 encoded image
          };
        }).toList());
        // List<Map<String, dynamic>> routineList = productList.map((product) {
        //   return {
        //     'type': product.type,
        //     'name': product.name,
        //     'isUsed': product.isChecked,
        //     'createdAt': Timestamp.now(),
        //   };
        // }).toList();
        print("yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee_________________________");
        print(routineList);
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .collection('skincare_routine')
            .add({'routine_data': routineList});

        isLoading = false;
        Fluttertoast.showToast(
          msg: "Data uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        update();
      }
    } catch (e) {
      print('Error saving data to Firestore: $e');
      // Show error toast
      Fluttertoast.showToast(
        msg: "Error uploading data: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

class ProductInfo {
  String? name;
  String? type;
  bool isChecked;
  String? imagePath;

  ProductInfo({
    this.name,
    this.type,
    this.isChecked = false,
    this.imagePath,
  });
}
