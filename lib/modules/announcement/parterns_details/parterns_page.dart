import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/announcement/parterns_details/controller/parterns_detail_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'components/how_to_user.dart';

class ParternsDetailPage extends StatelessWidget {
  const ParternsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParternsDetailController>(
        init: ParternsDetailController(),
        builder: (controller) {
          return controller.isLoading
              ? CashbackLoading.cashbackLoadingScaffold(title: 'Carregando...')
              : DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: CashbackAppBar.appBarBack(
                        elevation: 2,
                        onTap: () {
                          Modular.to.navigate(AppRoutes.home);
                        },
                        color: CashbackThemes.whiteCashback,
                        colorIcons: CashbackThemes.darkCashback),
                    body: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.parterns!.img,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                                placeholder: (context, url) => Center(
                                  child: CashbackText.textPrimary(
                                      text: 'Carregando imagem...'),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                        child: Icon(
                                            Icons.image_not_supported_sharp)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CashbackText.textPrimary(
                                      text: controller.parterns!.title,
                                      fontSize: 18,
                                      color: CashbackThemes.darkCashback,
                                      textAlign: TextAlign.center,
                                      textOverflow: TextOverflow.ellipsis),
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      CashbackAlertDialog.alertInfoWithButton(
                                          context: context,
                                          text: 'Esse parceiro é confiável');
                                    },
                                    child: SizedBox(
                                      height: 21,
                                      width: 21,
                                      child: Stack(
                                        children: const [
                                          Icon(
                                            FontAwesomeIcons.certificate,
                                            color:
                                                CashbackThemes.primaryRegular,
                                            size: 21,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.check,
                                              size: 16,
                                              color:
                                                  CashbackThemes.whiteCashback,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // Html(
                              //   data: """<p>Servi&ccedil;os</p>""",
                              //   customRender: {

                              //   },
                              //   tagsList: Html.tags..add('tex'),
                              // ),
                              const SizedBox(
                                height: 15,
                              ),
                              CashbackText.textPrimary(
                                  text: controller.parterns!.cashback
                                          .toString()
                                          .contains('%')
                                      ? '${controller.parterns!.cashback} de cashback'
                                      : '${controller.parterns!.cashback}% de cashback',
                                  color: CashbackThemes.greyCashbackDarker,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 9,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 21, right: 21, top: 9, bottom: 9),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          String googleUrl =
                                              '${controller.parterns!.link}';
                                          print(googleUrl);
                                          String url =
                                              googleUrl.contains('https://')
                                                  ? googleUrl
                                                  : 'https://$googleUrl';
                                          await launchUrl(Uri.parse(url));
                                        },
                                        child: const SizedBox(
                                          child:
                                              Icon(FontAwesomeIcons.instagram),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 21,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final Uri emailLaunchUri = Uri(
                                            scheme: 'mailto',
                                            path:
                                                '${controller.parterns!.email}',
                                          );

                                          launchUrl(emailLaunchUri);
                                        },
                                        child: const SizedBox(
                                          child:
                                              Icon(FontAwesomeIcons.envelope),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 21,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          controller.openWhatsApp(context);
                                        },
                                        child: const SizedBox(
                                          child:
                                              Icon(FontAwesomeIcons.whatsapp),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 21,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String googleUrl =
                                              'https://www.google.com/maps/search/${controller.parterns!.address!.replaceAll(',', '').replaceAll(' ', '%20')}';
                                          if (await canLaunchUrlString(
                                              googleUrl)) {
                                            await launchUrlString(googleUrl);
                                          } else {
                                            throw 'Could not open the map.';
                                          }
                                        },
                                        child: const SizedBox(
                                          child: Icon(
                                              FontAwesomeIcons.locationDot),
                                        ),
                                      ),
                                    ]),
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 21, right: 21),
                                child: CashbackText.textSecundary(
                                    text: controller.parterns!.description!,
                                    textAlign: TextAlign.center),
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  Modular.to.pushNamed(
                                      '/pagamento/realizar?destino=${controller.parterns!.documento!.replaceAll("-", "").replaceAll(".", "")}&valor=00.00');
                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    gradient: const LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          CashbackThemes.primaryLightest,
                                          CashbackThemes.primaryLight,
                                          CashbackThemes.primaryRegular,
                                          Colors.pink,
                                        ]),
                                  ),
                                  child: Center(
                                      child: CashbackText.textPrimary(
                                          text: 'Utilizar pontos aqui',
                                          color: CashbackThemes.whiteCashback)),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 3,
                              ),
                              Visibility(
                                visible: false,
                                child: TabBar(
                                  indicatorColor: CashbackThemes.primaryRegular,
                                  onTap: (i) {},
                                  tabs: [
                                    Tab(
                                      child: CashbackText.textPrimary(
                                          text: 'PROMOÇÕES',
                                          color: CashbackThemes.darkCashback),
                                    ),
                                    Tab(
                                      child: CashbackText.textPrimary(
                                          text: 'PRODUTOS',
                                          color: CashbackThemes.darkCashback),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 9, right: 9),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 33,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 21, right: 21, top: 15),
                                        child: CashbackText.textPrimary(
                                            text:
                                                'Já sabe como ganhar cashback ?',
                                            fontSize: 21),
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Container(
                                        height: 1,
                                        color:
                                            CashbackThemes.greyCashbackRegular,
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      const HowToUse(
                                          textNumber: '01.',
                                          title: 'Encontre Parceiros',
                                          description:
                                              'Veja nossos parceiros, são neles que você irá ganhar seu cashback'),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Container(
                                        height: 1,
                                        color:
                                            CashbackThemes.greyCashbackRegular,
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      const HowToUse(
                                          textNumber: '02.',
                                          title: 'Informe o Parceiro',
                                          description:
                                              'Ao realizar sua compra em um parceiro, informe seu cpf para que possa receber seu cashback.'),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                      Container(
                                        height: 1,
                                        color:
                                            CashbackThemes.greyCashbackRegular,
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      const SizedBox(
                                        height: 21,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // ...controller.page == 0
                              //     ? CashbackListWidget.listOfRowsList(items: [
                              //         {'teste': 'teste'},
                              //         {'teste': 'teste'},
                              //         {'teste': 'teste'},
                              //       ])
                              //     : [],
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
        });
  }
}
