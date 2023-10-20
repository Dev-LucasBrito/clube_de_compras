import 'package:cashback/modules/main/profile/controller/profile_controller.dart';
import 'package:get/get.dart';


class ProfileBiding extends Bindings{
  @override
  void dependencies() {
  Get.put(ProfileController());

  }

}