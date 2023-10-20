import 'package:cashback/modules/menu/scratch_card/controller/scratch_card_controller.dart';
import 'package:get/get.dart';


class ScratchCardBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(ScratchCardController());
  }

}