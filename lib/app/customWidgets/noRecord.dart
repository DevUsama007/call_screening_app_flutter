import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';
import '../constants/app_text_styles.dart';

Widget noRecordWidget() {
  return Container(
    height: 200,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.blockNumbers,
          width: 30,
          height: 30,
          color: Colors.grey,
        ),
        Text(
          'No Record',
          style: AppTextStyles.customText12(),
        )
      ],
    ),
  );
}
