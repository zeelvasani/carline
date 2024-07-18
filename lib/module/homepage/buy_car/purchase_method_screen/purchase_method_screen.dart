

import 'package:base_code/module/homepage/buy_car/purchase_method_screen/purchase_method_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';

class PurchaseMethodScreen extends StatefulWidget {
  const PurchaseMethodScreen({super.key});

  @override
  PurchaseMethodScreenState createState() => PurchaseMethodScreenState();
}

class PurchaseMethodScreenState extends State<PurchaseMethodScreen> {
  final purchaseMethodController =
      Get.put<PurchaseMethodController>(PurchaseMethodController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> car = Get.arguments;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 18),
          child: Text(
            'Purchase Method',
            style:
                const TextStyle().normal18w700.textColor(AppColor.greyscale100),
          ),
        ),
        titleSpacing: 67,
        backgroundColor: AppColor.white,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(right: 24.0, left: 24, top: 16, bottom: 16),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              car['logo'],
                              height: 28,
                              width: 40,
                              color: AppColor.blueColor1,
                            ),
                            Text(
                              car['name'],
                              style: const TextStyle()
                                  .normal18w700
                                  .textColor(AppColor.greyscale100),
                            ),
                            const Gap(4),
                            Row(
                              children: [
                                Image.asset(
                                  AppImage.filter,
                                  height: 16,
                                  width: 16,
                                ),
                                const Gap(4),
                                Text(car['engine type']),
                                const Gap(12),
                                Image.asset(
                                  AppImage.engine,
                                  height: 16,
                                  width: 16,
                                ),
                                const Gap(4),
                                Text(car['gair type']),
                              ],
                            )
                          ],
                        ),
                        Image.network(
                          car['design']['image3'],
                          height: 112,
                          width: 110,
                        )
                      ],
                    ),
                    const Gap(24),
                    const Divider(),
                    const Gap(24),
                    Row(
                      children: [
                        Text(
                          'Your purchase method',
                          style: const TextStyle()
                              .normal16w700
                              .textColor(AppColor.greyscale100),
                        ),
                        const Gap(4),
                        Image.asset(
                          AppImage.questionmark,
                          height: 16,
                          width: 16,
                        ),
                      ],
                    ),
                    const Gap(16),
                    GestureDetector(
                      onTap: () {
                        purchaseMethodController.selectedMethod.value =
                            'Financing';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color:
                                  purchaseMethodController.selectedMethod.value ==
                                          'Financing'
                                      ? AppColor.blueColor1
                                      : AppColor.greyscale200),
                          color: purchaseMethodController.selectedMethod.value ==
                                  'Financing'
                              ? AppColor.blueColor1
                              : AppColor.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      color: purchaseMethodController
                                                  .selectedMethod.value ==
                                              'Financing'
                                          ? AppColor.blueColor200
                                          : AppColor.greyscale200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.credit_card,
                                      size: 24,
                                      color: purchaseMethodController
                                                  .selectedMethod.value ==
                                              'Financing'
                                          ? AppColor.white
                                          : AppColor.black,
                                    ),
                                  ),
                                  const Gap(16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Financing',
                                        style: const TextStyle()
                                            .normal14w700
                                            .textColor(purchaseMethodController
                                                        .selectedMethod.value ==
                                                    'Financing'
                                                ? AppColor.white
                                                : AppColor.greyscale100),
                                      ),
                                      Text(
                                        'Everything simply online, approval\n within 30 minutes',
                                        style: const TextStyle()
                                            .normal10w400
                                            .textColor(purchaseMethodController
                                                        .selectedMethod.value ==
                                                    'Financing'
                                                ? AppColor.white100
                                                : AppColor.greyScaleColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  border:
                                      Border.all(color: AppColor.greyscale200),
                                  color: purchaseMethodController
                                              .selectedMethod.value ==
                                          'Financing'
                                      ? AppColor.blueColor1
                                      : AppColor.white,
                                ),
                                child: purchaseMethodController
                                            .selectedMethod.value ==
                                        'Financing'
                                    ? const Icon(Icons.check,
                                        size: 13, color: AppColor.white)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    GestureDetector(
                      onTap: () {
                        purchaseMethodController.selectedMethod.value = 'Cash';
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color:
                                  purchaseMethodController.selectedMethod.value ==
                                          'Cash'
                                      ? AppColor.blueColor1
                                      : AppColor.greyscale200),
                          color: purchaseMethodController.selectedMethod.value ==
                                  'Cash'
                              ? AppColor.blueColor1
                              : AppColor.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 56,
                                    width: 56,
                                    decoration: BoxDecoration(
                                      color: purchaseMethodController
                                                  .selectedMethod.value ==
                                              'Cash'
                                          ? AppColor.blueColor200
                                          : AppColor.greyscale200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Image.asset(AppImage.doller,
                                          height: 24,
                                          width: 24,
                                          color: purchaseMethodController
                                                      .selectedMethod.value ==
                                                  'Cash'
                                              ? AppColor.white
                                              : AppColor.black),
                                    ),
                                  ),
                                  const Gap(16),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cash',
                                        style: const TextStyle()
                                            .normal14w700
                                            .textColor(purchaseMethodController
                                                        .selectedMethod.value ==
                                                    'Cash'
                                                ? AppColor.white
                                                : AppColor.greyscale100),
                                      ),
                                      Text(
                                        'Everything simply online, approval\n within 30 minutes',
                                        style: const TextStyle()
                                            .normal10w400
                                            .textColor(purchaseMethodController
                                                        .selectedMethod.value ==
                                                    'Cash'
                                                ? AppColor.white100
                                                : AppColor.greyScaleColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  border:
                                      Border.all(color: AppColor.greyscale200),
                                  color: purchaseMethodController
                                              .selectedMethod.value ==
                                          'Cash'
                                      ? AppColor.blueColor1
                                      : AppColor.white,
                                ),
                                child: purchaseMethodController
                                            .selectedMethod.value ==
                                        'Cash'
                                    ? const Icon(Icons.check,
                                        size: 13, color: AppColor.white)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(24),
                    Container(
                      color: AppColor.textFieldFillColor,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0, bottom: 16),
                        child: Column(
                          children: [
                            Text(
                              'Carline promise',
                              style: const TextStyle()
                                  .normal16w700
                                  .textColor(AppColor.greyscale100),
                            ),
                            const Gap(16),
                            Row(
                              children: [
                                Image.asset(
                                  AppImage.check,
                                  width: 16,
                                  height: 16,
                                ),
                                const Gap(8),
                                Text(
                                  'Fixed Price, No Hidden Fees',
                                  style: const TextStyle()
                                      .normal12w500
                                      .textColor(AppColor.greyscale100),
                                )
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Image.asset(
                                  AppImage.check,
                                  width: 16,
                                  height: 16,
                                ),
                                const Gap(8),
                                Text(
                                  'Proof of car insurance',
                                  style: const TextStyle()
                                      .normal12w500
                                      .textColor(AppColor.greyscale100),
                                )
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Image.asset(
                                  AppImage.check,
                                  width: 16,
                                  height: 16,
                                ),
                                const Gap(8),
                                Text(
                                  'Proof of address, as recent as 30 days',
                                  style: const TextStyle()
                                      .normal12w500
                                      .textColor(AppColor.greyscale100),
                                )
                              ],
                            ),
                            const Gap(8),
                            Row(
                              children: [
                                Image.asset(
                                  AppImage.check,
                                  width: 16,
                                  height: 16,
                                ),
                                const Gap(8),
                                Text(
                                  'any additional owners present',
                                  style: const TextStyle()
                                      .normal12w500
                                      .textColor(AppColor.greyscale100),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CommonAppButton(
                  buttonType: ButtonType.enable,
                  style: const TextStyle().normal16w700.textColor(AppColor.white),
                  text: 'Continue',
                  onTap: () {
                    Get.toNamed(Routes.inspectionScreen, arguments: car);
                  },
                  color: AppColor.blueColor1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
