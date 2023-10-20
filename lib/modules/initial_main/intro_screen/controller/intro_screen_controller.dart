import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreenController extends GetxController {
  static IntroScreenController to = Get.find();

  bool isLoading = true;

  final introKey = GlobalKey<IntroductionScreenState>();

  List<PageViewModel> page = [];

  void onIntroEnd() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('tutorial', true);
    Modular.to.pushNamed(AppRoutes.signIn);
  }

  getIntroPage() {
    isLoading = true;
    update();
  }

}
