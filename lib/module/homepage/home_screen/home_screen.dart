import 'package:base_code/module/homepage/home_screen/home_screen_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import '../../../res/images.dart';
import '../../favorite_screen/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(
                () => Column(
              children: [
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0, left: 24, top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.greyScale),
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.white,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.liveLocationScreen);
                              },
                              child: const Center(
                                child: Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: const TextStyle()
                                    .normal12w500
                                    .textColor(AppColor.greyScaleColor),
                              ),
                              Text(
                                homeController.currentPlaceName.value,
                                style: const TextStyle().normal14w700,
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle notification tap
                        },
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.greyScale),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.white,
                          ),
                          child: Center(
                            child: Image.asset(
                              AppImage.notification,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0, left: 24),
                  child: CommonText(
                    controller: homeController.searchController.value,
                    hintText: 'Search cars...',
                    onChange: (val) {
                      homeController.searchQuery.value = val!;
                    },
                    suffixIcon: SizedBox(
                      height: 24,
                      width: 24,
                      child: Center(
                        child: Image.asset(
                          AppImage.search,
                          height: 19,
                          width: 19,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const Gap(24),
                SizedBox(
                  height: 52,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('logo')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        homeController.carDataList.clear();

                        for (var doc in snapshot.data!.docs) {
                          var carField =
                              doc.data() as Map<String, dynamic>? ?? {};
                          var carNames =
                              carField['car'] as List<dynamic>? ?? [];
                          for (var carName in carNames) {
                            if (carName is Map<String, dynamic>) {
                              String? name = carName['name'];
                              String? image = carName['image'];
                              if (name != null && image != null) {
                                homeController.carDataList
                                    .add({'name': name, 'image': image});
                              }
                            }
                          }
                        }

                        return ListView.builder(
                          itemCount: homeController.carDataList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> car =
                            homeController.carDataList[index];
                            bool isSelected =
                            homeController.selectedCards.contains(index);

                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0, bottom: 16),
                              child: GestureDetector(
                                onTap: () {
                                  homeController.toggleSelected(index);
                                  Get.toNamed(Routes.viewCarScreen,
                                      arguments: [car['name']]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColor.blueColor1
                                          : AppColor.greyScale,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Center(
                                      child: Image.network(
                                        car['image'],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top brands',
                        style: const TextStyle()
                            .normal18w700
                            .textColor(AppColor.greyscale100),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.viewCarScreen);
                        },
                        child: Text(
                          'View all',
                          style: const TextStyle()
                              .normal14w500
                              .textColor(AppColor.grey500),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('car')
                      .where(
                    'catagory',
                    whereIn: AppPref().selectedCarNames,
                  )
                      .snapshots(),
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
                    List<DocumentSnapshot> filteredDocs = [];
                    for (var doc in snapshot.data!.docs) {
                      var car = doc.data() as Map<String, dynamic>;
                      if (car['name'].toString().toLowerCase().contains(
                          homeController.searchQuery.value.toLowerCase())) {
                        filteredDocs.add(doc);
                      }
                    }
                    int itemCount =
                    filteredDocs.length < 5 ? filteredDocs.length : 5;
                    return Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24),
                      child: Column(
                        children: List.generate(itemCount, (index) {
                          var car = filteredDocs[index].data()
                          as Map<String, dynamic>;
                          bool isFavorite =
                          homeController.isFavorite(car);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.carDetailScreen,
                                    arguments: car);
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
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.blueColor1,
                                              borderRadius:
                                              BorderRadius.circular(6),
                                            ),
                                            height: 24,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Center(
                                                child: Text(
                                                  'Free test drive',
                                                  style: const TextStyle()
                                                      .normal10w700
                                                      .textColor(AppColor.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              homeController.toggleFavorite(car);
                                            },
                                            child: Obx(() => Icon(
                                              Icons.favorite,
                                              color: homeController.isFavorite(car)
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 24,
                                            )),
                                          ),
                                        ],
                                      ),
                                      const Gap(19),
                                      Center(
                                        child: Image.network(
                                          car['image'],
                                          height: 113,
                                          width: 287,
                                        ),
                                      ),
                                      const Gap(12),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            car['name'],
                                            style: const TextStyle()
                                                .normal16w700
                                                .textColor(
                                                AppColor.greyscale100),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                AppImage.star,
                                                height: 24,
                                                width: 24,
                                              ),
                                              const Gap(4),
                                              Text(
                                                car['star'],
                                                style: const TextStyle()
                                                    .normal12w500
                                                    .textColor(
                                                    AppColor.greyScaleColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      const Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                AppImage.engine,
                                                height: 24,
                                                width: 24,
                                              ),
                                              const Gap(4),
                                              Text(
                                                car['engine type'],
                                                style: const TextStyle()
                                                    .normal12w500
                                                    .textColor(
                                                    AppColor.greyScaleColor),
                                              ),
                                              const Gap(12),
                                              Image.asset(
                                                AppImage.gearbox,
                                                height: 24,
                                                width: 24,
                                              ),
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
                                                .textColor(
                                                AppColor.greyscale100),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
