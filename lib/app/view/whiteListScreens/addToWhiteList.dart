import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:call_screening_app/app/constants/app_strings.dart';
import 'package:call_screening_app/app/customWidgets/bottomSheetTitleWidget.dart';
import 'package:call_screening_app/app/customWidgets/customTextField.dart';
import 'package:call_screening_app/app/customWidgets/custom_button_widget.dart';
import 'package:call_screening_app/app/utils/memoryUtils.dart';
import 'package:call_screening_app/app/utils/showNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToWhiteListScreen extends StatefulWidget {
  const AddToWhiteListScreen({super.key});

  @override
  State<AddToWhiteListScreen> createState() => _AddToWhiteListScreenState();
}

class _AddToWhiteListScreenState extends State<AddToWhiteListScreen> {
  TextEditingController phoneController = TextEditingController();

  static const channel = MethodChannel("call_blocker_channel");
  List<String> whitelist = [];
  Future loadSettings() async {
    whitelist = await Memoryutils.loadList(AppStrings.whiteList);
  }

  Future<void> _addWhitelistNumber(String number) async {
    await loadSettings();

    whitelist.add(number);

    await Memoryutils.updateList(AppStrings.whiteList, whitelist).then(
      // await prefs.setStringList(AppStrings.whiteList, whitelist).then(
      (value) {
        channel.invokeMethod('updateWhitelist', {"numbers": whitelist});
        ShowNotification.showSuccess(context, 'White List Updated');
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          bottomSheetTitleWidget(
            title: 'Add To Whitelist',
            ontap: () {},
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
              hintText: '923431119009',
              icon: Icons.phone_android,
              controller: phoneController),
          SizedBox(
            height: 10,
          ),
          CustomButtonWidget(
            title: 'ADD',
            height: 40,
            onTap: () {
              phoneController.text.toString().startsWith("+")
                  ? ShowNotification.showError(
                      context, 'Please remove the + sign')
                  : phoneController.text.toString().startsWith('03')
                      ? ShowNotification.showError(
                          context, 'Please Enter The Mobile In 92-------format')
                      : phoneController.text.isEmpty
                          ? ShowNotification.showError(
                              context, 'Empty Mobile Number')
                          : _addWhitelistNumber(
                              phoneController.text.toString());
            },
          )
        ],
      ),
    );
  }
}
