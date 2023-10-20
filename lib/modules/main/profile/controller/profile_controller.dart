import 'dart:convert';
import 'dart:io';

import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/models/image_upload_model.dart';
import 'package:cashback/core/models/user_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ProfileController extends GetxController {
  static ProfileController to = Get.find();
  AuthController authController = Get.find<AuthController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  ImageUploadModel? uploadModel;

  late ImagePicker picker;
  XFile? image;
  File? imageFile;

  bool hasImage = false;

  bool isLoading = true;

  pickImage(int value) async {
    if (value == 1) {
      image = await picker
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      )
          .then((value) {
        return value;
      });

      update();

      imageFile = File(image!.path);
      update();
    } else {
      image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      update();
      imageFile = File(image!.path);
      update();
    }
  }

  editUserData(String type, context) async {
    isLoading = true;
    update();

    final prefs = await SharedPreferences.getInstance();
    bool status = await ProviderApi().userEditData(
        id: authController.user!.clientId,
        senhaMd5: authController.md5P,
        name: nameController.text, context: context);

    if (status) {
      prefs.setString(
          'user',
          jsonEncode(UserModel(
                  clientId: authController.user!.clientId,
                  name: nameController.text,
                  email: authController.user!.email,
                  cpf: authController.user!.cpf,
                  token: authController.user!.token)
              .toMap()));
      authController.verifyLogedIn();
      authController.update();
      Modular.to.pop();
      isLoading = false;
      update();
    } else {
      Modular.to.pop();
      isLoading = false;
      update();
    }
  }

  deleteAccount(context) {
    isLoading = true;
    update();
    ProviderApi().deleteAccount(
        id: int.parse(authController.user!.clientId.toString()),
        password: authController.md5P, context: context);
    update();
    Get.find<AuthController>().signOut();
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    picker = ImagePicker();

    super.onInit();
    isLoading = false;
    update();
  }
}
