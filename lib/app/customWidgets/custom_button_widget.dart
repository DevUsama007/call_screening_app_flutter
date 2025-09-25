import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';

Widget CustomButtonWidget({
  required String title,
  required VoidCallback onTap,
  Color? color,
  double? width,
  double? height,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        width: width ?? double.infinity,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: color ?? AppColor.btnColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.customText(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.textColor,
            ),
          ),
        ),
      ),
    ),
  );
}
