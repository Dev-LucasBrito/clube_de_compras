import 'package:cashback/core/models/mural_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:get/get.dart';

class AciclaController extends GetxController {
  static AciclaController to = Get.find();

  bool loadingBanersAcicla = true;

  List<MuralModel> bannersAcicla = [];

  getMuralAcicla() async {
    loadingBanersAcicla = true;
    update();
    bannersAcicla = await ProviderApi().listMural();
    update();
    if (bannersAcicla.isEmpty) {
      loadingBanersAcicla = true;
      update();
    } else {
      loadingBanersAcicla = false;
      update();
    }
  }

  @override
  void onInit() {
    getMuralAcicla();
    
    super.onInit();
  }
}
