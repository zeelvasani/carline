import 'package:base_code/module/homepage/view_car/view_car_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/res/color_schema.dart';
import 'package:base_code/res/text_style.dart';

import '../../../app_route.dart';
import '../../../res/images.dart';
class ViewCarScreen extends StatefulWidget {
  const ViewCarScreen({super.key});

  @override
  State<ViewCarScreen> createState() => _ViewCarScreenState();
}

class _ViewCarScreenState extends State<ViewCarScreen> {
  final viewCarController = Get.put<ViewCarController>(ViewCarController());
  final String? selectedCarName = Get.arguments != null ? Get.arguments[0] as String : null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Available cars',
            style: const TextStyle().normal18w700.textColor(AppColor.black),
          ),
          centerTitle: true,
          actions: const [
            Icon(Icons.search),
            Gap(24),
          ],
        ),
        body: Column(
          children: [

            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: viewCarController.tabList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> car = viewCarController.tabList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: GestureDetector(
                      onTap: () {
                        viewCarController.toggleSelected(index);
                      },
                      child: Obx(() {
                        bool isSelected = viewCarController.selectedCards.contains(index);
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColor.blueColor1 : AppColor.greyscale200,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: index == 0
                                  ? [
                                const SizedBox(width: 12),
                                Image.asset(
                                  car['image'],
                                  color: AppColor.gray800,
                                  height: 16,
                                  width: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  car['name'],
                                  style: const TextStyle().normal14w500,
                                ),
                                const SizedBox(width: 12),
                              ]
                                  : [
                                const SizedBox(width: 12),
                                Text(
                                  car['name'],
                                  style: const TextStyle().normal14w500,
                                ),
                                const SizedBox(width: 8),
                                Image.asset(
                                  car['image'],
                                  color: AppColor.gray800,
                                  height: 16,
                                  width: 16,
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: selectedCarName!=null?
                FirebaseFirestore.instance
                    .collection('car')
                    .where('catagory', isEqualTo: selectedCarName)
                    .snapshots():
                FirebaseFirestore.instance
                    .collection('car').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No cars found.'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var car = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 24.0, right: 24.0, top: 16),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.carDetailScreen,
                                arguments: car.data());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(71, 85, 105, 0.08),
                                  blurRadius: 100.0,
                                  spreadRadius: 0,
                                  offset: Offset(4, 8),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        car['image'],
                                        height: 81,
                                        width: 127,
                                      ),
                                      const Gap(14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              car['name'],
                                              style: const TextStyle()
                                                  .normal18w700
                                                  .textColor(
                                                  AppColor.greyscale100),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            const Gap(4),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Image.network(
                                                  car['logo'],
                                                  height: 12,
                                                  width: 36,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(AppImage.star,
                                                        height: 24, width: 24),
                                                    const Gap(4),
                                                    Text(
                                                      car['star'],
                                                      style: const TextStyle()
                                                          .normal12w500
                                                          .textColor(AppColor
                                                          .greyScaleColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  const Divider(),
                                  const Gap(10),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(AppImage.engine,
                                              height: 24, width: 24),
                                          const Gap(4),
                                          Text(
                                            car['engine type'],
                                            style: const TextStyle()
                                                .normal12w500
                                                .textColor(
                                                AppColor.greyScaleColor),
                                          ),
                                          const Gap(12),
                                          Image.asset(AppImage.gearbox,
                                              height: 24, width: 24),
                                          const Gap(4),
                                          Text(
                                            car['gair type'],
                                            style: const TextStyle()
                                                .normal12w500
                                                .textColor(
                                                AppColor.greyScaleColor),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        car['price'],
                                        style: const TextStyle()
                                            .normal16w700
                                            .textColor(AppColor.greyscale100),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
