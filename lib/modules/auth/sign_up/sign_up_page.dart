import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/forms/cashback_inputs.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'controller/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);

    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) {
        return Scaffold(
          appBar: CashbackAppBar.appBarBack(onTap: () {}),
          body: controller.isLoading
              ? CashbackLoading.cashbackLoadingScaffold(title: 'Criando conta...')
              : Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Form(
                          key: controller.signUpFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //CashbackHero.heroContainer(),
                              const SizedBox(
                                height: 15,
                              ),
                              CashbackText.textPrimary(
                                  text: 'Falta pouco', fontSize: 21),
                              const SizedBox(
                                height: 9,
                              ),
                              CashbackText.textSecundary(
                                  text: 'para você comprar e ganhar!'),
                              const SizedBox(
                                height: 31,
                              ),
                              const SizedBox(
                                height: 31,
                              ),
                              FormInputFieldWithIcon(
                                  controller: controller.nameController,
                                  iconPrefix: Icons.person,
                                  textInputAction: TextInputAction.next,
                                  labelText: 'Nome',
                                  inputBorder: InputBorder.none,
                                  autofocus: false,
                                  validator: (value) {
                                    return Validator.name(value);
                                  },
                                  onFieldSubmitted: (_) => node.nextFocus(),
                                  onChanged: (_) {},
                                  onSaved: (_) => {}),
                              const SizedBox(
                                height: 21,
                              ),
                              FormInputFieldWithIcon(
                                  controller: controller.cpfController,
                                  iconPrefix: Icons.verified_user,
                                  textInputAction: TextInputAction.next,
                                  labelText: 'CPF',
                                  inputBorder: InputBorder.none,
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
                                  controller: controller.emailController,
                                  iconPrefix: Icons.email,
                                  textInputAction: TextInputAction.next,
                                  labelText: 'E-mail',
                                  inputBorder: InputBorder.none,
                                  maxLines: 1,
                                  autofocus: false,
                                  validator: (value) {
                                    return Validator.email(value);
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

                              const SizedBox(
                                height: 31,
                              ),

                              ///Termos de uso e Politicas
                              Center(
                                child: CashbackText.textPrimary(
                                  text: 'Ao inscrever-se, você aceita nossa',
                                  color: CashbackThemes.primaryText,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: CashbackText.textButtonUnderline(
                                      text: 'política de privacidade'.toUpperCase(),
                                      // onPressed: ()=>Modular.to.pushNamed(AppRoutes.termsPrivacyPolicy),
                                      onPressed: () async {
                                        await launchUrlString(
                                            'https://clubedecompras.app.br/politica');
                                      },
                                    ),
                                  ),
                                  CashbackText.textPrimary(
                                    text: 'e',
                                    color: CashbackThemes.primaryText,
                                    fontSize: 14,
                                  ),
                                  Flexible(
                                    child: CashbackText.textButtonUnderline(
                                      text: 'termos de uso'.toUpperCase(),
                                      // onPressed: ()=>Modular.to.pushNamed(AppRoutes.termsOfUse),
                                      onPressed: () async {
                                        await launchUrlString(
                                            'https://clubedecompras.app.br/politica');
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 21,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: CashbackButtons.cashbackButton(
                                      onTap: () async {
                                        controller.signUp(context);
                                        // Modular.to.pushNamed(AppRoutes.home);
                                      },
                                      context: context,
                                      title: 'Criar conta')),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }
    );
  }
}
