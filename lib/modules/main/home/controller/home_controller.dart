import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/banners_model.dart';
import 'package:cashback/core/models/mural_model.dart';
import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/models/promotions_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/main/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../statement/controller/statement_controller.dart';

class HomeController extends GetxController {
 AuthController authController = Get.find<AuthController>();
  static HomeController to = Get.find();

  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int page = 0;

  bool isLoading = true;

  List<PromotionsModel> promotions = [];

  List<BannersModel> banners = [];
  List<MuralModel> bannersAcicla = [];
  List<ParternsCashbackModel> parterns = [];

  List menu = [
    {
      'text': 'Raspadinha',
      'colors': [Colors.purpleAccent, Colors.purpleAccent.withOpacity(0.6)],
      'icon': FontAwesomeIcons.trophy
    },
    {
      'text': 'Alimentação',
      'colors': [
        CashbackThemes.primaryRegular,
        CashbackThemes.primaryRegular.withOpacity(0.6),
      ],
      'icon': FontAwesomeIcons.utensils
    },
    {
      'text': 'Tecnologia',
      'colors': [
        Colors.blue,
        Colors.blueAccent.withOpacity(0.6),
      ],
      'icon': FontAwesomeIcons.microchip
    },
    {
      'text': 'Saúde',
      'colors': [
        Colors.green,
        Colors.greenAccent.withOpacity(0.6),
      ],
      'icon': FontAwesomeIcons.heartPulse
    },
    {
      'text': 'Vestuário',
      'colors': [
        Colors.amber,
        Colors.amberAccent.withOpacity(0.6),
      ],
      'icon': FontAwesomeIcons.shirt
    },
    {
      'text': 'Ofertas',
      'colors': [Colors.pinkAccent, Colors.pinkAccent.withOpacity(0.6)],
      'icon': FontAwesomeIcons.bandcamp
    },
  ];

  RxString userId = ''.obs;

  bool loadingValueUser = true;
  bool valueVisibility = true;
  bool loadingBaners = true;
  bool loadingBanersAcicla = true;
  bool loadingBanersAssociados = true;
  bool loadingPromotions = true;

  getMuralAcicla() async {
    loadingBanersAcicla = true;
    update();
    bannersAcicla = await ProviderApi().listMuralHome();
    update();
    if (bannersAcicla.isEmpty) {
      loadingBanersAcicla = true;
      update();
    } else {
      loadingBanersAcicla = false;
      update();
    }
  }

  getBanners() async {
    ///BANERS SÃO OS ANUNCIOS PATROCINADOS
    loadingBaners = true;
    update();
    banners = await ProviderApi().listBannersHome();
    update();
    if (banners.isEmpty) {
      loadingBaners = true;
      update();
    } else {
      loadingBaners = false;
      update();
    }
  }

  getPromotions() async {
    loadingPromotions = true;
    update();
    promotions = await ProviderApi().listPromotionsHome();
    update();
    if (promotions.isEmpty) {
      loadingPromotions = true;
      update();
    } else {
      loadingPromotions = false;
      update();
    }
  }

  getMuralAssociados() async {
    loadingBanersAssociados = true;
    update();
    parterns = await ProviderApi().listAssociadosMuralHome();
    update();
    if (parterns.isEmpty) {
      loadingBanersAssociados = true;
      update();
    } else {
      loadingBanersAssociados = false;
      update();
    }
  }

  setPages(value) {
    if (value == 1) {
      Get.put(StatementController());
      Get.find<StatementController>().onInit();
    } else if (value == 3) {
      Get.put(ProfileController());
      Get.find<ProfileController>().onInit();
    } else if (value == 0) {
      Get.put(AuthController());

      page = 0;
      update();
    }
    page = value;
    update();
  }

  setVisibilityValue() {
    valueVisibility = !valueVisibility;
    update();
  }

  getPermetions() async {
    /// String? token = await FirebaseMessaging.instance.getToken();
  }

  refreshPage() async {
    await getBanners();
    await getPromotions();
    await getMuralAcicla();
    await getMuralAssociados();
    await authController.doubleSaldo(authController.cpf);
  }

  @override
  void onInit() async {
    page = 0;
    await getMuralAssociados();
    await getBanners();
    await getPromotions();
    await getMuralAcicla();

    update();
    super.onInit();
  }
}

