import 'dart:io';

import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/modal/cashback_modal.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/auth/recovery_pass/controller/recovery_pass_controller.dart';
import 'package:cashback/modules/auth/recovery_pass/recovery_pass_page.dart';
import 'package:cashback/modules/main/profile/components/card_list.dart';
import 'package:cashback/modules/main/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return UpgradeAlert(
            upgrader: Upgrader(
                showIgnore: false,
                showLater: false,
                shouldPopScope: () => false,
                dialogStyle: Platform.isIOS
                    ? UpgradeDialogStyle.cupertino
                    : UpgradeDialogStyle.material,
                showReleaseNotes: false,
                minAppVersion: '1.0.7'),
            child: Scaffold(
              backgroundColor: CashbackThemes.darkCashback,
              body: controller.isLoading
                  ? CashbackLoading.cashbackLoadingScaffold(
                      title: 'Carregando...')
                  : SafeArea(
                      child: ListView(
                        children: [
                          Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  Container(
                                    color: CashbackThemes.darkCashback,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 21,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CashbackText.textPrimary(
                                                text: 'Sua conta',
                                                fontSize: 21,
                                                color: CashbackThemes
                                                    .whiteCashback),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            CashbackText.textSecundary(
                                                text: controller
                                                    .authController.user!.name,
                                                fontSize: 15,
                                                color: CashbackThemes
                                                    .whiteCashback),
                                          ],
                                        ),
                                        const Spacer(),
                                        Visibility(
                                          visible: false,
                                          child: Align(
                                            child: InkWell(
                                              onTap: () {
                                                CashbackModals
                                                    .modalWidgetListColumn(
                                                        context, [
                                                  CardListComponent(
                                                      icon: Icons.image,
                                                      text: 'Galeria',
                                                      subText: '',
                                                      color: CashbackThemes
                                                          .primaryRegular,
                                                      onTap: () {
                                                        controller.pickImage(1);
                                                      }),
                                                  CardListComponent(
                                                      icon: Icons.camera,
                                                      text: 'Câmera',
                                                      subText: '',
                                                      color: CashbackThemes
                                                          .primaryRegular,
                                                      onTap: () {
                                                        controller.pickImage(2);
                                                      }),
                                                ]);
                                              },
                                              child: Container(
                                                height: 80,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: CashbackThemes
                                                        .greyCashbackRegular,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: controller.imageFile !=
                                                        null
                                                    ? Image.file(
                                                        controller.imageFile!,
                                                        width: 300,
                                                        height: 300,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : const Center(
                                                        child:
                                                            Icon(Icons.photo),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 21,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(21.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CashbackThemes.whiteCashback,
                                          borderRadius:
                                              BorderRadius.circular(21)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 21, top: 21),
                                            child: CashbackText.textPrimary(
                                                text: 'Conta', fontSize: 21),
                                          ),
                                          const SizedBox(
                                            height: 21,
                                          ),
                                          CardListComponent(
                                              icon: Icons.edit,
                                              text: 'Nome',
                                              subText: controller
                                                  .authController.user!.name,
                                              color:
                                                  CashbackThemes.primaryRegular,
                                              onTap: () {
                                                CashbackAlertDialog
                                                    .alertEditUserData(
                                                        controller: controller
                                                            .nameController,
                                                        labelText: 'Nome',
                                                        onTapSave: () {
                                                          controller
                                                              .editUserData(
                                                                  'Nome',
                                                                  context);
                                                        },
                                                        context: context);
                                              }),
                                          CardListComponent(
                                              icon: Icons.person,
                                              text: 'CPF',
                                              subText:
                                                  controller.authController.cpf,
                                              hasEdit: false,
                                              color:
                                                  CashbackThemes.primaryRegular,
                                              onTap: () {}),
                                          CardListComponent(
                                              icon: Icons.edit,
                                              text: 'Email',
                                              subText: controller
                                                  .authController.user!.email,
                                              color:
                                                  CashbackThemes.primaryRegular,
                                              hasEdit: false,
                                              onTap: () {
                                                // CashbackAlertDialog.alertEditUserData(
                                                //     controller: controller.emailController,
                                                //     labelText: 'Email',
                                                //      onTapSave: () {
                                                //     //  controller.editUserData('Nome');
                                                //     },
                                                //     context: context);
                                              }),
                                          CardListComponent(
                                              icon: Icons.edit,
                                              text: 'Senha',
                                              subText: '*********',
                                              color:
                                                  CashbackThemes.primaryRegular,
                                              onTap: () {
                                                Get.put(
                                                    RecoveryPasswordController());
                                                CashbackAlertDialog
                                                    .alertOutWidget(
                                                        context: context,
                                                        widget:
                                                            const RecovaryPasswordPage(
                                                          status: true,
                                                        ));
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(21.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: CashbackThemes.whiteCashback,
                                          borderRadius:
                                              BorderRadius.circular(21)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 21, top: 21),
                                            child: CashbackText.textPrimary(
                                                text: 'App', fontSize: 21),
                                          ),
                                          const SizedBox(
                                            height: 21,
                                          ),
                                          CardListComponent(
                                              icon: FontAwesomeIcons.list,
                                              text: 'Baixar extrato',
                                              color: CashbackThemes.blue,
                                              onTap: () {
                                                CashbackAlertDialog
                                                    .alertInfoWithButton(
                                                        context: context,
                                                        text:
                                                            'Funcionalidade em construção');
                                              }),
                                          CardListComponent(
                                              icon: FontAwesomeIcons.dollarSign,
                                              text: 'Convide e ganhe',
                                              color: CashbackThemes.success,
                                              onTap: () {
                                                CashbackAlertDialog
                                                    .alertInfoWithButton(
                                                        context: context,
                                                        text:
                                                            'Funcionalidade em construção');
                                              }),
                                          CardListComponent(
                                              icon: FontAwesomeIcons.whatsapp,
                                              text: 'Contato',
                                              color: CashbackThemes
                                                  .greyCashbackDarker,
                                              onTap: () async {
                                                String link =
                                                    'whatsapp-+55(41)996374777';
                                                var whatsAdroid =
                                                    'whatsapp://send?phone="${link.split('-')[1]}"&text=Olá, vim pelo Cashback Acicla';
                                                var whatsIos =
                                                    'https://wa.me/send?phone="${link.split('-')[1]}"&text=Olá, vim pelo Cashback Acicla';

                                                if (Platform.isIOS) {
                                                  if (await canLaunchUrlString(
                                                      whatsIos)) {
                                                    await launchUrlString(
                                                        whatsIos);
                                                  }
                                                } else {
                                                  if (await canLaunchUrlString(
                                                      whatsAdroid)) {
                                                    await launchUrlString(
                                                        whatsAdroid);
                                                  }
                                                }
                                              }),
                                          CardListComponent(
                                              icon: FontAwesomeIcons.book,
                                              text:
                                                  'Termos de uso\nPoliticas de privacidade',
                                              color: CashbackThemes
                                                  .greyCashbackDarker,
                                              onTap: () async {
                                                await launchUrlString(
                                                    'https://clubedecompras.app.br/politica');
                                              }),
                                          CardListComponent(
                                              icon: FontAwesomeIcons.trash,
                                              text: 'Excluir minha conta',
                                              color: CashbackThemes.error,
                                              onTap: () {
                                                CashbackAlertDialog
                                                    .alertInfoWithTwoButton(
                                                        context: context,
                                                        text:
                                                            'Deseja excluir sua conta? Todos os seus dados serão perdidos!',
                                                        onTap: () {
                                                          controller
                                                              .deleteAccount(
                                                                  context);
                                                        });
                                              }),
                                          CardListComponent(
                                              icon: Icons.close,
                                              text: 'Sair do app',
                                              color: CashbackThemes.error,
                                              onTap: () {
                                                Get.find<AuthController>()
                                                    .signOut();
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 9, bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CashbackText.textSecundary(
                                                    text: ' Versão -'),
                                                CashbackText.textPrimary(
                                                    text: '1.0.13')
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
