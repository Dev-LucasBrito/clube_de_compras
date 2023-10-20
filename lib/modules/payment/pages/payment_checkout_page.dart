import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/hero/cashback_hero.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/main/home/controller/home_controller.dart';
import 'package:cashback/modules/payment/controller/payment_controller.dart';
import 'package:cashback/routes/app_routes.dart';

import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

enum StatusPayment {
  loading,
  approved,
  reject,
  ressume,
}

class PaymentCheckout extends StatelessWidget {
  const PaymentCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (controller) {
          return controller.statusPayment == StatusPayment.loading
              ? CircularRevealAnimation(
                  animation: controller.animation!,
                  child: Scaffold(
                    backgroundColor: Colors.blue,
                    body: Center(
                        child: Stack(
                      children: const [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(21.0),
                            child: Icon(
                              Icons.lock,
                              size: 120,
                            ),
                          ),
                        ),
                        Align(
                          child: SizedBox(
                              height: 160,
                              width: 160,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 5,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 250),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Utilizando pontos...',
                              style: TextStyle(fontSize: 21),
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                )
              : controller.statusPayment == StatusPayment.approved
                  ? CircularRevealAnimation(
                      animation: controller.animation!,
                      child: Scaffold(
                        backgroundColor: Colors.green,
                        body: Center(
                            child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(21.0),
                                child: Icon(
                                  Icons.check,
                                  size: 120,
                                  color: CashbackThemes.whiteCashback,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 250),
                              child: Align(
                                alignment: Alignment.center,
                                child: CashbackText.textPrimary(
                                    text: 'Sucesso!',
                                    textAlign: TextAlign.center,
                                    color: CashbackThemes.whiteCashback,
                                    fontSize: 21),
                              ),
                            )
                          ],
                        )),
                      ))
                  : controller.statusPayment == StatusPayment.reject
                      ? CircularRevealAnimation(
                          animation: controller.animation!,
                          child: Scaffold(
                            backgroundColor: Colors.redAccent,
                            body: Center(
                                child: Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 60, right: 15),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          Modular.to.pop();
                                          Modular.to.pop();
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 27,
                                        ),
                                      )),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.xmark,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Recusado',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Center(
                                      child: SizedBox(
                                        width: 300,
                                        child: Text(
                                          'Infelizmente ocorreu um erro '
                                          ', tente novamente. ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 63,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.paymentFunction();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color: const Color.fromARGB(
                                                255, 20, 20, 20)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            'Tentar novamente',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 21,
                                    ),
                                    CashbackText.textPrimary(text: 'OU'),
                                    const SizedBox(
                                      height: 21,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.find<AuthController>().onInit();
                                        Get.find<HomeController>().onInit();

                                        Modular.to.navigate(AppRoutes.splash);
                                        Future.delayed(
                                            const Duration(milliseconds: 1),
                                            () {
                                          Get.delete<PaymentController>();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color: const Color.fromARGB(
                                                255, 20, 20, 20)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            'Voltar ao início',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                  ],
                                )
                              ],
                            )),
                          ),
                        )
                      : controller.statusPayment == StatusPayment.ressume
                          ? CircularRevealAnimation(
                              animation: controller.animation!,
                              child: Scaffold(
                                backgroundColor: CashbackThemes.darkCashback,
                                body: Center(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Center(
                                        child: CashbackText.textPrimary(
                                            text: 'COMPROVANTE',
                                            fontSize: 24,
                                            color:
                                                CashbackThemes.whiteCashback),
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 21, right: 21),
                                            child: Card(
                                              color:
                                                  CashbackThemes.whiteCashback,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(21.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 21,
                                                    ),
                                                    CashbackHero
                                                        .heroContainer(),
                                                    const SizedBox(
                                                      height: 9,
                                                    ),
                                                    CashbackText.textPrimary(
                                                        text:
                                                            ' Clube de compras Acicla'),
                                                    CashbackText.textSecundary(
                                                        text:
                                                            ' ${controller.statementModel!.id!}'),
                                                    const SizedBox(
                                                      height: 33,
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      color: CashbackThemes
                                                          .greyCashbackDarest,
                                                    ),
                                                    const SizedBox(
                                                      height: 33,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Valor',
                                                          style: TextStyle(
                                                              color: CashbackThemes
                                                                  .greyCashbackDarest
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          'Cb\$ ${controller.valuePrice.text}',
                                                          style: const TextStyle(
                                                              color: CashbackThemes
                                                                  .primaryRegular,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 21,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Identificação',
                                                          style: TextStyle(
                                                              color: CashbackThemes
                                                                  .greyCashbackDarest
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          controller
                                                              .statementModel!
                                                              .storeName!,
                                                          style: const TextStyle(
                                                              color: CashbackThemes
                                                                  .primaryRegular,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 21,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Data da\n utilização',
                                                          style: TextStyle(
                                                              color: CashbackThemes
                                                                  .greyCashbackDarest
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        CashbackText.parternRinch(
                                                            textAlign:
                                                                TextAlign.end,
                                                            color: CashbackThemes
                                                                .primaryRegular,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            textPrimary: controller
                                                                        .datePayment
                                                                        .month
                                                                        .toString()
                                                                        .length ==
                                                                    2
                                                                ? '${controller.statementModel!.date!.day}/${controller.statementModel!.date!.month}/${controller.statementModel!.date!.year} '
                                                                : '${controller.statementModel!.date!.day}/0${controller.statementModel!.date!.month}/${controller.statementModel!.date!.year}',
                                                            textSpan: [
                                                              TextSpan(
                                                                  style: const TextStyle(
                                                                      color: CashbackThemes
                                                                          .primaryRegular,
                                                                      fontSize:
                                                                          13),
                                                                  text:
                                                                      '\n ${controller.statementModel!.date!.hour}h:${controller.statementModel!.date!.minute}m')
                                                            ]),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 21,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Identificação',
                                                          style: TextStyle(
                                                              color: CashbackThemes
                                                                  .greyCashbackDarest
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          controller
                                                              .statementModel!
                                                              .id!
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: CashbackThemes
                                                                  .primaryRegular,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 21,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Center(
                                        child:
                                            CashbackButtons
                                                .cashbackButtonWithLoading(
                                                    isLoading: controller
                                                        .isLoadingScaan,
                                                    context: context,
                                                    title: 'COMPARTILHAR',
                                                    onTap: () async {
                                                      var image =
                                                          await controller
                                                              .screenshot
                                                              .captureFromWidget(
                                                                  Screenshot(
                                                        controller: controller
                                                            .screenshot,
                                                        child: Center(
                                                          child: SizedBox(
                                                            height: 500,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 21,
                                                                      right:
                                                                          21),
                                                              child: Card(
                                                                color: CashbackThemes
                                                                    .whiteCashback,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          21.0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            21,
                                                                      ),
                                                                      CashbackHero
                                                                          .heroContainer(),
                                                                      const SizedBox(
                                                                        height:
                                                                            9,
                                                                      ),
                                                                      CashbackText.textPrimary(
                                                                          text:
                                                                              ' Clube de compras Acicla'),
                                                                      CashbackText.textSecundary(
                                                                          text:
                                                                              ' ${controller.statementModel!.id!}'),
                                                                      const SizedBox(
                                                                        height:
                                                                            33,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            1,
                                                                        color: CashbackThemes
                                                                            .greyCashbackDarest,
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            33,
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'Valor',
                                                                            style:
                                                                                TextStyle(color: CashbackThemes.greyCashbackDarest.withOpacity(0.7), fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Text(
                                                                            'Cb\$ ${controller.valuePrice.text}',
                                                                            style: const TextStyle(
                                                                                color: CashbackThemes.primaryRegular,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            21,
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'Identificação',
                                                                            style:
                                                                                TextStyle(color: CashbackThemes.greyCashbackDarest.withOpacity(0.7), fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Text(
                                                                            controller.statementModel!.storeName!,
                                                                            style: const TextStyle(
                                                                                color: CashbackThemes.primaryRegular,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            21,
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'Data da\nutilização',
                                                                            style:
                                                                                TextStyle(color: CashbackThemes.greyCashbackDarest.withOpacity(0.7), fontWeight: FontWeight.w500),
                                                                          ),
                                                                          CashbackText.parternRinch(
                                                                              textAlign: TextAlign.end,
                                                                              color: CashbackThemes.primaryRegular,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500,
                                                                              textPrimary: controller.datePayment.month.toString().length == 2 ? '${controller.statementModel!.date!.day}/${controller.statementModel!.date!.month}/${controller.statementModel!.date!.year} ' : '${controller.statementModel!.date!.day}/0${controller.statementModel!.date!.month}/${controller.statementModel!.date!.year}',
                                                                              textSpan: [
                                                                                TextSpan(style: const TextStyle(color: CashbackThemes.primaryRegular, fontSize: 13), text: '\n ${controller.statementModel!.date!.hour}h:${controller.statementModel!.date!.minute}m')
                                                                              ]),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            21,
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'Identificação',
                                                                            style:
                                                                                TextStyle(color: CashbackThemes.greyCashbackDarest.withOpacity(0.7), fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Text(
                                                                            controller.statementModel!.id!.toString(),
                                                                            style: const TextStyle(
                                                                                color: CashbackThemes.primaryRegular,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            21,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                      controller
                                                          .saveAndShared(image);
                                                      // controller.shareScreenshot(context);
                                                    }),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: CashbackButtons
                                            .cashbackButtonWithLoading(
                                                isLoading: false,
                                                context: context,
                                                title: 'FECHAR',
                                                onTap: () async {
                                                  Get.find<AuthController>()
                                                      .onInit();
                                                  Get.find<HomeController>()
                                                      .onInit();

                                                  Modular.to.navigate(
                                                      AppRoutes.splash);
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 1), () {
                                                    Get.find<HomeController>()
                                                        .onInit();
                                                    Get.delete<
                                                        PaymentController>();
                                                  });
                                                }),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          : Container();
        });
  }
}
