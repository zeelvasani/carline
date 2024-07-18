import 'package:base_code/module/homepage/buy_car/payment/payment_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';
import 'package:pay/pay.dart';

import '../../../../payment_config.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? car;
  final PaymentController paymentController = Get.put(PaymentController());

  List<PaymentItem> _paymentItems = [];

  void onGooglePayResult(Map<String, dynamic> result) {
  }

  void onApplePayResult(Map<String, dynamic> result) {
  }

  @override
  void initState() {
    super.initState();
    car = (Get.arguments as Map<String, dynamic>?) ?? {};
    _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: car?['price'] ?? 'N/A',
        status: PaymentItemStatus.final_price,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
          style: const TextStyle().normal18w700.textColor(AppColor.greyscale100),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16, right: 24, left: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.greyscale100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Amount",
                          style: const TextStyle().normal16w700.textColor(AppColor.white),
                        ),
                        const Spacer(),
                        Text(
                          car?['price'] ?? 'N/A',
                          style: const TextStyle().normal16w700.textColor(AppColor.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(34),
                _buildPaymentMethodOption("Credit/Debit Card", AppImage.credit),
                const Gap(10),
                _buildPaymentMethodOption("Paypal", AppImage.credit),
                const Gap(10),
                ApplePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                      defaultApplePay),
                  paymentItems: _paymentItems,
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: onApplePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                GooglePayButton(
                  paymentConfiguration: PaymentConfiguration.fromJsonString(
                      defaultGooglePay),
                  paymentItems: _paymentItems,
                  type: GooglePayButtonType.buy,

                  width: 250,
                  margin: const EdgeInsets.only(top: 10.0),
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
            CommonAppButton(
              buttonType: ButtonType.enable,
              style: const TextStyle().normal16w700.textColor(AppColor.white),
              text: 'Continue',
              onTap: () {
                // Add your continue button action here
              },
              color: AppColor.blueColor1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(String method, String asset) {
    return GestureDetector(
      onTap: () {
        paymentController.selectPaymentMethod(method);
      },
      child: Obx(
            () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(asset),
                const SizedBox(width: 10),
                Text(method),
                const Spacer(),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(
                      color: paymentController.selectedPaymentMethod.value == method
                          ? AppColor.blueColor1
                          : AppColor.greyscale200,
                    ),
                  ),
                  child: Container(
                    height: 13,
                    width: 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(color: AppColor.greyscale200),
                      color: paymentController.selectedPaymentMethod.value == method
                          ? AppColor.blueColor1
                          : AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
