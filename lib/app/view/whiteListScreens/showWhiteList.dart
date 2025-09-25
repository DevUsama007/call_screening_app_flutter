import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:call_screening_app/app/customWidgets/bottomSheetTitleWidget.dart';
import 'package:call_screening_app/app/customWidgets/noRecord.dart';
import 'package:call_screening_app/app/customWidgets/whiteListWidget.dart';
import 'package:call_screening_app/app/utils/memoryUtils.dart';
import 'package:call_screening_app/app/utils/showNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_strings.dart';

class ShowWhiteList extends StatefulWidget {
  const ShowWhiteList({super.key});

  @override
  State<ShowWhiteList> createState() => _ShowWhiteListState();
}

class _ShowWhiteListState extends State<ShowWhiteList> {
  List<String> whitelist = [];

  static const channel = MethodChannel("call_blocker_channel");
  Future loadWhiteList() async {
    whitelist = await Memoryutils.loadList(AppStrings.whiteList);
    setState(() {});
  }

  Future removeNumber(int index) async {
    whitelist.removeAt(index);
    setState(() {});
    await Memoryutils.updateList(AppStrings.whiteList, whitelist);

    ShowNotification.showSuccess(context, 'List Updated');

    channel.invokeMethod('updateWhitelist', {"numbers": whitelist});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadWhiteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bottomSheetColor,
      body: Column(
        children: [
          bottomSheetTitleWidget(
            title: 'White List Numbers',
            ontap: () {},
          ),
          whitelist.isEmpty
              ? Container(
                  height: 150,
                )
              : Container(),
          whitelist.isEmpty
              ? noRecordWidget()
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        whitelist.length,
                        (index) {
                          return whiteListWidget(
                            phoneNumber: "${whitelist[index].toString()}",
                            callback: () {
                              removeNumber(index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
