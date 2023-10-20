import 'dart:async';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  AuthController authController = Get.put(AuthController());
  static SignUpController to = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final MaskedTextController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  RxString userId = ''.obs;

  bool connection = true;
  bool isLoading = true;
  bool obscureText = true;

  setObscureText() {
    obscureText = !obscureText;
    update();
  }

  signUp(context) async {
    if (!signUpFormKey.currentState!.validate()) {
    } else {
      //    isLoading = true;
      //  update();
      bool createAccount = await authController.signUp(
          emailController.text,
          passwordController.text,
          nameController.text,
          cpfController.text,
          context);
      if (createAccount) {
        Modular.to.navigate(AppRoutes.home);
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.delete<SignUpController>();
        });
      } else {}
      //   update();
      //   isLoading = false;
      //   update();
    }
  }

  @override
  void onInit() {
    isLoading = false;
    update();
    super.onInit();
  }
}












///// ANTES DE SUBIR IMPLEMENTAR O SITEMA DE ATUALIZAÇÃO AUTOMATICA 