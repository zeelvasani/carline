
import 'package:awesome_bottom_bar/tab_item.dart';

import '../../package/config_packages.dart';

class BottomBarController extends GetxController{
  RxInt currentPage = 0.obs;
  RxList<TabItem> items = [
    const TabItem(
        icon: Icons.home,
        title: 'home'
    ),
    const TabItem(
      icon: Icons.favorite_border,
      title: 'favorite',
    ),

    const TabItem(
      icon: Icons.message_rounded,
      title: 'message',
    ),
    const TabItem(
      icon: Icons.perm_identity_rounded,
      title: 'profile',
    ),
  ].obs;
}