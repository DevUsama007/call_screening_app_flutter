import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../model/homeModel.dart';

Widget homeCardWidget({
  required String title,
  required String description,
  required String image,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 160,
      height: 147,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade800,
          spreadRadius: 2,
          blurRadius: 3,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ], color: AppColor.cardColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
                color: AppColor.iconColor,
                image,
                width: 30,
                height: 30,
                fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: AppTextStyles.customText(
                  fontSize: 14,
                  color: AppColor.textColor,
                ),
              ),
            ),
            title == 'Blocked Count'
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(description.toString(),
                            style: AppTextStyles.customText(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textColor)),
                      ],
                    ),
                  )
                : Text(
                    description,
                    style: AppTextStyles.customText(
                      fontSize: 12,
                      color: AppColor.subtextColor,
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}
