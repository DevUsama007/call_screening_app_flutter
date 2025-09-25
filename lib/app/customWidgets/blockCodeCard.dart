import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:call_screening_app/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

Widget blockCodeCard(String code, VoidCallback callback) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: callback,
    child: Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      decoration: BoxDecoration(
          color: AppColor.cardColor, borderRadius: BorderRadius.circular(10)),
      child: Text(
        code.toString(),
        style: AppTextStyles.customTextbold14(),
      ),
    ),
  );
}
