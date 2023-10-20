import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/promotions_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:get/get.dart';

class PromotionsController extends GetxController {
  static PromotionsController to = Get.find();

  bool loadingPromotions = true;

  List<PromotionsModel> promotions = [];

  RxString userId = ''.obs;

  bool connection = true;

  getPromotions() async {
    loadingPromotions = true;
    update();
    promotions = await ProviderApi().listPromotions();
    update();
    if (promotions.isEmpty) {
      loadingPromotions = true;
      update();
    } else {
      loadingPromotions = false;
      update();
    }
  }

  @override
  void onInit() {
  
    getPromotions();
    super.onInit();
  }
}

///// ANTES DE SUBIR IMPLEMENTAR O SITEMA DE ATUALIZAÇÃO AUTOMATICA
