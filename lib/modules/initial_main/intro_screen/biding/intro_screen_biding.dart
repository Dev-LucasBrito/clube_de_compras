import 'package:cashback/modules/initial_main/intro_screen/controller/intro_screen_controller.dart';
import 'package:get/get.dart';




class IntroScreenBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(IntroScreenController());
  }

}