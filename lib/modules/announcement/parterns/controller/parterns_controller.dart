import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:get/get.dart';

class ParternsController extends GetxController {

  static ParternsController to = Get.find();

  List<ParternsCashbackModel> parterns = [];

  RxString userId = ''.obs;

  bool connection = true;
  bool loadingBanersAssociados = true;

  getMuralAssociados() async {
    loadingBanersAssociados = true;
    update();
    parterns = await ProviderApi().listAssociadosMural();
    update();
    if (parterns.isEmpty) {
      loadingBanersAssociados = true;
      update();
    } else {
      loadingBanersAssociados = false;
      update();
    }
  }

  @override
  void onInit() {
  
    getMuralAssociados();
    super.onInit();
  }
}












///// ANTES DE SUBIR IMPLEMENTAR O SITEMA DE ATUALIZAÇÃO AUTOMATICA 