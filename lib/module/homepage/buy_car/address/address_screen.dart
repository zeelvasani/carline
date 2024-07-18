import 'package:base_code/module/homepage/buy_car/address/address_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final addressController =
  Get.put<AddressController>(AddressController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_vert),
          Gap(24)
        ],
      ),
      body:   Padding(
        padding: const EdgeInsets.only(top: 12.0,bottom: 12,left: 24,right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CommonText(
                  hintText: 'Find a address...',
                  onChange: (val) {
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
                const Gap(24),
                // GestureDetector(
                //   onTap: () {
                //     purchaseMethodController.selectedMethod.value = 'Cash';
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       border: Border.all(
                //           color:
                //           purchaseMethodController.selectedMethod.value ==
                //               'Cash'
                //               ? AppColor.blueColor1
                //               : AppColor.greyscale200),
                //       color: purchaseMethodController.selectedMethod.value ==
                //           'Cash'
                //           ? AppColor.blueColor1
                //           : AppColor.white,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Row(
                //             children: [
                //               Container(
                //                 height: 56,
                //                 width: 56,
                //                 decoration: BoxDecoration(
                //                   color: purchaseMethodController
                //                       .selectedMethod.value ==
                //                       'Cash'
                //                       ? AppColor.blueColor200
                //                       : AppColor.greyscale200,
                //                   borderRadius: BorderRadius.circular(12),
                //                 ),
                //                 child: Center(
                //                   child: Image.asset(AppImage.doller,
                //                       height: 24,
                //                       width: 24,
                //                       color: purchaseMethodController
                //                           .selectedMethod.value ==
                //                           'Cash'
                //                           ? AppColor.white
                //                           : AppColor.black),
                //                 ),
                //               ),
                //               const Gap(16),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     'Cash',
                //                     style: const TextStyle()
                //                         .normal14w700
                //                         .textColor(purchaseMethodController
                //                         .selectedMethod.value ==
                //                         'Cash'
                //                         ? AppColor.white
                //                         : AppColor.greyscale100),
                //                   ),
                //                   Text(
                //                     'Everything simply online, approval\n within 30 minutes',
                //                     style: const TextStyle()
                //                         .normal10w400
                //                         .textColor(purchaseMethodController
                //                         .selectedMethod.value ==
                //                         'Cash'
                //                         ? AppColor.white100
                //                         : AppColor.greyScaleColor),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //           Container(
                //             height: 20,
                //             width: 20,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(1000),
                //               border:
                //               Border.all(color: AppColor.greyscale200),
                //               color: purchaseMethodController
                //                   .selectedMethod.value ==
                //                   'Cash'
                //                   ? AppColor.blueColor1
                //                   : AppColor.white,
                //             ),
                //             child: purchaseMethodController
                //                 .selectedMethod.value ==
                //                 'Cash'
                //                 ? const Icon(Icons.check,
                //                 size: 13, color: AppColor.white)
                //                 : null,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
            CommonAppButton(
              buttonType: ButtonType.enable,
              style: const TextStyle().normal16w700.textColor(AppColor.white),
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.paymentScreen);
              },
              color: AppColor.blueColor1,
            )
          ],
        ),
      ),
    );
  }
}
