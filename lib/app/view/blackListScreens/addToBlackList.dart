import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:call_screening_app/app/customWidgets/bottomSheetTitleWidget.dart';
import 'package:call_screening_app/app/customWidgets/customTextField.dart';
import 'package:call_screening_app/app/customWidgets/custom_button_widget.dart';
import 'package:call_screening_app/app/utils/showNotification.dart';
import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../utils/memoryUtils.dart';

class AddToBlackListScreen extends StatefulWidget {
  const AddToBlackListScreen({super.key});

  @override
  State<AddToBlackListScreen> createState() => _AddToBlackListScreenState();
}

class _AddToBlackListScreenState extends State<AddToBlackListScreen> {
  TextEditingController codeController = TextEditingController();
  List<String> blackList = [];
  Future loadSettings() async {
    blackList = await Memoryutils.loadList(AppStrings.blackList);
  }

  Future<void> _addBlacklistNumber(String code) async {
    await loadSettings();

    blackList.add(code);

    await Memoryutils.updateList(AppStrings.blackList, blackList).then(
      // await prefs.setStringList(AppStrings.whiteList, whitelist).then(
      (value) {
        ShowNotification.showSuccess(context, 'Black List Updated');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bottomSheetColor,
      body: Column(
        children: [
          bottomSheetTitleWidget(
            title: 'Add To BlackList',
            ontap: () {},
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.53,
                child: CustomTextField(
                    hintText: '+92',
                    icon: Icons.code,
                    controller: codeController),
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                width: MediaQuery.of(context).size.width * 0.3,
                title: 'ADD',
                height: 45,
                onTap: () {
                  codeController.text.isEmpty
                      ? ShowNotification.showError(
                          context, 'Empty Country Code')
                      : _addBlacklistNumber(codeController.text.toString());
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
