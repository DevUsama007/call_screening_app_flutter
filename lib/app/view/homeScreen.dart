import 'package:call_screening_app/app/constants/app_assets.dart';
import 'package:call_screening_app/app/constants/app_colors.dart';
import 'package:call_screening_app/app/constants/app_strings.dart';
import 'package:call_screening_app/app/constants/app_text_styles.dart';
import 'package:call_screening_app/app/customWidgets/blockCodeCard.dart';
import 'package:call_screening_app/app/customWidgets/bottomSheetTitleWidget.dart';
import 'package:call_screening_app/app/customWidgets/bottom_sheet_widget.dart';
import 'package:call_screening_app/app/customWidgets/custom_button_widget.dart';
import 'package:call_screening_app/app/customWidgets/home_card_widget.dart';
import 'package:call_screening_app/app/customWidgets/whiteListWidget.dart';
import 'package:call_screening_app/app/model/homeModel.dart';
import 'package:call_screening_app/app/utils/showNotification.dart';
import 'package:call_screening_app/app/view/blackListScreens/blackListScreen.dart';
import 'package:call_screening_app/app/view/whiteListScreens/addToWhiteList.dart';
import 'package:call_screening_app/app/view/whiteListScreens/showWhiteList.dart';
import 'package:call_screening_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const channel = MethodChannel("call_blocker_channel");
  int blockedCount = 0;
  static Future<void> requestRole(BuildContext context) async {
    try {
      print('object');
      final result = await isDefaultCallScreeningApp();
      print(result.toString());
      if (!result) {
        print('2tre3');
        
        await channel.invokeMethod("requestRole");
      } else {
        ShowNotification.showSuccess(context, 'App is set default');
      }

      print('object');
    } catch (e) {
      ShowNotification.showSuccess(context, 'error: ${e}');
      print("Error requesting role: $e");
    }
  }

  static Future<bool> isDefaultCallScreeningApp() async {
    try {
      final result = await channel.invokeMethod("isDefaultCallScreeningApp");
      return result as bool? ?? false;
    } catch (e) {
      print("Error checking role: $e");
      return false;
    }
  }

  Future<void> _handleNativeCalls(MethodCall call) async {
    if (call.method == "onCallBlocked") {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        blockedCount++;
      });
      prefs.setInt('blockedCount', blockedCount);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSettings();

    channel.setMethodCallHandler(_handleNativeCalls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //       Colors.green.withOpacity(0.9),
        //       Colors.black,
        //       Colors.black,
        //     ],
        //         stops: [
        //       0.1, // Green takes next 20%
        //       0.3,
        //       0.4, // Yellow takes next 30%
        //     ])),
        width: double.infinity,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                AnimatedContainer(
                  height: 250,
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          radius: 0.5,
                          colors: isBlockingEnabled
                              ? [Color.fromARGB(255, 52, 167, 56), Colors.black]
                              : [
                                  const Color.fromARGB(255, 93, 93, 93),
                                  Colors.black
                                ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   isBlockingEnabled = !isBlockingEnabled;
                          // });
                          toggleBlocking(isBlockingEnabled ? false : true);
                          // await channel.invokeMethod("testLog");
                          // final result = await channel
                          //     .invokeMethod("isDefaultCallScreeningApp");
                          // print(
                          //     "Is default--------------------------? $result");
                          // print('object');
                          // triggerLog();
                        },
                        child: AnimatedContainer(
                          width: 120,
                          height: 120,
                          duration: Duration(seconds: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [
                              BoxShadow(
                                color: isBlockingEnabled
                                    ? const Color.fromARGB(255, 35, 110, 40)
                                    : Colors.grey.shade800,
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: AnimatedSwitcher(
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            duration: Duration(seconds: 1),
                            child: SvgPicture.asset(
                              isBlockingEnabled
                                  ? AppAssets.callScreeningActive
                                  : AppAssets.callScreeningDeactive,
                              key: ValueKey(
                                  isBlockingEnabled), // important for AnimatedSwitcher
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  // reverseDuration: Duration(seconds: 5),
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    // You can use different animations here (fade, scale, slide)
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text(
                    isBlockingEnabled
                        ? 'Call Screening Enabled'
                        : 'Call Screening Disabled',
                    key: ValueKey(
                        isBlockingEnabled), // important for AnimatedSwitcher
                    style: AppTextStyles.customText(
                        fontSize: 14, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Wrap(
                  children: List.generate(
                    HomeModel.homeModelList.length,
                    (index) {
                      return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            index == 0
                                ? requestRole(context)
                                : navigateOnPermission(index);
                            // index == 3
                            //     ? CustomBottomSheet.show(
                            //         height: 250,
                            //         context: context,
                            //         child: BlackListScreen())
                            //     :
                            // index == 2
                            //     ? CustomBottomSheet.show(
                            //         height: 250,
                            //         context: context,
                            //         child: AddToWhiteListScreen())
                            //     : index == 1
                            //         ? CustomBottomSheet.show(
                            //             context: context,
                            //             child: ShowWhiteList())
                            //         : phonePermissionManager();
                          },
                          child: homeCardWidget(
                              title: HomeModel.homeModelList[index].title!,
                              description: HomeModel
                                          .homeModelList[index].title ==
                                      'Blocked Count'
                                  ? '${blockedCount.toString()}'
                                  : HomeModel.homeModelList[index].description!,
                              image: HomeModel.homeModelList[index].image!));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isBlockingEnabled = false;
  Future<void> _loadSettings() async {
    phonePermissionManager();
    requestRole(context);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBlockingEnabled = prefs.getBool(AppStrings.isblockEnabled) ?? false;
      blockedCount = prefs.getInt(AppStrings.blockedCount) ?? 0;
    });
  }

  static Future<void> triggerLog() async {
    final response = await channel.invokeMethod("testLog");
    print("Flutter received: $response");
  }

  toggleBlocking(bool isblocking) async {
    final hasPermission = await _checkAndRequestPhonePermission();
    final result = await isDefaultCallScreeningApp();
    if (!result) {
      requestRole(context);
    }
    if (!hasPermission) {
      _checkAndRequestPhonePermission();
    } else {
      if (result && hasPermission) {
        final prefs = await SharedPreferences.getInstance();
        setState(() => isBlockingEnabled = isblocking);
        await prefs.setBool('isBlockingEnabled', isblocking);

        channel.invokeMethod('setBlockingEnabled', {"enabled": isblocking});
      } else {
        if (!hasPermission) {
          ShowNotification.showError(context, 'Does Not find Permission');
        } else {
          ShowNotification.showError(
              context, 'Please Set The App Defualt Screening First');
        }
      }
    }
  }

  navigateOnPermission(int index) async {
    final hasPermission = await _checkAndRequestPhonePermission();
    final result = await isDefaultCallScreeningApp();
    if (!result) {
      requestRole(context);
    }
    if (!hasPermission) {
      _checkAndRequestPhonePermission();
    } else {
      if (result && hasPermission) {
        index == 2
            ? CustomBottomSheet.show(
                height: 250, context: context, child: AddToWhiteListScreen())
            : index == 1
                ? CustomBottomSheet.show(
                    context: context, child: ShowWhiteList())
                : perimission();
      } else {
        if (!hasPermission) {
          ShowNotification.showError(context, 'Does Not find Permission');
        } else {
          ShowNotification.showError(
              context, 'Please Set The App Defualt Screening First');
        }
      }
    }
  }

  perimission() async {
    try {
      final result = await isDefaultCallScreeningApp();
      if (!result) {
        requestRole(context);
      }
    } catch (e) {
      ShowNotification.showError(context, 'Error: ${e}');
    }
    final result = await isDefaultCallScreeningApp();
    if (!result) {
      requestRole(context);
    }
  }

  phonePermissionManager() async {
    final hasPermission = await _checkAndRequestPhonePermission();
    if (hasPermission) {
      print('Permission granted');
    } else {
      ShowNotification.showError(context, 'Does Not find Permission');
    }
  }

  Future<bool> _checkAndRequestPhonePermission() async {
    final status = await Permission.phone.status;
    final status2 = await Permission.contacts.status;
    if (status.isGranted || status.isLimited) {
      return true;
    }
    if (status2.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }

    if (status.isPermanentlyDenied) {
      // Open app settings
      openAppSettings();
      return false;
    }

    // Request permission for denied/not-determined cases
    final result = await Permission.phone.request();
    final result2 = await Permission.contacts.request();

    return result.isGranted;
  }
}
