
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:base_code/module/bottom_navigation/bottom_controller.dart';
import 'package:base_code/module/favorite_screen/favorite_screen.dart';
import 'package:base_code/module/homepage/home_screen/home_screen.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:http/http.dart' as http;

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final bottomBarController = Get.put <BottomBarController>(BottomBarController());

  final GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: Obx(
        ()=> BottomBarDefault(
          items: bottomBarController.items,
          backgroundColor: Colors.white,
          colorSelected: AppColor.blueColor1,
          indexSelected: bottomBarController.currentPage.value,
          paddingVertical: 25,
            color: AppColor.greyScale,
          onTap: (int index) {
            bottomBarController.currentPage.value = index;
            },
        ),
      ),


      body: Obx(
          ()=> SizedBox(
          width:MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child:
          (bottomBarController.currentPage.value ==0 )?
          const HomeScreen():
          (bottomBarController.currentPage.value ==1 )?

          const FavoriteScreen():
          (bottomBarController.currentPage.value ==2 )?
          const HomeScreen():
          const HomeScreen()
        ),
      ),
      );

  }
}
