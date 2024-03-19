import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urban_culture/utils/colors.dart';

import '../controller/product_input_controller.dart';

class ProductInputFieldWidget extends StatefulWidget {
  ProductInputController controller;
  ProductInputFieldWidget({super.key, required this.controller});
  @override
  _ProductInputFieldWidgetState createState() => _ProductInputFieldWidgetState();
}

class _ProductInputFieldWidgetState extends State<ProductInputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    int index = widget.controller.currentIndex.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          padding: const EdgeInsets.only(left: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: DropdownButton<String>(
            value: widget.controller.getSelectitem(),
            icon: Icon(Icons.arrow_drop_down, color: primaryColor),
            iconSize: 30,
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 18),
            underline: const SizedBox.shrink(),
            onChanged: (newValue) {
              index == 0
                  ? widget.controller.setSelectedFacewash(facewash: newValue)
                  : index == 1
                      ? widget.controller.setSelectedToner(toner: newValue)
                      : index == 2
                          ? widget.controller.setSelectedMoisturizer(moisturizer: newValue)
                          : index == 3
                              ? widget.controller.setSelectedSunscream(sunscream: newValue)
                              : widget.controller.setSelectedLipbalm(lipbalm: newValue);
            },
            items: widget.controller.getProductList().map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            hint: Text(
              index == 0
                  ? 'Select Face Wash'
                  : index == 1
                      ? 'Select Toner'
                      : index == 2
                          ? 'Select Moisturizer'
                          : index == 3
                              ? 'Select Sunscream'
                              : 'Select LipBalm',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ),
        Visibility(
          visible: widget.controller.showerror(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              widget.controller.getErrorMessage(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
