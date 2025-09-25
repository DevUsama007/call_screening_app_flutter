import 'package:call_screening_app/app/constants/app_assets.dart';
import 'package:call_screening_app/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget bottomSheetTitleWidget({
  required String title,required VoidCallback ontap
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              title,
              style: AppTextStyles.customText16(),
            ),
            title != 'Blacklist Coutries Code'
                ? Container()
                : InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap:ontap,
                    child: Container(
                      child: SvgPicture.asset(
                        color: Colors.white,
                        AppAssets.addToList,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Divider(),
      ),
    ],
  );
}
