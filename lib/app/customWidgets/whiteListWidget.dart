import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';

Widget whiteListWidget({
  required String phoneNumber,
  required VoidCallback callback,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                phoneNumber,
                style: AppTextStyles.customText14(),
              )
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: callback,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
