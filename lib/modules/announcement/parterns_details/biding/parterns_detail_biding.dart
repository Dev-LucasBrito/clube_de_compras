import 'package:get/get.dart';

import '../controller/parterns_detail_controller.dart';


class ParternsDetailBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(ParternsDetailController());
  }

}