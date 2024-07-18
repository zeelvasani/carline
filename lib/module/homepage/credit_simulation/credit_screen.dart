import 'package:base_code/components/common_row.dart';
import 'package:base_code/module/homepage/credit_simulation/credit_screen_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  final creditScreenController =
  Get.put<CreditScreenController>(CreditScreenController());

  @override
  Widget build(BuildContext context) {
   // double totalPrice = 80063.0;
    //double downPayment = totalPrice * (_sliderValueDownPayment / 100);

    return Scaffold(
      backgroundColor: AppColor.greyscale100,
      appBar: AppBar(
        backgroundColor: AppColor.greyscale100,
        leading: const Icon(
          Icons.clear,
          size: 24,
          color: AppColor.white,
        ),
        title: Text(
          'Credit Simulation',
          style: const TextStyle().normal18w700.textColor(AppColor.white),
        ),
        titleSpacing: 88,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, right: 32, left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 327,
                  decoration: BoxDecoration(
                    color: AppColor.textFieldFillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 24, bottom: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Down payment",
                          style: const TextStyle().normal14w700.textColor(AppColor.greyscale100),
                        ),
                        const Gap(12),
                        Slider(
                          value: creditScreenController.sliderValueDownPayment.value,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: AppColor.blueColor1,
                          label: '${creditScreenController.sliderValueDownPayment.toStringAsFixed(0)}%',
                          onChanged: (value) {
                              creditScreenController.sliderValueDownPayment.value = value;
                          },
                        ),
                        Text(
                          '${creditScreenController.sliderValueDownPayment.toStringAsFixed(0)}%',
                          style: const TextStyle().normal14w700.textColor(AppColor.greyscale100),
                        ),
                        const Gap(16),
                        const Divider(),
                        const Gap(16),
                        Text(
                          "Loan tenor",
                          style: const TextStyle().normal14w700.textColor(AppColor.greyscale100),
                        ),
                        Slider(
                          value: creditScreenController.sliderValueLoanTenor.value,
                          min: 1,
                          max: 10,
                          activeColor: AppColor.greenColor100,
                          label: '${creditScreenController.sliderValueLoanTenor.toStringAsFixed(0)} years',
                          onChanged: (value) {
                              creditScreenController.sliderValueLoanTenor.value = value;
                          },
                        ),
                        Text(
                          '${creditScreenController.sliderValueLoanTenor.toStringAsFixed(0)} years',
                          style: const TextStyle().normal14w700.textColor(AppColor.greyscale100),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
                const CommonRow(leftText: 'Product type', rightText: 'Audi Q7 50 Quattro'),
                const Gap(16),
                const CommonRow(leftText: 'Down payment', rightText: '12000.00'),
                 const Gap(16),
                 CommonRow(leftText: 'Product type', rightText: creditScreenController.sliderValueLoanTenor.toStringAsFixed(0)),
                const Gap( 24),
                const Divider(),
                 const Gap(28),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Est. Monthly payment',
                        style: const TextStyle().normal14w500.textColor(AppColor.greyScaleColor)),
                    Text(
                        '970.00',
                        style: const TextStyle().normal14w500.textColor(AppColor.blueColor1)),
                    
                  ],
                ),
                const Gap(90),
                CommonAppButton(
                  buttonType: ButtonType.enable,
                    style: const TextStyle().normal16w700.textColor(AppColor.white),
                    text: 'Apply for financing',
                  onTap: (){

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
