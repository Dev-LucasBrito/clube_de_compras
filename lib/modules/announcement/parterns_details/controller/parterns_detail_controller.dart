import 'dart:io';

import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParternsDetailController extends GetxController {
  static ParternsDetailController to = Get.find();

  bool isLoading = true;
  int page = 0;

  var data = Modular.args.params;

  ParternsCashbackModel? parterns;

  RxString userId = ''.obs;

  bool connection = true;
  Color? mainColor;
  Color? secoundColor;

  setNewPage(value) {
    page = value;
    update();
  }

  setParternModel() async {
    isLoading = true;
    update();
    parterns = await ProviderApi()
        .associadoDetail(idAssociado: int.parse(data['slug'].toString().split('-').last.toString()));
    update();
    // getImagePalette(NetworkImage(parterns!.img));
    update();
    isLoading = false;
    update();
  }

  openWhatsApp(context) async {
    CashbackAlertDialog.showLoading(
        context: context, title: 'Abrindo whatsapp');
    var whatsapp = "+55${parterns!.whatsApp}";
    String whatsappURlAndroid =
        "whatsapp://send?phone=$whatsapp&text=Olá, vim pelo Clube de Compras Acicla";
    var whatappURLIos =
        "https://wa.me/$whatsapp?text=${Uri.parse("Olá, vim pelo Clube de Compras Acicla")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrlString(whatappURLIos)) {
        await launchUrlString(
          whatappURLIos,
        );
        Modular.to.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CashbackText.textPrimary(text: 'Whatsapp não instalado')));
        Modular.to.pop();
      }
    } else {
      // android , web
      if (await canLaunchUrlString(whatsappURlAndroid)) {
        await launchUrlString(whatsappURlAndroid);
        Modular.to.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: CashbackText.textPrimary(text: 'Whatsapp não instalado')));
        Modular.to.pop();
      }
    }
  }

  // Calculate dominant color from ImageProvider
  // Future<Color> getImagePalette(ImageProvider imageProvider) async {
  //   final PaletteGenerator paletteGenerator =
  //       await PaletteGenerator.fromImageProvider(imageProvider);
  //   mainColor = paletteGenerator.paletteColors[2].color;
  //   secoundColor = paletteGenerator.paletteColors[2].color;

  //   update();
  //   return paletteGenerator.dominantColor!.color;
  // }

  @override
  void onInit() {
    setParternModel();
    super.onInit();
  }
}












///// ANTES DE SUBIR IMPLEMENTAR O SITEMA DE ATUALIZAÇÃO AUTOMATICA 