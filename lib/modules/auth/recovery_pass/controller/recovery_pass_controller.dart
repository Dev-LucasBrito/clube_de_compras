import 'package:cashback/core/components/snacks/snacks.dart';
import 'package:cashback/core/provider/provider_api.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class RecoveryPasswordController extends GetxController {
  //utilizado para mudar estado da tela quando email for enviado.
  bool sendEmail = false;

  //utilizado para habilitar botao de envio.
  RxBool enableButton = false.obs;

  RxBool verifyPassword = false.obs;
  bool isLoading = false;
  bool obscureText = true;
  bool isLoadingInvite = false;
  bool isLoadingNewPass = false;

  String code = '';
  int page = 0;

  final MaskedTextController cpfController =
      MaskedTextController(mask: '000.000.000-00');
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  GlobalKey<FormState> recoveryPasswordKey = GlobalKey<FormState>();

  setObscureText() {
    obscureText = !obscureText;
    update();
  }

  setNextPage() {
    page = 2;
    update();
  }

  verifyPass() {
    if (passwordController.text == passwordConfirmController.text) {
      verifyPassword.value = true;
      update();
    } else {
      verifyPassword.value = false;
      update();
    }
  }

  verifyEnableButton() {
    if (cpfController.text.isNotEmpty) {
      //print("entrei");
      enableButton.value = true;
      update();
    } else {
      enableButton.value = false;
      update();
    }
  }

  sendCode(context) async {
    isLoadingInvite = true;
    update();
   
    if (recoveryPasswordKey.currentState!.validate()) {
      
      code = await ProviderApi().recoveryPassword(cpf: cpfController.text, context: context);
      update();
      //print(code);
     
      if (code.isNotEmpty) {
        page = 1;
        update();
      } else {
        page = 0;
        update();
         CashbackSnackBar.snackbarCustom(
            title: 'Erro',
            description:
                'Erro inesperado, tente novamente mais tarde',
            context: context,
            bgColor: CashbackThemes.error,
            textColor: CashbackThemes.whiteCashback,
            iconType: 3);

      }
      //print("form state is Valid!");
      SystemChannels.textInput
          .invokeMethod('TextInput.hide'); //to hide the keyboard - if any

    }
    update();
    isLoadingInvite = false;
    update();
  }

  changePassword(context) async {
    isLoadingInvite = true;
    update();
    bool changePass = false;

    if (recoveryPasswordKey.currentState!.validate()) {

      changePass = await ProviderApi().changePassword(
          cpf: cpfController.text,
          token: code,
          novaSenha: passwordController.text, context: context);
      update();

      if(changePass){}


      //print("form state is Valid!");
      SystemChannels.textInput
          .invokeMethod('TextInput.hide'); //to hide the keyboard - if any

    }
    update();
    isLoadingInvite = false;
    update();
  }
}
