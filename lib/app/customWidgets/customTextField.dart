import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

Widget CustomTextField({
  required String hintText,
  required IconData icon,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextField(
      controller: controller,
      style: AppTextStyles.customText12white(),
      cursorColor: AppColor.btnColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.btnColor, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.grey.shade900,
        hintText: hintText,
        hintStyle: AppTextStyles.customText12(),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
