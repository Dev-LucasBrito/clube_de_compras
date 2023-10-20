
import 'package:cashback/modules/announcement/promotions/controller/promotions_controller.dart';
import 'package:get/get.dart';


class PromotionsBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(PromotionsController());
  }

}