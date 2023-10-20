import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:cashback/modules/main/home/controller/home_controller.dart';
import 'package:cashback/modules/main/statement/controller/statement_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cashback/modules/payment/pages/payment_checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:share_plus/share_plus.dart';

import '../../../core/models/statement_model.dart';

class PaymentController extends GetxController
    with GetTickerProviderStateMixin {
  static PaymentController to = Get.find();
  HomeController homeController = Get.put(HomeController());
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  MoneyMaskedTextController valuePrice = MoneyMaskedTextController();
  MaskedTextController secretkey =
      MaskedTextController(mask: '00.000.000/0000-00');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  var saldoController = MoneyMaskedTextController();

   AuthController authController = Get.find<AuthController>();

  AnimationController? animationController;
  Animation<double>? animation;

  String userValueCashback = '';
  RxString cnpjWritten = ''.obs;

  //RxList<String> cnpj = ['00.000.000/0000-00'].obs;

  RxString paymentUser = ''.obs;
  RxString paymentId = ''.obs;
  RxString owner = ''.obs;
  RxString destino = ''.obs;
  RxDouble valor = 0.0.obs;

  DateTime datePayment = DateTime.now();

  StatusPayment statusPayment = StatusPayment.loading;

  ScreenshotController screenshot = ScreenshotController();

  bool isLoadingShared = false;
  bool isLoadingScaan = false;
  bool isLoadinAssociados = true;
  bool statusQr = false;

  StatementModel? statementModel;

  ParternsCashbackModel? parternsCashbackModel;
  var data = Modular.args.queryParams;

  //79.547.873/0001-79

  setStatusQr(value) {
    statusQr = value;
    update();
  }

  setNewStatus(value, int id) async {
    if (value == StatusPayment.approved) {
      statusPayment = value;
      update();

      Future.delayed(const Duration(seconds: 2), () async {
        varifyStatement(id);
      });
    } else {
      statusPayment = value;
      update();
    }

    animationSucess();
  }

  varifyStatement(int id) async {
    statementModel = await ProviderApi()
        .userMovimentationDetail(cpf: authController.cpf, id: id);

    if (statementModel == null) {
      Get.find<AuthController>().onInit();
      Get.find<HomeController>().onInit();
      Get.find<StatementController>().onInit();

      Modular.to.navigate(AppRoutes.splash);
      Future.delayed(const Duration(milliseconds: 1), () {
        Get.delete<PaymentController>();
      });
    } else {
      statusPayment = StatusPayment.ressume;
      update();
    }
    update();
  }

  paymentFunction() async {
    statusPayment = StatusPayment.loading;

    double valor;
    if (valuePrice.text.contains('.')) {
      valor = double.parse(
          valuePrice.text.replaceAll('.', '').replaceAll(',', '.'));
    } else {
      valor = double.parse(valuePrice.text.replaceAll(',', '.'));
    }
    update();

    Map<String, dynamic> pay = await ProviderApi()
        .payment(valor: valor, cpf: authController.cpf, cnpj: secretkey.text);

    if (pay['status'] == StatusPayment.approved) {
      Future.delayed(const Duration(seconds: 2), () {
        setNewStatus(pay['status'], int.parse(pay['id'].toString()));
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        setNewStatus(pay['status'], 0);
      });
    }
  }

  Future saveAndShared(Uint8List bytes) async {
    isLoadingShared = true;
    update();
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/comprovante.webp');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
    isLoadingShared = false;
    update();
  }

  // successPayment() {
  //   Future.delayed(Duration(seconds: 2), () {
  //     setNewStatus(StatusPayment.RESSUME);
  //   });
  // }

  animationSucess() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.ease,
    );
    if (animationController!.status == AnimationStatus.forward ||
        animationController!.status == AnimationStatus.completed) {
      animationController!.reverse();
    } else {
      animationController!.forward();
    }
  }

  startAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeIn,
    );
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  valuePaymentUser(value) {
    paymentUser.value = value;
  }

  validateValue(value) {
    cnpjWritten.value = value;
  }

  getAssociado() async {
    if (parternsCashbackModel != null) {
      if (parternsCashbackModel!.title.isNotEmpty) {
      } else {
        isLoadinAssociados = true;
        update();

        parternsCashbackModel =
            await ProviderApi().associadoDetailPayment(cnpj: secretkey.text);
        update();

        isLoadinAssociados = false;
        update();
      }
    } else {
      isLoadinAssociados = true;
      update();

      parternsCashbackModel =
          await ProviderApi().associadoDetailPayment(cnpj: secretkey.text);
      update();

      isLoadinAssociados = false;
      update();
    }
  }

  //void onQRViewCreated(QRViewController controller) async {
  //  this.controller = controller;
  //  await controller.resumeCamera();
  //  controller.scannedDataStream.listen((scanData) async {
  //
  //    isLoadingScaan = true;
  //    update();
  //    result = scanData;
  //    destino.value = jsonDecode(scanData.code!)['destino'];
  //
  //    secretkey.updateText(destino.value);
  //    valor.value =
  //        double.parse(jsonDecode(scanData.code!)['valor'].toString());
  //
  //    paymentUser.value = valor.value.toString();
  //    update();
  //    getAssociado();
