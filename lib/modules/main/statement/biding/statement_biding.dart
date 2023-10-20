
import 'package:cashback/modules/main/statement/controller/statement_controller.dart';
import 'package:get/get.dart';


class StatementBinding extends Bindings{
  @override
  void dependencies() {
  Get.put(StatementController());
  }

}