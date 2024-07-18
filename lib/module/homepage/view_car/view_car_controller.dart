import 'package:base_code/package/config_packages.dart';

import '../../../res/images.dart';


class ViewCarController extends GetxController{
  RxList selectedCards = [].obs;
  RxList<Map<String, dynamic>> tabList = [
    {'name': 'Filter', 'image': AppImage.filter},
    {'name': 'Recommended', 'image':  AppImage.arrow},
    {'name': 'Free test drive', 'image': AppImage.arrow},
  ].obs;
  void toggleSelected(int index) {
    selectedCards.clear();
    selectedCards.add(index);
  }
}


