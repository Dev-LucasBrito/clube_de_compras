
import 'package:cashback/modules/main/home/controller/home_controller.dart';
import 'package:cashback/modules/main/profile/controller/profile_controller.dart';
import 'package:cashback/modules/main/statement/controller/statement_controller.dart';
import 'package:get/get.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(HomeController());
  Get.put(StatementController());
  Get.put(ProfileController());
  }

}