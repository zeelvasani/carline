import 'package:base_code/module/homepage/pick_car/pick_car_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:firebase_storage/firebase_storage.dart';


class PickCarScreen extends StatefulWidget {
  const PickCarScreen({super.key});

  @override
  State<PickCarScreen> createState() => _PickCarScreenState();
}

class _PickCarScreenState extends State<PickCarScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final pickCarController = Get.put<PickCarController>(PickCarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AppPref().pickCarSkip = true;
              Get.offNamed(Routes.bottomNavigationBar);
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Gap(24),
        ],
      ),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 24, left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Which brand of car do you prefer?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 8),
            const Text(
              "Select all that you are interested in.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('logo').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    pickCarController.carDataList.clear();
                    for (var doc in snapshot.data!.docs) {
                      var carField = doc.data() as Map<String, dynamic>? ?? {};
                      var carNames = carField['car'] as List<dynamic>? ?? [];
                      for (var carName in carNames) {
                        if (carName is Map<String, dynamic>) {
                          String? name = carName['name'];
                          String? image = carName['image'];
                          if (name != null && image != null) {
                            pickCarController.carDataList
                                .add({'name': name, 'image': image});
                          }
                        }
                      }
                    }
                    return GridView.builder(
                      itemCount: pickCarController.carDataList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> car =
                            pickCarController.carDataList[index];
                        return GestureDetector(
                          onTap: () {
                            pickCarController.toggleSelected(index);
                          },
                          child: Obx(() {
                            bool isSelected =
                                pickCarController.selectedCards.contains(index);
                            return Container(
                              height: 104,
                              width: 155,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.blueColor1
                                      : AppColor.geryScale,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: const BoxDecoration(
                                      color: AppColor.gray100,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                        car['image'],
                                        color: AppColor.gray800,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(car['name']),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            CommonAppButton(
              text: 'Finish',
              style: const TextStyle().normal16w700.textColor(AppColor.white),
              color: AppColor.blueColor1,
              buttonType: ButtonType.enable,
              onTap: () async {
                if (pickCarController.selectedCards.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one brand.'),
                    ),
                  );
                } else {
                  List selectedIndexes = pickCarController.selectedCards;
                  List<String> selectedCarNames = [];
                  for (int index in selectedIndexes) {
                    selectedCarNames
                        .add(pickCarController.carDataList[index]['name']);
                  }

                  AppPref().selectedCarNames = selectedCarNames;
                  AppPref().pickCar = true;
                  Get.offNamed(Routes.bottomNavigationBar);
                }
              },
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}