//
  //    Future.delayed(const Duration(seconds: 2), () async {
  //      if (destino.isNotEmpty) {
  //        valuePrice.updateValue(valor.value);
  //        secretkey.updateText(destino.value);
  //        isLoadingScaan = false;
  //        Modular.to.pushNamed(AppRoutes.paymentValue);
  //        update();
  //      } else {
  //        isLoadingScaan = false;
  //        update();
  //      }
  //    });
  //  });
  //}

  readingOfQrCodeInternal(Map data2) async {
    log(data2['destino']);
    log(data2['valor']);

    if (data2['destino'] != null && data['destino'].toString().isNotEmpty) {
      secretkey.updateText(data2['destino']!);
      isLoadingScaan = true;
      destino.value = secretkey.text;
      secretkey.updateText(destino.value);
      valor.value = double.parse(data2['valor']!);

      paymentUser.value = valor.value.toString();
      update();
      getAssociado();
      Future.delayed(const Duration(seconds: 2), () async {
        if (destino.isNotEmpty) {
          valuePrice.updateValue(valor.value);
          secretkey.updateText(destino.value);
          isLoadingScaan = false;
        } else {
          isLoadingScaan = false;
          update();
        }
      });
    }

    update();
  }

  readingOfQrCodeExternal() async {
    if (data['destino'] != null && data['destino'].toString().isNotEmpty) {
      secretkey.updateText(data['destino']!);
      isLoadingScaan = true;
      destino.value = secretkey.text;
      secretkey.updateText(destino.value);
      valor.value = double.parse(data['valor']!);

      paymentUser.value = valor.value.toString();
      update();
      getAssociado();
      Future.delayed(const Duration(seconds: 2), () async {
        if (destino.isNotEmpty) {
          valuePrice.updateValue(valor.value);
          secretkey.updateText(destino.value);
          isLoadingScaan = false;
        } else {
          isLoadingScaan = false;
          update();
        }
      });
    }

    update();
  }

  doubleSaldo(String cpfs) async {
    Map<String, dynamic> userCashback =
        await ProviderApi().userCashback(cpf: cpfs);

    if (userCashback['status'] == 'SUCCESS') {
      saldoController.updateValue(userCashback['saldo']);
      update();

      userValueCashback = saldoController.text;

      update();
    } else {
      saldoController.updateValue(0.0);
      userValueCashback = saldoController.text;
    }
  }

  void reassemble() {
    if (Platform.isAndroid) {
      //    controller!.resumeCamera();
    } else if (Platform.isIOS) {
      //   controller!.resumeCamera();
    }
    //  super.reassemble();
  }

  fn() {
    if (authController.saldoString.isEmpty) {
      doubleSaldo(authController.cpf);

      Get.find<AuthController>().doubleSaldo(authController.cpf);
      userValueCashback = authController.saldoString;
      userValueCashback = authController.saldoString;
      doubleSaldo(authController.cpf);
    } else {
      doubleSaldo(authController.cpf);

      userValueCashback = authController.saldoString;
    }
  }

  @override
  void onInit() async {
    await fn();

    animationSucess();
    readingOfQrCodeExternal();
    update();
    super.onInit();
  }
}
