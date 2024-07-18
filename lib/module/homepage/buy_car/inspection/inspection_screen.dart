import 'package:base_code/components/common_row.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({super.key});

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  final Map<String, dynamic> car = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspection & Delivery',
          style:
              const TextStyle().normal18w700.textColor(AppColor.greyscale100),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 16.0, right: 24, left: 24, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Vehicle inspection',
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.greyscale200)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CommonAppButton(
                            height: 24,
                            width: 80,
                            borderRadius: 6,
                            buttonType: ButtonType.enable,
                            text: 'Initial Price',
                            style: const TextStyle()
                                .normal10w700
                                .textColor(AppColor.white),
                            color: AppColor.blueColor1,
                          ),
                        ),
                        Center(
                          child: Text(
                            car['price'],
                            style: const TextStyle()
                                .normal32w700
                                .textColor(AppColor.greyscale100),
                          ),
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            Image.asset(
                              AppImage.right,
                              height: 16,
                              width: 16,
                            ),
                            const Gap(8),
                            Text(
                              'Money-back guarantee if the car fails the\n inspection.',
                              style: const TextStyle()
                                  .normal12w500
                                  .textColor(AppColor.greenColor100),
                            ),
                          ],
                        ),
                        const Gap(16),
                        const Divider(),
                        const Gap(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See details',
                              style: const TextStyle()
                                  .normal14w700
                                  .textColor(AppColor.greyscale100),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 20,
                              color: AppColor.greyScale,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping address",
                      style: const TextStyle()
                          .normal16w700
                          .textColor(AppColor.greyscale100),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.addressScreen, arguments: car);
                      },
                      child: Text(
                        'Edit',
                        style: const TextStyle()
                            .normal16w700
                            .textColor(AppColor.blueColor1),
                      ),
                    )
                  ],
                ),
                const Gap(12),
                const Divider(),
                const Gap(12),
                const CommonRow(leftText: "Name", rightText: 'Saski Ropokova'),
                const Gap(12),
                const CommonRow(
                    leftText: "Street", rightText: 'Jackson Street 1314'),
                const Gap(12),
                const CommonRow(
                    leftText: "Phone number", rightText: '+1 234 567 00'),
                const Gap(24),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.gray700),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const CommonRow(
                            leftText: "Car Audit", rightText: '80,063.00'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: const TextStyle()
                                  .normal14w500
                                  .textColor(AppColor.greyScaleColor),
                            ),
                            Text(
                              '80,063.00',
                              style: const TextStyle()
                                  .normal16w700
                                  .textColor(AppColor.blueColor1),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            CommonAppButton(
              buttonType: ButtonType.enable,
              style: const TextStyle().normal16w700.textColor(AppColor.white),
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.paymentScreen, arguments: car);
              },
              color: AppColor.blueColor1,
            )
          ],
        ),
      ),
    );
  }
}
