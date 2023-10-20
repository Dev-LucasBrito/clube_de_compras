import 'package:get/get.dart';

import '../controller/parterns_controller.dart';


class ParternsBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(ParternsController());
  }

}