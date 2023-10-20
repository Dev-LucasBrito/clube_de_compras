import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/payment/controller/payment_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentResumePage extends StatelessWidget {
  const PaymentResumePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (controller) {
          return Scaffold(
              appBar: CashbackAppBar.appBarBack(onTap: () {}),
              body: Padding(
                padding: const EdgeInsets.all(21.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          color: CashbackThemes.greyCashbackDarker, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      CachedNetworkImage(
                        imageUrl: controller.parternsCashbackModel!.img,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: CashbackThemes.whiteCashback),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover)),
                          );
                        },
                        placeholder: (context, url) => Center(
                          child: CashbackText.textPrimary(
                              text: 'Carregando imagem...'),
                        ),
                        errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.image_not_supported_sharp)),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      CashbackText.textPrimary(
                          text: 'Utilizar pontos', fontSize: 21),
                      const SizedBox(
                        height: 9,
                      ),
                      CashbackText.textSecundary(
                          textAlign: TextAlign.center,
                          text:
                              'Revise todos os dados antes de\nutilizar seus pontos.'),
                      const SizedBox(
                        height: 33,
                      ),
                      Container(
                        height: 1,
                        color: CashbackThemes.greyCashbackRegular,
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 21, right: 21, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CashbackText.textPrimary(
                                text: 'Parceiro: ',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            Flexible(
                                child: CashbackText.textPrimary(
                                    text:
                                        controller.parternsCashbackModel!.title,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    textOverflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 21, right: 21, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CashbackText.textPrimary(
                                text: 'Chave: ',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            Flexible(
                                child: CashbackText.textPrimary(
                                    text: controller.secretkey.text,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    textOverflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 21, right: 21, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CashbackText.textPrimary(
                                text: 'Valor: ',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            Flexible(
                                child: CashbackText.textPrimary(
                                    text:
                                        'Cb\$ ${controller.paymentUser.value}',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    textOverflow: TextOverflow.ellipsis)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Center(
                          child: CashbackButtons.cashbackButton(
                              context: context,
                              title: 'Utilizar pontos',
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Modular.to.navigate(AppRoutes.paymentCheckout);
                                controller.paymentFunction();
                              })),
                      const SizedBox(
                        height: 33,
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
