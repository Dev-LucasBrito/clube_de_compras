import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/forms/cashback_inputs.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/models/parterns_cashback_model.dart';
import 'package:cashback/core/models/promotions_model.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/core/utils/validators.dart';
import 'package:cashback/modules/announcement/parterns_details/components/how_to_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CashbackAlertDialog {
  static detailAlertPromotions(
      {required context, required PromotionsModel promotionsModel}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: SizedBox(
              height: MediaQuery.of(context).size.height < 700
                  ? MediaQuery.of(context).size.height / 1.5
                  : MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () => Modular.to.pop(),
                              child: const Icon(Icons.close)),
                        ),
                      ),
                      Hero(
                        tag: 'IMGPROMOTION${promotionsModel.owner}',
                        child: CachedNetworkImage(
                          imageUrl: promotionsModel.img!,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            );
                          },
                          placeholder: (context, url) => Center(
                            child: CashbackText.textPrimary(
                                text: 'Carregando imagem...'),
                          ),
                          errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.image_not_supported_sharp)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 21, right: 21),
                        child: CashbackText.textPrimary(
                            text: promotionsModel.owner!,
                            color: CashbackThemes.primaryText,
                            fontSize: 15,
                            textOverflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView(
                          children: [
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  child: CashbackText.parternRinch(
                                      textPrimary:
                                          '${promotionsModel.description}',
                                      textAlign: TextAlign.center,
                                      fontSize: 14,
                                      textSpan: []),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: promotionsModel.link!.isNotEmpty,
                        child: CashbackButtons.cashbackButton(
                            context: context,
                            title: 'Acessar Link',
                            onTap: () async {
                              String googleUrl = '${promotionsModel.link}';
                              String url = googleUrl.contains('https://')
                                  ? googleUrl
                                  : 'https://$googleUrl';
                              if (await canLaunchUrlString(url)) {
                                await launchUrlString(url);
                              } else {
                                throw 'Could not open the map.';
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showLoading({required context, required title}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return CashbackLoading.cashbackLoadingScaffold(title: title);
      },
    );
  }

  static alertPassScratch({required context}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CashbackText.textPrimary(
                            text: 'CÓDIGO DA RASPADINHA'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CashbackText.textSecundary(
                            textAlign: TextAlign.center,
                            text: 'Nas compras a cima de R\$200,00 nas lojas '
                                'parceiras, você recebe um código para participar '
                                'das raspadinhas premiadas.'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
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
                              if (v!.length < 3) {
                                return "Não validado";
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
                              inactiveColor: CashbackThemes.greyCashbackRegular,
                              disabledColor: CashbackThemes.greyCashbackRegular,
                              activeColor: CashbackThemes.primaryRegular,
                              selectedColor: CashbackThemes.primaryRegular,
                              selectedFillColor: CashbackThemes.primaryRegular,
                              inactiveFillColor:
                                  CashbackThemes.greyCashbackRegular,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            //  errorAnimationController: errorController,
                            //controller: textEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              Modular.to.pop();
                              // debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              // debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.close(2);
                                },
                                child: CashbackText.textSecundary(
                                    text: 'CANCELAR')),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: CashbackText.textPrimary(
                                    color: CashbackThemes.primaryRegular,
                                    text: 'VALIDAR')),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static alertOutWidget({required context, required Widget widget}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 600, maxWidth: 350),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: widget,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static alertEditUserData({
    required context,
    required TextEditingController controller,
    required String labelText,
    required VoidCallback onTapSave,
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 21, bottom: 21),
                      child: CashbackText.textPrimary(
                          text: 'Editar dado', fontSize: 21),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormInputFieldWithIcon(
                          controller: controller,
                          iconPrefix: Icons.person,
                          textInputAction: TextInputAction.next,
                          labelText: labelText,
                          inputBorder: InputBorder.none,
                          autofocus: false,
                          validator: (value) {
                            if (labelText == 'Email') {
                              return Validator.cpf(value);
                            } else {
                              return Validator.cpf(value);
                            }
                          },
                          // onFieldSubmitted: (_) => node.nextFocus(),
                          onChanged: (_) {},
                          onSaved: (_) {}),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Modular.to.pop();
                            },
                            child: CashbackText.textSecundary(
                                text: 'Cancelar',
                                fontSize: 16,
                                color: CashbackThemes.darkCashback),
                          ),
                          InkWell(
                            onTap: onTapSave,
                            child: CashbackText.textPrimary(
                                text: 'Salvar',
                                fontSize: 18,
                                color: CashbackThemes.primaryRegular),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }

  static alertInfoWithButton({
    required context,
    required String text,
    VoidCallback? onTap,
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: SizedBox(
              height: 220,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 21, bottom: 21),
                      child: CashbackText.textPrimary(
                          text: 'Atenção', fontSize: 21),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21, right: 21),
                      child: CashbackText.textSecundary(text: text),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CashbackButtons.cashbackButton(
                            context: context,
                            title: 'Entendi',
                            onTap: onTap ??
                                () {
                                  Modular.to.pop();
                                }),
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }

  static alertInfoWithTwoButton(
      {required context, required String text, required onTap}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: SizedBox(
              height: 220,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 21, bottom: 21),
                      child: CashbackText.textPrimary(
                          text: 'Atenção', fontSize: 21),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21, right: 21),
                      child: CashbackText.textSecundary(text: text),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Modular.to.pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 21, right: 21),
                            child: CashbackText.textSecundary(text: 'CANCELAR'),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 90,
                              child: CashbackButtons.cashbackButton(
                                  context: context,
                                  title: 'Excluir',
                                  onTap: onTap),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
              ),
            ),
          ),
        );
      },
    );
  }

  static alertInfoPatterns(
      {required context,
      required ParternsCashbackModel parternsCashbackModel}) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return SafeArea(
          child: Align(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () => Modular.to.pop(),
                              child: const Icon(Icons.close)),
                        ),
                      ),
                      Hero(
                        tag: 'IMGPROMOTION${parternsCashbackModel.title}',
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: CashbackThemes.greyCashbackRegular,
                              borderRadius: BorderRadius.circular(9)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CashbackText.textPrimary(
                          text: parternsCashbackModel.title,
                          color: CashbackThemes.primaryText,
                          fontSize: 15),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                              child: CashbackText.textPrimary(text: '')),
                        ),
                      ),
                      const Spacer(),
                      CashbackButtons.cashbackButton(
                          context: context,
                          title: 'VER LOCALIZAÇÃO',
                          onTap: () async {
                            String googleUrl =
                                'https://www.google.com/maps/search/${parternsCashbackModel.address!.replaceAll(',', '').replaceAll(' ', '%20')}';
                            if (await canLaunchUrlString(googleUrl)) {
                              await launchUrlString(googleUrl);
                            } else {
                              throw 'Could not open the map.';
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static alertInfoHowToWin({
    required BuildContext context,
    required String text,
    required List<Map> tutorial,
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, _, __) {
        return Center(
          child: SizedBox(
            height: 500,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Modular.to.pop();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: Colors.white),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9, right: 9),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 21,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 21, right: 21, top: 15),
                              child: CashbackText.textPrimary(
                                  text: text, fontSize: 21),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 21,
                            ),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                  itemCount: tutorial.length,
                                  itemBuilder: (context, index) {
                                    var a = tutorial[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 21),
                                      child: HowToUse(
                                          textNumber: '0${index + 1}.',
                                          title: a['title'],
                                          description: a['description']),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
