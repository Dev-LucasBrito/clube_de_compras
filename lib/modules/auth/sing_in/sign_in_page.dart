import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/forms/cashback_inputs.dart';
import 'package:cashback/core/components/hero/cashback_hero.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/core/utils/validators.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../recovery_pass/controller/recovery_pass_controller.dart';
import '../recovery_pass/recovery_pass_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);

    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                key: controller.signInFormKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CashbackHero.heroContainer(),
                          const SizedBox(
                            height: 15,
                          ),
                          CashbackText.textPrimary(text: 'Entre', fontSize: 21),
                          const SizedBox(
                            height: 9,
                          ),
                          CashbackText.textSecundary(
                              text: 'E comece a ganhar cashback!'),
                          const SizedBox(
                            height: 31,
                          ),
                          FormInputFieldWithIcon(
                              controller: controller.cpfController,
                              iconPrefix: Icons.person,
                              textInputAction: TextInputAction.next,
                              labelText: 'CPF',
                              inputBorder: InputBorder.none,
                              keyboardType: TextInputType.number,
                              autofocus: false,
                              validator: (value) {
                                return Validator.cpf(value);
                              },
                              onFieldSubmitted: (_) => node.nextFocus(),
                              onChanged: (_) => {},
                              onSaved: (_) => {}),
                          const SizedBox(
                            height: 21,
                          ),
                        
                              FormInputFieldWithIcon(
                                  labelText: 'Senha',
                                  iconPrefix: Icons.lock,
                                  minLines: 1,
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
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Get.put(RecoveryPasswordController());
                              CashbackAlertDialog.alertOutWidget(
                                  context: context,
                                  widget: const RecovaryPasswordPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CashbackText.textSecundary(
                                    text: 'Esqueci minha '),
                                CashbackText.textPrimary(
                                    text: 'senha!',
                                    color: CashbackThemes.primaryRegular),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 41,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: CashbackButtons.cashbackButtonWithLoading(
                                  onTap: () {
                                    controller.signIn(context);
                                  },
                                  context: context,
                                  isLoading: controller.isLoadingLogin,
                                  title: 'ENTRAR')),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Modular.to.pushNamed(AppRoutes.signUp);
                            },
                            child: Center(
                                child: CashbackText.textSecundary(
                                    text: 'Ainda não tem uma conta?')),
                          ),
                          InkWell(
                            onTap: () {
                              Modular.to.pushNamed(AppRoutes.signUp);
                            },
                            child: Center(
                                child: CashbackText.textPrimary(
                                    text: 'Criar conta!',
                                    color: CashbackThemes.primaryRegular)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
