


import '../../../../package/config_packages.dart';

class PaymentController extends GetxController {
  var selectedPaymentMethod = ''.obs;








  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }


}
