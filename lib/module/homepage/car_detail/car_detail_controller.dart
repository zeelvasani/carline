import 'package:base_code/package/config_packages.dart';


class CarDetailController extends GetxController with SingleGetTickerProviderMixin {
  late final TabController tabController;
  RxBool isTitleVisible = false.obs;
  final ScrollController scrollController = ScrollController();
  RxBool isContainerVisible = false.obs;

  void toggleContainer() {
    isContainerVisible.value = !isContainerVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_updateTitleVisibility);
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    tabController.removeListener(_updateTitleVisibility);
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _updateTitleVisibility() {
    isTitleVisible.value = tabController.index == 0;
  }

  void _onScroll() {
    isTitleVisible.value = scrollController.offset > 400;
  }
}