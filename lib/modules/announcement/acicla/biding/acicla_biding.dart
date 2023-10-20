import 'package:cashback/modules/announcement/acicla/controller/acicla_controller.dart';
import 'package:get/get.dart';


class AciclaBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(AciclaController());
  }

}