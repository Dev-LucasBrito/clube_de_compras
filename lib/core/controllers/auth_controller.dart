import 'dart:async';
import 'dart:convert';
import 'package:cashback/core/components/snacks/snacks.dart';
import 'package:cashback/core/models/user_model.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cashback/core/utils/validators.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  final MaskedTextController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  final TextEditingController passwordController = TextEditingController();

  var saldoController = MoneyMaskedTextController();

  UserModel? user;

  bool connection = true;
  bool isLoadingLogin = false;
  bool obscureText = true;

  dynamic internetConnect;

  UserModel fakeUser =
      UserModel(clientId: 0, name: '', email: '', cpf: '', token: '');

  double saldo = 0.0;
  String saldoString = '';
  String cpf = '';
  String md5P = '';
  bool saldoIsOk = false;
  bool updateCheck = true;

  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     _updateInfo = info;
  //     update();
  //   }).catchError((e) {});
  // }

  // updateApp() {
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     if (_updateInfo!.updateAvailability ==
  //         UpdateAvailability.updateAvailable) {

  //       if(updateCheck == false){

  //       }else{
  //          InAppUpdate.performImmediateUpdate()
  //           .catchError((e) => showSnack(e.toString())).then((value) => updateCheck = false);
  //       }

  //     }
  //   });
  // }

  setObscureText() {
    obscureText = !obscureText;
    update();
  }

  verifyLogedIn() async {
    final prefs = await SharedPreferences.getInstance();
    cpf.isNotEmpty ? prefs.setString('cpf', cpf) : null;
    //final body = (jsonDecode(prefs.getString('user')!));

    bool tutorial = (prefs.getBool('tutorial') ?? false);
    user = (prefs.getString('user') == null || prefs.getString('user') == ''
        ? fakeUser
        : UserModel.fromJsonInEnglish(
            jsonDecode(prefs.getString('user') ?? "")));
    // print('USEEEEER - ${user!.cpf}');

    cpf = cpf.isNotEmpty ? cpf : prefs.getString('cpf') ?? "";
    // print('USEEEEER cpd - ${cpf}');
    md5P = md5P.isNotEmpty ? md5P : prefs.getString('md5p') ?? "";

    update();
    await doubleSaldo(cpf);
    update();

    if (user!.token == '' || user!.token.isEmpty) {
      if (tutorial == false) {
        Future.delayed(const Duration(milliseconds: 1), () {
          Modular.to.navigate(AppRoutes.introScreen);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 1), () {
          Modular.to.navigate(AppRoutes.signIn);
        });
      }
    } else {
      if (Validator()
          .getFirstRouteHistory()
          .toString()
          .contains('/pagamento/realizar')) {
      } else if (Validator()
          .getFirstRouteHistory()
          .toString()
          .contains('associados/')) {
      } else if (Validator().getFirstRouteHistory().toString().contains('/')) {
        Future.delayed(const Duration(milliseconds: 1), () {
          Modular.to.navigate(AppRoutes.home);
        });
      } else {}
    }
  }

  doubleSaldo(String cpfs) async {
    Map<String, dynamic> userCashback =
        await ProviderApi().userCashback(cpf: cpfs);
    if (userCashback['status'] == 'SUCCESS') {
      saldo = userCashback['saldo'];
      saldoController.updateValue(userCashback['saldo']);
      update();

      saldoIsOk = true;
      saldoString = ' ${saldoController.text}';
    } else {
  
      await signOut();
      saldo = 0;
      saldoController.updateValue(0.0);
      saldoString = '0.0';
      saldoIsOk = false;
      saldoString = ' ${saldoController.text}';
    }
  }

  signOut() async {
    final prefs = await SharedPreferences.getInstance();
    cpf = '';
    md5P = '';

    updateValue(fakeUser);
    prefs.remove('user');
    prefs.remove('mdp');
    prefs.remove('cpf');

    prefs.setString('user', jsonEncode(fakeUser.toMap()));
    prefs.setString('cpf', '');
    prefs.setString('md5p', '');
    user = fakeUser;

    update();
    Modular.to.navigate(AppRoutes.signIn);
    update();
  }

  Future<bool> signUp(
      String mail, String password, String name, String cpff, context) async {
    final prefs = await SharedPreferences.getInstance();

    cpf = '';
    md5P = '';

    updateValue(fakeUser);
    prefs.remove('user');
    prefs.remove('mdp');
    prefs.remove('cpf');

    prefs.setString('user', jsonEncode(fakeUser.toMap()));
    prefs.setString('cpf', '');
    prefs.setString('md5p', '');
    user = fakeUser;

    update();
    bool success = false;

    UserModel? userSignup = await ProviderApi().signUp(
        mail: mail,
        name: name,
        password: password,
        cpf: cpff,
        context: context);
    cpf = cpff;

    update();

    if (userSignup.token != '') {
      success = true;

      updateValue(userSignup);
      update();

      prefs.setString('user', jsonEncode(userSignup.toMap()));
      prefs.setString('cpf', cpfController.text);
      prefs.setString(
          'md5p', md5.convert(utf8.encode(passwordController.text)).toString());
      update();
      await doubleSaldo(cpff);
      update();
    }

    update();
    return success;
  }

  Future<bool> signIn(context) async {
    final prefs = await SharedPreferences.getInstance();
    cpf = '';
    md5P = '';

    updateValue(fakeUser);
    prefs.remove('user');
    prefs.remove('mdp');
    prefs.remove('cpf');

    prefs.setString('user', jsonEncode(fakeUser.toMap()));
    prefs.setString('cpf', '');
    prefs.setString('md5p', '');
    user = fakeUser;

    update();

    isLoadingLogin = true;
    update();
    cpf = cpfController.text;

    if (signInFormKey.currentState!.validate()) {
      // print('ENTREI AQUI');
      final prefs = await SharedPreferences.getInstance();
      bool success = false;

      UserModel? userModelSignin = await ProviderApi()
          .signIn(cpfController.text, passwordController.text, context);

      update();
      if (userModelSignin!.token.isNotEmpty) {
        success = true;

        cpf = cpfController.text;
        md5P = md5.convert(utf8.encode(passwordController.text)).toString();
        prefs.setString('cpf', cpfController.text);
        prefs.setString('md5p',
            md5.convert(utf8.encode(passwordController.text)).toString());
        update();

        user = userModelSignin;
        userModelSignin.toMap();

        update();
        prefs.setString('user', jsonEncode(userModelSignin.toMap()));

        Modular.to.navigate(AppRoutes.home);
        isLoadingLogin = false;
        update();
        await doubleSaldo(cpf);
        update();
      } else {
        isLoadingLogin = false;
        update();
      }

      update();
      return success;
    } else {
      isLoadingLogin = false;
      update();
      CashbackSnackBar.snackbarCustom(
          title: 'Atenção',
          description: 'Todos os campos são obrigatórios',
          context: context,
          bgColor: CashbackThemes.primaryRegular,
          textColor: CashbackThemes.whiteCashback,
          iconType: 1);

      return false;
    }
  }

  updateValue(UserModel userModel) {
    user = userModel;
    AuthController.to.user = userModel;
    AuthController.to.update();
    AuthController.to.update();
  }

  getAuthToken() {
    Map<String, dynamic> tokenMap = <String, dynamic>{};

    tokenMap.putIfAbsent(
      'authorization',
      () => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQzYzQwNDg4'
          'LTA2NGQtNGQwYS1iNDRkLWZiMGQ3MDhjMDdhMiIsInJvbGVzIjoiYnV5ZXIiLCJpYX'
          'QiOjE2NDcwMTU3NjUsImV4cCI6MTY0NzAyMjk2NX0.WL0toyZCuEmF8bZM65aLu02nK'
          'BZb9rix_UWId9_nsf8',
    );

    return tokenMap;
  }

//  internetConnection() {
  //   var conectionStatus = ProviderSyx().getEventsList();
  //}

  internetCoonection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else if (connectivityResult == ConnectivityResult.ethernet) {}
  }

  @override
  void onInit() async {
    // checkForUpdate();
    internetConnect = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        connection = false;
        update();
      } else {
        //AuthController();
        Get.closeAllSnackbars();

        connection = true;
        // Get.closeCurrentSnackbar();
        update();
      }

      // Got a new connectivity status!
    });
    // ignore: avoid_print

    internetCoonection();
    await verifyLogedIn();
    // updateApp();
    super.onInit();
  }
}












///// ANTES DE SUBIR IMPLEMENTAR O SITEMA DE ATUALIZAÇÃO AUTOMATICA 