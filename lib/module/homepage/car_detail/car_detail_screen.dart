import 'package:base_code/components/common_container.dart';
import 'package:base_code/components/common_row.dart';
import 'package:base_code/module/homepage/car_detail/car_detail_controller.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../components/common_textfeild.dart';
import '../../../package/config_packages.dart';
import '../../../res/images.dart';


class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  late final Map<String, dynamic> car;
  final CarDetailController carDetailController =
      Get.put(CarDetailController());


  @override
  void initState() {
    super.initState();
    car = (Get.arguments as Map<String, dynamic>?) ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Column(
          children: [
            Expanded(
              child: NestedScrollView(
                controller: carDetailController.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    Obx(
                      () => SliverAppBar(
                        centerTitle: true,
                        backgroundColor:
                            carDetailController.isTitleVisible.value
                                ? AppColor.white
                                : AppColor.greyscale100,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: carDetailController.isTitleVisible.value
                                ? AppColor.greyscale100
                                : AppColor.grey500,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        title: carDetailController.isTitleVisible.value
                            ? Text(
                                car['name'] ?? 'Car Detail',
                                style: const TextStyle()
                                    .normal18w700
                                    .textColor(AppColor.greyscale100),
                              )
                            : const SizedBox.shrink(),
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              color: carDetailController.isTitleVisible.value
                                  ? AppColor.greyscale100
                                  : AppColor.grey500,
                            ),
                          ),
                          const Gap(16),
                          Image.asset(
                            AppImage.share,
                            height: 24,
                            width: 24,
                            color: carDetailController.isTitleVisible.value
                                ? AppColor.greyscale100
                                : AppColor.grey500,
                          ),
                          const Gap(24)
                        ],
                        pinned: true,
                        expandedHeight: 500.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              const Gap(50),
                              Container(
                                color: AppColor.greyscale100,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 88,
                                      decoration: BoxDecoration(
                                        color: AppColor.blueColor1,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      height: 24,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
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
                                    const Gap(15),
                                    Text(
                                      car['name'] ?? 'Car Detail',
                                      style: const TextStyle()
                                          .normal24w700
                                          .textColor(AppColor.white),
                                    ),
                                    const Gap(40),
                                    if (car.containsKey('image'))
                                      Image.network(
                                        car['image'],
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    const Gap(20)
                                  ],
                                ),
                              ),
                              Container(
                                color: AppColor.white,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 40, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildSpecificationColumn(
                                          car['engine1'] ?? {}),
                                      const Gap(8),
                                      const VerticalDivider(
                                        color: AppColor.greyscale200,
                                        width: 40,
                                        indent: 1,
                                      ),
                                      const Gap(8),
                                      _buildSpecificationColumn(
                                          car['engine2'] ?? {}),
                                      const Gap(8),
                                      const VerticalDivider(
                                        color: AppColor.greyscale200,
                                        width: 40,
                                        indent: 1,
                                      ),
                                      const Gap(8),
                                      _buildSpecificationColumn(
                                          car['engine3'] ?? {}),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(kToolbarHeight),
                          child: Container(
                            color: AppColor.white,
                            height: 50,
                            child: TabBar(
                              controller: carDetailController.tabController,
                              isScrollable: true,
                              labelColor: AppColor.blueColor1,
                              indicatorColor: AppColor.blueColor1,
                              tabs: const [
                                Tab(text: "Details"),
                                Tab(text: "Features"),
                                Tab(text: "Design"),
                                Tab(text: "Price map"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: carDetailController.tabController,
                  children: [
                    _buildOverviewSection(car),
                    _buildSpecificationsSection(car),
                    _buildReviewsSection(car),
                    _buildGallerySection(),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 72,
              width: double.infinity,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 24.0, left: 24, top: 12, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Price (Cash)',
                          style: const TextStyle()
                              .normal12w500
                              .textColor(AppColor.greyscale100),
                        ),
                        Text(
                          car['price'] ?? 'N/A',
                          style: const TextStyle()
                              .normal24w700
                              .textColor(AppColor.greyscale100),
                        ),
                      ],
                    ),

                    CommonAppButton(
                      width: 190,
                      text:"Buy",
                      style: const TextStyle().normal16w700.textColor(AppColor.white),
                      buttonType: ButtonType.enable,
                      onTap: (){
                        //Get.toNamed(Routes.purchaseMethodScreen, arguments: car);
                      },
                      color: AppColor.blueColor1,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection(Map<String, dynamic> car) {
    final CarDetailController carDetailController =
        Get.put(CarDetailController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(car['detail'] ?? 'No details available.'),
            const Gap(24),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vehicle details",
                    style: const TextStyle()
                        .normal14w700
                        .textColor(AppColor.greyscale100),
                  ),
                  GestureDetector(
                      onTap: () {
                        carDetailController.toggleContainer();
                      },
                      child: carDetailController.isContainerVisible.value
                          ? Image.asset(
                              AppImage.arrowUp,
                              height: 20,
                              width: 20,
                            )
                          : Image.asset(
                              AppImage.arrow,
                              height: 20,
                              width: 20,
                              color: AppColor.greyscale100,
                            )),
                ],
              ),
            ),
            Obx(() => carDetailController.isContainerVisible.value
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColor.white,
                        border: Border.all(color: AppColor.greyscale200)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Make',
                              style: const TextStyle()
                                  .normal14w500
                                  .textColor(AppColor.greyScaleColor),
                            ),
                            Row(
                              children: [
                                Image.network(
                                  car['logo'],
                                  height: 20,
                                  width: 30,
                                  color: AppColor.greyscale100,
                                ),
                                const Gap(10),
                                Text(
                                  car['name'],
                                  style: const TextStyle()
                                      .normal14w700
                                      .textColor(AppColor.greyscale100),
                                )
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        CommonRow(leftText: 'Model', rightText: car['name']),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Exterior color',
                              style: const TextStyle()
                                  .normal14w500
                                  .textColor(AppColor.greyScaleColor),
                            ),
                            Text(car['name'],
                                style: const TextStyle()
                                    .normal14w700
                                    .textColor(AppColor.greyscale100))
                          ],
                        ),
                        const Divider(),
                        CommonRow(
                            leftText: 'Interior color', rightText: car['name']),
                        const Divider(),
                        CommonRow(leftText: 'Body', rightText: car['name']),
                        const Divider(),
                        CommonRow(leftText: 'Seats', rightText: car['name']),
                        const Divider(),
                        CommonRow(leftText: 'VIN', rightText: car['name']),
                      ],
                    ),
                  )
                : const SizedBox.shrink()),
            const Gap(16),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Steering",
                    style: const TextStyle()
                        .normal14w700
                        .textColor(AppColor.greyscale100),
                  ),
                  GestureDetector(
                      onTap: () {
                        carDetailController.toggleContainer();
                      },
                      child: carDetailController.isContainerVisible.value
                          ? Image.asset(
                              AppImage.arrowUp,
                              height: 20,
                              width: 20,
                            )
                          : Image.asset(
                              AppImage.arrow,
                              height: 20,
                              width: 20,
                              color: AppColor.greyscale100,
                            )),
                ],
              ),
            ),
            const Gap(16),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vehicle Conditions",
                    style: const TextStyle()
                        .normal14w700
                        .textColor(AppColor.greyscale100),
                  ),
                  GestureDetector(
                      onTap: () {
                        carDetailController.toggleContainer();
                      },
                      child: carDetailController.isContainerVisible.value
                          ? Image.asset(
                              AppImage.arrowUp,
                              height: 20,
                              width: 20,
                            )
                          : Image.asset(
                              AppImage.arrow,
                              height: 20,
                              width: 20,
                              color: AppColor.greyscale100,
                            )),
                ],
              ),
            ),
            const Gap(16),
            Center(
                child: Text(
              "Simple pricing, no haggling required",
              style: const TextStyle()
                  .normal18w500
                  .textColor(AppColor.greyScale500),
            )),
            const Gap(24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
                child: Column(
                  children: [
                    CommonRow(leftText: 'Car Audit', rightText: car['name']),
                    const Gap(20),
                    CommonRow(leftText: 'Import MOT', rightText: car['name']),
                    const Gap(20),
                    CommonRow(
                        leftText: 'Documentation', rightText: car['name']),
                    const Gap(20),
                    CommonRow(
                        leftText: 'Car registration', rightText: car['name']),
                    const Gap(20),
                    CommonRow(leftText: 'Sales Tax', rightText: car['name']),
                    const Gap(8),
                    Container(
                      height: 91,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.textFieldFillColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Price',
                                  style: const TextStyle()
                                      .normal14w500
                                      .textColor(AppColor.greyScaleColor),
                                ),
                                Text(
                                  car['price'],
                                  style: const TextStyle()
                                      .normal14w500
                                      .textColor(AppColor.blueColor1),
                                )
                              ],
                            ),
                            const Gap(8),
                            CommonRow(
                                leftText: 'Est. Monthly payment',
                                rightText: car['price']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(8),
            CommonAppButton(
              text: 'Credit Simulation',
              buttonType: ButtonType.enable,
              onTap: (){
                Get.toNamed(
                  Routes.creditScreen,
                );
              },
              border: Border.all(color:AppColor.black ),
              textColor: AppColor.greyscale100,
                color: Colors.white,
              style: const TextStyle().normal16w700,
            ),

            const CommonTextField(
              radius: 9,
              height: 39,
              hintText: 'hello',
              prefixIcon: Icon(Icons.vaccines),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationsSection(Map<String, dynamic> car) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key specs of Audi Q7',
              style: const TextStyle()
                  .normal16w700
                  .textColor(AppColor.greyscale100),
            ),
            const Gap(12),
            Row(
              children: [
                CommonContainer(
                  imagePath: AppImage.filter,
                  title: "Transmission type",
                  value: car['gair type'],
                ),
                const Gap(12),
                CommonContainer(
                  imagePath: AppImage.filter,
                  title: "Transmission type",
                  value: car['gair type'],
                ),
              ],
            ),
            const Gap(24),
            Text(
              'Performance',
              style: const TextStyle()
                  .normal16w700
                  .textColor(AppColor.greyscale100),
            ),
            Row(
              children: [
                CommonContainer(
                  imagePath: AppImage.filter,
                  title: "Transmission type",
                  value: car['gair type'],
                ),
                const Gap(12),
                CommonContainer(
                  imagePath: AppImage.filter,
                  title: "Transmission type",
                  value: car['gair type'],
                ),
              ],
            ),
            const Gap(24),
            Text(
              'Notable features',
              style: const TextStyle()
                  .normal16w700
                  .textColor(AppColor.greyscale100),
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColor.textFieldFillColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.bluetooth),
                    ),
                    const Gap(22),
                    Text(
                      'Bluetooth connectivity',
                      style: const TextStyle()
                          .normal14w700
                          .textColor(AppColor.greyscale100),
                    ),
                  ],
                ),
                const Gap(110),
                Text(
                  'yes',
                  style: const TextStyle()
                      .normal14w700
                      .textColor(AppColor.greenColor),
                ),
              ],
            ),
            const Gap(20),
            const Divider(),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColor.textFieldFillColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.bluetooth),
                    ),
                    const Gap(22),
                    Text(
                      'Bluetooth connectivity',
                      style: const TextStyle()
                          .normal14w700
                          .textColor(AppColor.greyscale100),
                    ),
                  ],
                ),
                const Gap(110),
                Text(
                  'yes',
                  style: const TextStyle()
                      .normal14w700
                      .textColor(AppColor.greenColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection(Map<String, dynamic> car) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, right: 24, left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Powerful and sporty - The exterior',
              style: const TextStyle()
                  .normal18w700
                  .textColor(AppColor.greyscale100),
            ),
            Text(
              'For an even sportier look, opt for optional\n Design Packages.',
              style: const TextStyle()
                  .normal14w500
                  .textColor(AppColor.greyScaleColor),
            ),
            const Gap(16),
            Row(
              children: [
                Image.network(
                  car['design']['image'],
                  height: 218,
                  width: 157,
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      car['design']['image1'],
                      height: 101,
                      width: 155,
                    ),
                    const Gap(16),
                    Image.network(
                      car['design']['image2'],
                      height: 101,
                      width: 155,
                    ),
                  ],
                )
              ],
            ),
            const Gap(16),
            Image.network(
              car['design']['image3'],
              height: 172,
              width: 327,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallerySection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Product historical data'),
            SizedBox(
              height: 300,
              width: 400,
              child: LineChart(LineChartData(
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColor.grey,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: AppColor.grey,
                      strokeWidth: 0,
                    );
                  },
                ),
                titlesData: const FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: leftTitleWidgets,
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 3.1),
                      FlSpot(8, 4),
                      FlSpot(9.5, 3),
                      FlSpot(11, 4),
                    ],
                    isCurved: false,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient:LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                        colors: [const Color(0x4038FF40).withOpacity(0.25), const Color(0x4038FF40).withOpacity(0)],
                      )
                    ),
                  ),
                ],
              )
              ),

            ),
            const Gap(24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColor.greyscale200
                ),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(

                  children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: AppColor.greyscale300,
                          borderRadius: BorderRadius.circular(1000)
                        ),
                        child: Center(child: Image.asset(AppImage.doller,height: 24,width: 24,)),
                      ),
                     const Gap(16),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('75000',style: const TextStyle().normal16w700.textColor(AppColor.greyscale100),),
                        Text('Average sale',style: const TextStyle().normal12w500.textColor(AppColor.greyScaleColor),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColor.greyscale200
                ),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(

                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor200,
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: const Center(child: Icon(Icons.arrow_upward,color: AppColor.greenColor100,)),
                    ),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('75000',style: const TextStyle().normal16w700.textColor(AppColor.greyscale100),),
                        Text('Average sale',style: const TextStyle().normal12w500.textColor(AppColor.greyScaleColor),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColor.greyscale200
                ),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(

                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: AppColor.redColor200,
                          borderRadius: BorderRadius.circular(1000)
                      ),
                      child: const Center(child: Icon(Icons.arrow_downward,color: AppColor.redColor,)),
                    ),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('75000',style: const TextStyle().normal16w700.textColor(AppColor.greyscale100),),
                        Text('Average sale',style: const TextStyle().normal12w500.textColor(AppColor.greyScaleColor),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(16)
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificationColumn(Map<String, dynamic> engine) {
    return Column(
      children: [
        Image.asset(AppImage.engine),
        const Gap(8),
        Text(engine['type'] ?? 'N/A'),
        const Gap(8),
        const Text('Horsepower'),
      ],
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text('90000 km', style: style);
      break;
    case 5:
      text = const Text('120000', style: style);
      break;
    case 8:
      text = const Text('150000', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '50K';
      break;
    case 2:
      text = '60K';
      break;
    case 3:
      text = '70k';
      break;
    case 5:
      text = '90k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
