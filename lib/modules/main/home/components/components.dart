import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/cards/cashback_cards.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/snacks/snacks.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/main/home/controller/home_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeComponent extends StatelessWidget {
  const HomeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.refreshPage();
            },
            child: ListView(
              children: [
                Stack(
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
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // NotificaionApi.showNotification(
                                      //     title: 'Faliz Ano Novo',
                                      //     body:
                                      //         'Desejamos um feliz ano novo a todo!',
                                      //     payload: 'teste.abs');
                                      controller.setVisibilityValue();
                                      controller.authController.doubleSaldo(
                                          controller.authController.cpf);
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        controller.setVisibilityValue();
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 3),
                                      child: Icon(
                                        // ignore: deprecated_member_use
                                        FontAwesomeIcons.refresh,
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
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 140),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 700),
                          decoration: const BoxDecoration(
                              color: CashbackThemes.whiteCashback,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(33),
                                  topRight: Radius.circular(33))),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //----------------------------------------------------- MENU

                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21, top: 21),
                                    child: SizedBox(
                                      height: 90,
                                      child: controller.menu.isEmpty
                                          ? Container()
                                          : GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 100,
                                                      mainAxisExtent: 90,
                                                      crossAxisSpacing: 6,
                                                      mainAxisSpacing: 6),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controller.menu.length,
                                              itemBuilder: (context, index) {
                                                var menu =
                                                    controller.menu[index];
                                                return InkWell(
                                                  onTap: () {
                                                    CashbackAlertDialog
                                                        .alertInfoWithButton(
                                                            context: context,
                                                            text:
                                                                'Disponível no natal');
                                                    //   Modular.to.pushNamed(AppRoutes.scratchCard);
                                                  },
                                                  child: CashbackCards.menu(
                                                      text: menu['text'],
                                                      colors: menu['colors'],
                                                      icon: menu['icon']),
                                                );
                                              }),
                                    ),
                                  ),
                                ),

                                //----------------------------------------------------- parceiros

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 21, bottom: 15, right: 21, top: 21),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CashbackText.textPrimary(
                                          text: 'Parceiros', fontSize: 16),
                                      InkWell(
                                        onTap: () {
                                          Modular.to
                                              .pushNamed(AppRoutes.partners);
                                        },
                                        child: CashbackText.textPrimary(
                                          text: 'ver mais'.toUpperCase(),
                                          fontSize: 12,
                                          color: CashbackThemes.primaryRegular,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: SizedBox(
                                    height: 100,
                                    child: controller.parterns.isEmpty
                                        ? Container()
                                        : GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 100,
                                                    mainAxisExtent: 100,
                                                    crossAxisSpacing: 3,
                                                    mainAxisSpacing: 3),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller
                                                    .parterns.isEmpty
                                                ? 0
                                                : controller.parterns.length,
                                            itemBuilder: (context, index) {
                                              var patern =
                                                  controller.parterns[index];
                                              return CashbackCards
                                                  .bannersPaterns(
                                                      context: context,
                                                      parternsCashbackModel:
                                                          patern);
                                            }),
                                  ),
                                ),
                                const Divider(),

                                //----------------------------------------------------- HOW TO USE
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 21, bottom: 0, right: 21, top: 21),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CashbackText.textPrimary(
                                          text: 'Aprenda',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21, top: 9, bottom: 6, right: 21),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              CashbackAlertDialog.alertInfoHowToWin(
                                                  context: context,
                                                  text:
                                                      'Como ganhar o cashback?',
                                                  tutorial: [
                                                    {
                                                      'title':
                                                          'Nossos Parceiros',
                                                      'description':
                                                          'Ao comprar com um dos nossos parceiros, basta solicitar o recebimento do CASHBACK ACICLA'
                                                    },
                                                  ]);
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: CashbackCards.howToUse(
                                                    text:
                                                        'COMO GANHAR\nCASHBACK?',
                                                    image:
                                                        'assets/images/usar.webp',
                                                    invert: true)),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 7),
                                              child: InkWell(
                                                onTap: () {
                                                  CashbackAlertDialog
                                                      .alertInfoHowToWin(
                                                          context: context,
                                                          text:
                                                              'Como usar o cashback?',
                                                          tutorial: [
                                                        {
                                                          'title':
                                                              'Nossos Parceiros',
                                                          'description':
                                                              'Vá até um dos nossos parceiros'
                                                        },
                                                        {
                                                          'title': 'Pontos',
                                                          'description':
                                                              'Avise ao nosso parceiro que você gostaria de utilizar seus pontos'
                                                        },
                                                        {
                                                          'title': 'Abra o app',
                                                          'description':
                                                              'Acesse a área de pontos (icone de cartão), escaneie o QR code do nosso parceiro ou peça a chave'
                                                        },
                                                        {
                                                          'title': 'Depois',
                                                          'description':
                                                              'Depois é só digitar o os pontos e pronto!'
                                                        },
                                                      ]);
                                                },
                                                child: CashbackCards.howToUse(
                                                    text:
                                                        'COMO USAR\nCASHBACK?',
                                                    image:
                                                        'assets/images/comoganhar.webp'),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(),
                                //----------------------------------------------------- PATROCINADOS
                                Visibility(
                                  //visible: true,
                                  visible: controller.banners.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21,
                                        top: 21,
                                        bottom: 0,
                                        right: 21),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CashbackText.textPrimary(
                                            text: 'Anúncio', fontSize: 16),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.banners.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 21,
                                      top: 6,
                                      right: 21,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        if (controller.banners[0].link!
                                            .contains('whatsapp-')) {
                                          String link =
                                              controller.banners[0].link!;
                                          var whatsAdroid =
                                              'whatsapp://send?phone="${link.split('-')[1]}"&text=Olá, vim pelo Cashback Acicla';
                                          var whatsIos =
                                              'https://wa.me/send?phone="${link.split('-')[1]}"&text=Olá, vim pelo Cashback Acicla';

                                          if (Platform.isIOS) {
                                            if (await canLaunchUrlString(
                                                whatsIos)) {
                                              await launchUrlString(whatsIos);
                                            }
                                          } else {
                                            if (await canLaunchUrlString(
                                                whatsAdroid)) {
                                              await launchUrlString(
                                                  whatsAdroid);
                                            }
                                          }
                                        } else {
                                          if (controller
                                              .banners[0].link!.isEmpty) {
                                            CashbackSnackBar.snackbarWarning(
                                                description:
                                                    'Esse anúncio não possui link',
                                                context: context);
                                          } else {
                                            final Uri url = Uri.parse(
                                                '${controller.banners[0].link}');
                                            !await launchUrl(url);
                                          }
                                        }
                                      },
                                      child: controller.banners.isEmpty
                                          ? CashbackLoading.loading()
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  controller.banners[0].img ??
                                                      '',
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.transparent,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Column(
                                                  children: [
                                                    CashbackText.textPrimary(
                                                        text:
                                                            'Carregando anúncio'),
                                                    CashbackLoading.loading(
                                                        size: 35)
                                                  ],
                                                ),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                      child: Icon(Icons
                                                          .image_not_supported_sharp)),
                                            ),
                                    ),
                                  ),
                                ),
                                const Divider(),

                                //----------------------------------------------------- banners
                                Visibility(
                                  visible: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21,
                                        top: 31,
                                        bottom: 15,
                                        right: 21),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CashbackText.textPrimary(
                                            text: 'Promoções'),
                                        InkWell(
                                          onTap: () {
                                            Modular.to.pushNamed(
                                                AppRoutes.promotions);
                                          },
                                          child: CashbackText.textPrimary(
                                              text: 'ver mais',
                                              color: CashbackThemes
                                                  .primaryRegular),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 21),
                                    child: SizedBox(
                                      height: 180,
                                      child: controller.promotions.isEmpty
                                          ? Container()
                                          : GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 200,
                                                      mainAxisExtent: 200,
                                                      crossAxisSpacing: 9,
                                                      mainAxisSpacing: 9),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  controller.promotions.length,
                                              itemBuilder: (context, index) {
                                                var promotion = controller
                                                    .promotions[index];
                                                return CashbackCards
                                                    .bannersPromotions(
                                                        model: promotion,
                                                        context: context);
                                              }),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                //----------------------------------------------------- MURAL
                                Visibility(
                                  visible: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21,
                                        top: 31,
                                        bottom: 15,
                                        right: 21),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CashbackText.textPrimary(
                                            text: 'Mural Acicla'),
                                        InkWell(
                                          onTap: () {
                                            Modular.to
                                                .pushNamed(AppRoutes.acicla);
                                          },
                                          child: CashbackText.textPrimary(
                                              text: 'ver mais',
                                              color: CashbackThemes
                                                  .primaryRegular),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21, right: 9),
                                    child: SizedBox(
                                      height: 170,
                                      child: controller.bannersAcicla.isEmpty
                                          ? Container()
                                          : GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 170,
                                                      mainAxisExtent: 300,
                                                      crossAxisSpacing: 9,
                                                      mainAxisSpacing: 9),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: controller
                                                  .bannersAcicla.length,
                                              itemBuilder: (context, index) {
                                                var mural = controller
                                                    .bannersAcicla[index];
                                                return CashbackCards
                                                    .bannersAcicla(
                                                        muralModel: mural);
                                              }),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                //----------------------------------------------------- BANNERS
                                Visibility(
                                  //visible: true,
                                  visible: controller.banners.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21,
                                        top: 21,
                                        bottom: 0,
                                        right: 21),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CashbackText.textPrimary(
                                            text: 'Anúncio'),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  //visible: true,
                                  visible: controller.banners.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 21,
                                      top: 6,
                                      right: 21,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        if (controller.banners[1].link!
                                            .contains('whatsapp-')) {
                                          String link =
                                              controller.banners[1].link!;
                                          var whatsAdroid =
                                              'whatsapp://send?phone="${link.split('-')[1]}"&text=Olá, vim pelo Cashback Acicla';
                                          var whatsIos =
                                              'https://wa.me/send?phone="${link.split('-')[1]}"&text=Olá, vim pelo Cashback Acicla';

                                          if (Platform.isIOS) {
                                            if (await canLaunchUrlString(
                                                whatsIos)) {
                                              await launchUrlString(whatsIos);
                                            }
                                          } else {
                                            if (await canLaunchUrlString(
                                                whatsAdroid)) {
                                              await launchUrlString(
                                                  whatsAdroid);
                                            }
                                          }
                                        } else {
                                          if (controller
                                              .banners[1].link!.isEmpty) {
                                            CashbackSnackBar.snackbarWarning(
                                                description:
                                                    'Esse anúncio não possui link',
                                                context: context);
                                          } else {
                                            final Uri url = Uri.parse(
                                                '${controller.banners[1].link}');
                                            !await launchUrl(url);
                                          }
                                        }
                                      },
                                      child: controller.banners.isEmpty
                                          ? CashbackLoading.loading()
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  controller.banners[1].img ??
                                                      '',
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.transparent,
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Column(
                                                  children: [
                                                    CashbackText.textPrimary(
                                                        text:
                                                            'Carregando anúncio'),
                                                    CashbackLoading.loading(
                                                        size: 35)
                                                  ],
                                                ),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                      child: Icon(Icons
                                                          .image_not_supported_sharp)),
                                            ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 41,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
