import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/forms/cashback_inputs.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/components/snacks/snacks.dart';
import '../../../core/utils/validators.dart';
import 'component/content_top_widget.dart';
import 'controller/recovery_pass_controller.dart';

class RecovaryPasswordPage extends StatelessWidget {
  final bool status;
  const RecovaryPasswordPage({
    Key? key,
    this.status = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecoveryPasswordController>(
        init: RecoveryPasswordController(),
        builder: (controller) {
          return ListView(
            shrinkWrap: true,
            children: [
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: controller.isLoading
                    ? Center(
                        child: SizedBox(
                            height: 200,
                            width: 100,
                            child: CashbackLoading.cashbackLoadingScaffold(
                                title: 'Carregando...')),
                      )
                    : Form(
                        key: controller.recoveryPasswordKey,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              padding:
                                  const EdgeInsets.only(right: 14, top: 14),
                              child: TextButton(
                                onPressed: () {
                                  Modular.to.pop();
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    Get.delete<RecoveryPasswordController>();
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 28,
                                  color: CashbackThemes.secundaryText,
                                ),
                              ),
                            ),

                            //CONTEUDO TOPO
                            ContentTopRecoveryPassword(
                              title: controller.page == 1
                                  ? "Instruções enviadas!"
                                  : controller.page == 0
                                      ? status == false
                                          ? "Esqueceu sua senha?"
                                          : "Alterar senha"
                                      : "Nova senha",
                              text: controller.page == 1
                                  ? status == false
                                      ? 'Enviamos um código para o email vinculado ao cpf -  ${controller.cpfController.text}. Digite a baixo o código para recupereção de senha'
                                      : 'Enviamos um código para o email vinculado ao cpf -  ${controller.cpfController.text}. Digite a baixo o código para alterar sua senha'
                                  : controller.page == 0
                                      ? status == false
                                          ? "Informe o CPF utilizado no cadastro e enviaremos as instruções para a recuperação da senha."
                                          : "Informe o CPF utilizado no cadastro e enviaremos as instruções para a alteração da senha."
                                      : "Insira e confirme sua nova senha.",
                            ),
                            const SizedBox(
                              height: 32,
                            ),

                            ///EMAIL
                            Visibility(
                              visible: controller.page == 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FormInputFieldWithIcon(
                                  labelText: 'CPF',
                                  iconPrefix: Icons.person,
                                  controller: controller.cpfController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => Validator.cpf(value),
                                  onChanged: (value) {
                                    if (value.length == 14) {
                                      SystemChannels.textInput.invokeMethod(
                                          'TextInput.hide'); //to hide the keyboard - if any
                                      Validator.cpf(value);
                                    } else {
                                      Validator.cpf(value);
                                    }
                                  },
                                  onSaved: (_) {},
                                  newIcon: Icons.clear,
                                  hasNewIcon: true,
                                  iconFunction: () =>
                                      controller.cpfController.clear(),
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),

                            //BUTTON PARA ENVIAR EMAIL
                            Visibility(
                              visible: controller.page == 0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child:
                                    CashbackButtons.cashbackButtonWithLoading(
                                  context: context,
                                  onTap: () => controller.sendCode(context),
                                  isLoading: controller.isLoadingInvite,
                                  title: status == false
                                      ? 'recuperar senha'.toUpperCase()
                                      : 'ENVIAR'.toUpperCase(),
                                ),
                              ),
                            ),

                            Visibility(
                                visible: controller.page == 1,
                                child: const SizedBox(
                                  height: 21,
                                )),
                            //BUTTON APOS EMAIL FOR ENVIADO
                            Visibility(
                              visible: controller.page == 1,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 30),
                                  child: PinCodeTextField(
                                    appContext: context,
                                    pastedTextStyle: TextStyle(
                                      color: Colors.green.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    length: 6,
                                    obscureText: false,
                                    // obscuringCharacter: '*',

                                    blinkWhenObscuring: true,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if (v!.toLowerCase() ==
                                          controller.code
                                              .toString()
                                              .toLowerCase()) {
                                        return "Validado";
                                      } else {
                                        return null;
                                      }
                                    },
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: Colors.white,
                                      inactiveColor:
                                          CashbackThemes.greyCashbackRegular,
                                      disabledColor:
                                          CashbackThemes.greyCashbackRegular,
                                      activeColor:
                                          CashbackThemes.primaryRegular,
                                      selectedColor:
                                          CashbackThemes.primaryRegular,
                                      selectedFillColor:
                                          CashbackThemes.primaryRegular,
                                      inactiveFillColor:
                                          CashbackThemes.greyCashbackRegular,
                                    ),
                                    cursorColor: Colors.black,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    enableActiveFill: true,
                                    //  errorAnimationController: errorController,
                                    //controller: textEditingController,
                                    keyboardType: TextInputType.text,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      )
                                    ],
                                    onCompleted: (v) {
                                      if (v.toLowerCase() ==
                                          controller.code
                                              .toString()
                                              .toLowerCase()) {
                                        SystemChannels.textInput.invokeMethod(
                                            'TextInput.hide'); //to hide the keyboard - if any

                                        controller.setNextPage();
                                      } else {
                                         CashbackSnackBar.snackbarCustom(
                                            title: 'Erro',
                                            description:
                                                'Código inválido',
                                            context: context,
                                            bgColor: CashbackThemes.error,
                                            textColor: CashbackThemes.whiteCashback,
                                            iconType: 3);
                                      
                                      }
                                    },

                                    onChanged: (value) {},
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                  )),
                            ),

                            Visibility(
                              visible: controller.page == 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FormInputFieldWithIcon(
                                  labelText: 'Nova Senha',
                                  iconPrefix: Icons.password_outlined,
                                  controller: controller.passwordController,
                                  validator: (_) => null,
                                  onEditingComplete: () {
                                    // controller.setLoginFunction(context);
                                  },
                                  obscureText: controller.obscureText,
                                  newIcon: controller.obscureText
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  hasNewIcon: true,
                                  maxLines: 1,
                                  iconFunction: () {
                                    controller.setObscureText();
                                  },
                                  onChanged: (_) {},
                                  onSaved: (_) {},
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ),

                            Visibility(
                                visible: controller.page == 2,
                                child: const SizedBox(
                                  height: 21,
                                )),

                            Visibility(
                              visible: controller.page == 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FormInputFieldWithIcon(
                                  iconPrefix: Icons.password_sharp,
                                  labelText: 'Confirmar Senha',
                                  controller:
                                      controller.passwordConfirmController,
                                  validator: (value) => Validator()
                                      .passwordConfirm(value,
                                          controller.passwordController.text),
                                  onEditingComplete: () {
                                    SystemChannels.textInput.invokeMethod(
                                        'TextInput.hide'); //to hide the keyboard - if any

                                    // controller.setLoginFunction(context);
                                  },
                                  obscureText: controller.obscureText,
                                  hasNewIcon: true,
                                  newIcon: controller.obscureText
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  maxLines: 1,
                                  iconFunction: () {
                                    controller.setObscureText();
                                  },
                                  onChanged: (_) => controller.verifyPass(),
                                  onSaved: (_) {},
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
                            ),

                            Visibility(
                                visible: controller.page == 2,
                                child: const SizedBox(
                                  height: 21,
                                )),
                            Visibility(
                              visible: controller.page == 2,
                              child: CashbackButtons.cashbackButtonWithLoading(
                                  onTap: () {
                                    controller.changePassword(context);
                                  },
                                  isLoading: controller.isLoadingNewPass,
                                  title: 'SALVAR',
                                  context: context),
                            ),

                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          );
        });
  }
}
