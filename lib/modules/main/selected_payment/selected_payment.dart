import 'dart:io';

import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/main/home/controller/home_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:upgrader/upgrader.dart';

class SelectedPayment extends StatelessWidget {
  const SelectedPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
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
              body: Stack(
                children: [
                  Container(
                    height: 240,
                    decoration: const BoxDecoration(
                      color: CashbackThemes.darkCashback,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 21),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            CashbackText.textSecundary(
                                text: 'Disponível:',
                                color: CashbackThemes.whiteCashback,
                                fontSize: 14,
                                fontWeight: FontWeight.w200),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: CashbackText.textPrimary(
                                      text: 'Cb\$',
                                      fontSize: 16,
                                      color: CashbackThemes.whiteCashback),
                                ),
                                controller.valueVisibility
                                    ? CashbackText.textPrimary(
                                        text: controller
                                            .authController.saldoString,
                                        color: CashbackThemes.whiteCashback,
                                        fontSize: 33)
                                    : Container(
                                        height: 25,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: CashbackThemes
                                              .greyCashbackRegular,
                                        )),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.setVisibilityValue();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Icon(
                                      controller.valueVisibility
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      color: CashbackThemes.whiteCashback,
                                      size: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Row(
                              children: [
                                CashbackText.textSecundary(
                                    text: 'A receber:  ',
                                    color: CashbackThemes.whiteCashback,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w200),
                                CashbackText.textSecundary(
                                  text: 'Cb\$ 00,00',
                                  color: CashbackThemes.whiteCashback,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 130),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 700),
                      decoration: const BoxDecoration(
                          color: CashbackThemes.whiteCashback,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(33),
                              topRight: Radius.circular(33))),
                      child: ListView(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: CashbackThemes.whiteCashback,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(21.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 33,
                                  ),
                                  CashbackText.textPrimary(
                                      text: 'Área de pontos', fontSize: 21),
                                  CashbackText.textSecundary(
                                      text:
                                          'Aqui você pode usar seus pontos nas lojas parceiras.\n\nExistem duas formas de usar seus pontos, a primeira você pode escanear o QrCode do parceiro.\n\nA segunda você digita a chave do parceiro'),
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Modular.to.pushNamed(
                                          AppRoutes.paymentSecretKey);
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color: CashbackThemes
                                                      .primaryRegular
                                                      .withOpacity(0.2)),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.key,
                                                size: 33,
                                                color: CashbackThemes
                                                    .primaryRegular,
                                              )),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            CashbackText.textPrimary(
                                                text: 'Digitar Chave',
                                                fontSize: 18),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 33,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // CashbackAlertDialog.alertInfoWithButton(
                                      //     context: context,
                                      //     text:
                                      //         'Desculpe o transtorno, essa função está em manutenção no momento! Mas você pode usar a câmera do seu celular para escanear o QrCode');
                                      Modular.to
                                          .pushNamed(AppRoutes.paymentQrCode);
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  color: CashbackThemes
                                                      .primaryRegular
                                                      .withOpacity(0.2)),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.qr_code_2,
                                                size: 33,
                                                color: CashbackThemes
                                                    .primaryRegular,
                                              )),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            CashbackText.textPrimary(
                                                text: 'Escanear QrCode',
                                                fontSize: 18),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
