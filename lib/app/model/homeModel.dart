import 'package:call_screening_app/app/constants/app_assets.dart';

class HomeModel {
  final String? title;
  final String? image;
  final String? description;

  HomeModel(
      {required this.title, required this.image, required this.description});

  static List<HomeModel> homeModelList = [
    HomeModel(
      title: "Blocked Count",
      image: AppAssets.blockCount,
      description: "0",
    ),
    HomeModel(
      title: "White List",
      image: AppAssets.whiteList,
      description: "Modify Whitelist Numbers",
    ),
    HomeModel(
      title: 'Add to WhiteList',
      image: AppAssets.addToList,
      description: "Add Numbers in WhiteList",
    ),
    // HomeModel(
    //   title: 'Black List',
    //   image: AppAssets.block,
    //   description: "Modify Blocked Country Codes",
    // ),
  ];
}
