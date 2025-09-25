import 'package:call_screening_app/app/constants/app_assets.dart';
import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:call_screening_app/app/constants/app_text_styles.dart';
import 'package:call_screening_app/app/customWidgets/blackListWidget.dart';
import 'package:call_screening_app/app/customWidgets/blockCodeCard.dart';
import 'package:call_screening_app/app/customWidgets/bottomSheetTitleWidget.dart';
import 'package:call_screening_app/app/customWidgets/bottom_sheet_widget.dart';
import 'package:call_screening_app/app/customWidgets/noRecord.dart';
import 'package:call_screening_app/app/utils/memoryUtils.dart';
import 'package:call_screening_app/app/view/blackListScreens/addToBlackList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_strings.dart';

class BlackListScreen extends StatefulWidget {
  const BlackListScreen({super.key});

  @override
  State<BlackListScreen> createState() => _BlackListScreenState();
}

class _BlackListScreenState extends State<BlackListScreen> {
  List<String> blackList = [];
  Future loadblackList() async {
    blackList = await Memoryutils.loadList(AppStrings.blackList);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadblackList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bottomSheetColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            bottomSheetTitleWidget(
              title: 'Blacklist Coutries Code',
              ontap: () {
                Navigator.pop(context);
                CustomBottomSheet.show(
                    height: 200,
                    context: context,
                    child: AddToBlackListScreen());
              },
            ),
            blackList.isEmpty
                ? noRecordWidget()
                : Wrap(
                    children: List.generate(
                      blackList.length,
                      (index) {
                        return blockCodeCard(
                          '+9${index}',
                          () {},
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
