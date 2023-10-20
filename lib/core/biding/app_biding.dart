import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:get/get.dart';


class AppBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(AuthController(), permanent: true);
   // Get.lazyPut(() => SignUpController());
   // Get.lazyPut(() => AgendaController());
   // Get.lazyPut(() => EditWorkingHoursController());
    //Get.lazyPut(() => EditProfileController());
    //Get.lazyPut(() => AddServiceController());
    //Get.lazyPut(() => CalendarController());
    //Get.lazyPut(() => DailyScheduleController(), fenix: true);
  }

}