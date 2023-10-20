import 'dart:math';

import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScratchCardController extends GetxController
    with GetTickerProviderStateMixin {
   AuthController authController = Get.find<AuthController>();
  static ScratchCardController to = Get.find();

  late ConfettiController controllerCenter;

  RxString userId = ''.obs;

  bool connection = true;

  @override
  void onInit() {
    Future.delayed( const Duration(microseconds: 500), () {
      CashbackAlertDialog.alertPassScratch(
        context: Get.context,
      );
    });
    controllerCenter = ConfettiController(duration: const Duration(seconds: 3));
    super.onInit();
  }

  @override
  void dispose() {
    controllerCenter.dispose();
   
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}














///// ANTES DE SUBIR IMPLEMENTAR O SITEMA DE ATUALIZAÇÃO AUTOMATICA 