import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/models/mural_model.dart';
import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/models/promotions_model.dart';
import 'package:cashback/core/models/statement_model.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/core/utils/validators.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math; // import this

class CashbackCards {
  static Widget promotion(
      {required PromotionsModel promotionsModel, required context}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Card(
        elevation: 3,
        child: Stack(
          children: [
            Hero(
              tag: 'IMGPROMOTION${promotionsModel.owner}',
              child: CachedNetworkImage(
                imageUrl: promotionsModel.img!,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  );
                },
                placeholder: (context, url) => Center(
                  child: CashbackText.textPrimary(text: 'Carregando imagem...'),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.image_not_supported_sharp)),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 3,
                  ),
                  Visibility(
                    visible: false,
                    child: Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CashbackText.textPrimary(
                                text: promotionsModel.owner!,
                                color: CashbackThemes.primaryText,
                                fontSize: 15),
                            const SizedBox(
                              height: 6,
                            ),
                            CashbackText.parternRinch(
                                textPrimary: '${promotionsModel.intro}',
                                textSpan: [])
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }

  static Widget menuPromotions(
      {required PromotionsModel promotionsModel, required context}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Card(
        elevation: 3,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 3,
              ),
              Hero(
                tag: 'IMGPROMOTION${promotionsModel.owner}',
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: CashbackThemes.greyCashbackRegular,
                      borderRadius: BorderRadius.circular(9)),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CashbackText.textPrimary(
                          text: promotionsModel.owner!,
                          color: CashbackThemes.primaryText,
                          fontSize: 15),
                      const SizedBox(
                        height: 6,
                      ),
                      CashbackText.parternRinch(
                          textPrimary: '${promotionsModel.description}',
                          textSpan: [])
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }

  static parternsMore(
      {required ParternsCashbackModel partensCashbackModel, required context}) {
    ///FUTURAMENTE PODEMOS DEIXAR ISSO COMO UMA LISTA, COM LOCALIZAÇÃO E DISTANCIA
    return InkWell(
      onTap: () {
        if (partensCashbackModel.status == '2') {
          CashbackAlertDialog.alertInfoWithButton(
              context: context,
              text:
                  'Em breve a ${partensCashbackModel.title} também fará parte do Clude De Compras Acicla e usará CaschBack. Aguarde!');
        } else {
          Modular.to.pushNamed(
              '/associados/${Validator().convertSlug(partensCashbackModel.categorySlug!.isEmpty ? "comercio" : partensCashbackModel.categorySlug)}/${Validator().convertSlug(partensCashbackModel.title)}-${partensCashbackModel.id}',
              arguments: {
                'id': partensCashbackModel.id,
              });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 3, right: 9, left: 9),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: partensCashbackModel.img,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        );
                      },
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CashbackLoading.loading(size: 30)),
                      ),
                      errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.image_not_supported_sharp)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 9,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CashbackText.textPrimary(
                            text: partensCashbackModel.title.length > 20
                                ? '${partensCashbackModel.title.substring(0, 20)}...'
                                : partensCashbackModel.title,
                            color: CashbackThemes.primaryText,
                            textAlign: TextAlign.center,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: 16),
                        const SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () {
                            CashbackAlertDialog.alertInfoWithButton(
                                context: context,
                                text: 'Esse parceiro é confiável');
                          },
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: Stack(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.certificate,
                                  color: CashbackThemes.primaryRegular,
                                  size: 15,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check,
                                    size: 12,
                                    color: CashbackThemes.whiteCashback,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Visibility(
                            visible: false,
                            child: Icon(Icons.favorite_border_outlined)),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Visibility(
                      visible: partensCashbackModel.status == '1',
                      child: CashbackText.parternRinch(textSpan: [
                        TextSpan(
                            text:
                                '${partensCashbackModel.cashback.toString()}%',
                            style: const TextStyle(
                                color: CashbackThemes.primaryRegular,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                        const TextSpan(
                            text: ' de cashback',
                            style: TextStyle(
                                color: CashbackThemes.secundaryText,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      ]),
                    ),
                    Visibility(
                      visible: partensCashbackModel.status == '2',
                      child: CashbackText.textPrimary(
                        text: 'EM BREVE',
                        color: const Color.fromARGB(255, 255, 97, 5),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Visibility(
                      visible: partensCashbackModel.status == '1',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 255, 186, 59),
                            size: 18,
                          ),
                          CashbackText.textSecundary(text: ' 5.0')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
            const SizedBox(
              height: 9,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  static bannersPromotions({
    required PromotionsModel model,
    required context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          CashbackAlertDialog.detailAlertPromotions(
              context: context, promotionsModel: model);
        },
        child: CachedNetworkImage(
          imageUrl: model.img!,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                color: CashbackThemes.greyCashbackRegular,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 9,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Visibility(
                    visible: model.intro!.isNotEmpty,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: CashbackThemes.darkCashback.withOpacity(0.5),
                          ),
                          height: 55,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: CashbackText.parternRinch(
                          textPrimary: '${model.intro}',
                          color: CashbackThemes.whiteCashback,
                          fontSize: 13,
                          textSpan: []),
                    ),
                  ),
                ],
              ),
            );
          },
          placeholder: (context, url) => Center(
            child: Column(
              children: [
                CashbackText.textPrimary(text: 'Carregando promoções'),
                CashbackLoading.loading(size: 35)
              ],
            ),
          ),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.image_not_supported_sharp)),
        ),
      ),
    );
  }

  static bannersAcicla({required MuralModel muralModel}) {
    return InkWell(
      onTap: () async {
        //print('to aqui');
        //print(muralModel.link);
        String url2 = muralModel.link.contains('https://')
            ? muralModel.link
            : 'https://$muralModel.link';
            
        final Uri url = Uri.parse(url2);

        !await launchUrl(url);
      },
      child: CachedNetworkImage(
        imageUrl: muralModel.imagem,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
        placeholder: (context, url) => Center(
          child: CashbackText.textPrimary(text: 'Carregando imagem...'),
        ),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.image_not_supported_sharp)),
      ),
    );
  }

  static cardStatement({
    required StatementModel statementModel,
  }) {
    var valor = MoneyMaskedTextController();
    valor.updateValue(statementModel.cashback!);

    var saldo = MoneyMaskedTextController();
    saldo.updateValue(statementModel.cashbackUser!);

    return Padding(
      padding: const EdgeInsets.only(left: 9, bottom: 9, right: 9),
      child: InkWell(
        onTap: () {},
        child: Align(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                Container(
                  height: 51,
                  width: 51,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: CashbackThemes.primaryRegular.withOpacity(0.3)),
                  child: const Icon(
                    FontAwesomeIcons.dollarSign,
                    color: CashbackThemes.primaryRegular,
                    size: 21,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CashbackText.textPrimary(
                        text: statementModel.storeName ??
                            '${statementModel.storeName}'),
                    CashbackText.textSecundary(
                        text: statementModel.operacao == '+'
                            ? 'Recebido'
                            : 'Pago'),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            child: statementModel.operacao == '-'
                                ? const Icon(
                                    Icons.arrow_upward_outlined,
                                    color: CashbackThemes.errorRegular,
                                    size: 15,
                                  )
                                : const Icon(
                                    Icons.arrow_downward_outlined,
                                    color: CashbackThemes.successRegular,
                                    size: 15,
                                  )),
                        Container(
                          child: CashbackText.textPrimary(
                              text: 'Cb\$ ${valor.text}',
                              color: statementModel.operacao == '+'
                                  ? CashbackThemes.successRegular
                                  : CashbackThemes.errorRegular),
                        ),
                      ],
                    ),
                    Container(
                      child: CashbackText.textSecundary(
                        text: 'Cb\$ ${saldo.text}',
                        color: CashbackThemes.greyCashbackDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 21,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static cardStatement2({
    required StatementModel statementModel,
  }) {
    var valor = MoneyMaskedTextController();
    valor.updateValue(statementModel.cashback!);

    var saldo = MoneyMaskedTextController();
    saldo.updateValue(statementModel.cashbackUser!);
    return Padding(
      padding: const EdgeInsets.only(left: 9, bottom: 9, right: 9, top: 9),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: CashbackThemes.darkCashback,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
                child: CashbackText.textPrimary(
                    color: CashbackThemes.whiteCashback,
                    text: statementModel.date!.month.toString().length > 1
                        ? '${statementModel.date!.day}/${statementModel.date!.month}/${statementModel.date!.year}'
                        : '${statementModel.date!.day}/0${statementModel.date!.month}/${statementModel.date!.year}'),
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(9),
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                color: CashbackThemes.whiteCashback,
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 21,
                  ),
                  Container(
                    height: 51,
                    width: 51,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: CashbackThemes.primaryRegular.withOpacity(0.3)),
                    child: const Icon(
                      FontAwesomeIcons.dollarSign,
                      color: CashbackThemes.primaryRegular,
                      size: 21,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CashbackText.textPrimary(
                          text: statementModel.storeName ?? ''),
                      CashbackText.textSecundary(
                          text: statementModel.operacao == '+'
                              ? 'Recebido'
                              : 'Pago'),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              child: statementModel.operacao == '-'
                                  ? const Icon(
                                      Icons.arrow_upward_outlined,
                                      color: CashbackThemes.errorRegular,
                                      size: 15,
                                    )
                                  : const Icon(
                                      Icons.arrow_downward_outlined,
                                      color: CashbackThemes.successRegular,
                                      size: 15,
                                    )),
                          Container(
                            child: CashbackText.textPrimary(
                                text: 'Cb\$ ${valor.text}',
                                color: statementModel.operacao == '+'
                                    ? CashbackThemes.successRegular
                                    : CashbackThemes.errorRegular),
                          ),
                        ],
                      ),
                      Container(
                        child: CashbackText.textSecundary(
                          text: 'Cb\$ ${saldo.text}',
                          color: CashbackThemes.greyCashbackDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 21,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget bannersPaterns(
      {required context,
      required ParternsCashbackModel parternsCashbackModel}) {
    return InkWell(
      onTap: () {
        if (parternsCashbackModel.status == '2') {
          CashbackAlertDialog.alertInfoWithButton(
              context: context,
              text:
                  'Em breve a ${parternsCashbackModel.title} também fará parte do Clude De Compras Acicla e usará CaschBack. Aguarde!');
        } else {
          Modular.to.pushNamed(
              '/associados/${Validator().convertSlug(parternsCashbackModel.categorySlug!.isEmpty ? "comercio" : parternsCashbackModel.categorySlug)}/${Validator().convertSlug(parternsCashbackModel.title)}-${parternsCashbackModel.id}',
              arguments: {
                'id': parternsCashbackModel.id,
              });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              child: Container(
                height: 68,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                ),
                child: ColorFiltered(
                  colorFilter: parternsCashbackModel.status != '2'
                      ? const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        )
                      : const ColorFilter.matrix(
                          <double>[
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ],
                        ),
                  child: CachedNetworkImage(
                    imageUrl: parternsCashbackModel.img,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 68.0,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      );
                    },
                    placeholder: (context, url) => Center(
                      child: CashbackLoading.loading(size: 15),
                    ),
                    errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.image_not_supported_sharp)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            parternsCashbackModel.status == '1'
                ? CashbackText.textPrimary(
                    text: parternsCashbackModel.title,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    textOverflow: TextOverflow.ellipsis)
                : CashbackText.textPrimary(
                    text: 'EM BREVE',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: CashbackThemes.primaryRegular,
                    textOverflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }

  static Widget menu({
    required text,
    required List<Color> colors,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          // color: colors[0],
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: colors),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: CashbackThemes.whiteCashback,
              size: 24,
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
                alignment: Alignment.center,
                child: CashbackText.textPrimary(
                    text: text,
                    color: CashbackThemes.whiteCashback,
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }

  static parterns() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          color: CashbackThemes.greyCashbackRegular,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  static Widget howToUse(
      {required String text, required String image, invert = false}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            color: CashbackThemes.darkCashback,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15)),
        height: 90,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CashbackText.textPrimary(
                    text: text,
                    fontSize: 16,
                    color: CashbackThemes.whiteCashback),
              ),
            ),
            invert == true
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 62,
                      width: 62,
                      child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Image.asset(image)),
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 62,
                      width: 62,
                      child: Image.asset(image),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
