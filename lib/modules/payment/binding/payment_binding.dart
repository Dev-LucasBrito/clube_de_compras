import 'package:cashback/modules/payment/controller/payment_controller.dart';
import 'package:get/get.dart';


class PaymentBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(PaymentController());

  }

}