import 'package:base_code/package/config_packages.dart';

class PickCarController extends GetxController{
  RxList selectedCards = [].obs;
  RxList carDataList = [].obs;

  void toggleSelected(int index) {
    if (selectedCards.contains(index)) {
      selectedCards.remove(index);
    } else {
      selectedCards.add(index);
    }
  }

}