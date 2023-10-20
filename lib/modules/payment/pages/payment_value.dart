import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/forms/cashback_inputs.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/snacks/snacks.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/payment/controller/payment_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/validators.dart';

class PaymentValuePage extends StatelessWidget {
  const PaymentValuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (controller) {
          return controller.isLoadinAssociados
              ? CashbackLoading.cashbackLoadingScaffold(
                  title: 'Buscando dados...')
              : controller.parternsCashbackModel!.title.isEmpty
                  ? Scaffold(
                      appBar: CashbackAppBar.appBarBack(onTap: () {}),
                      body: Padding(
                        padding: const EdgeInsets.only(left: 21, right: 21),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CashbackText.textPrimary(
                                  text:
                                      'Ops...\n\nNão encontramos esse parceiro, verifique se digitou corretamente a chava de identificação.',
                                  textAlign: TextAlign.center),
                              const SizedBox(
                                height: 21,
                              ),
                              CashbackButtons.cashbackButton(
                                  context: context,
                                  title: 'Voltar',
                                  onTap: () {
                                    controller.secretkey.clear();
                                    Modular.to.pop();
                                  })
                            ],
                          ),
                        ),
                      ),
                    )
                  : Scaffold(
                      appBar: CashbackAppBar.appBarBack(onTap: () {}),
                      body: Form(
                        key: controller.formKeyValue,
                        child: Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CashbackText.textPrimary(
                                  text: 'Qual o valor ?',
                                  fontSize: 18),
                              const SizedBox(
                                height: 9,
                              ),
                              CashbackText.parternRinch(
                                  textPrimary: 'Seu saldo:',
                                  fontSize: 16,
                                  textSpan: [
                                    TextSpan(
                                      text:
                                          '  Cb\$${controller.userValueCashback}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: CashbackThemes.primaryRegular),
                                    )
                                  ]),
                              const SizedBox(
                                height: 15,
                              ),
                              FormInputFieldWithIcon(
                                  controller: controller.valuePrice,
                                  iconPrefix: null,
                                  textInputAction: TextInputAction.done,
                                  labelText: '',
                                  inputBorder: InputBorder.none,
                                  styleMain: const TextStyle(fontSize: 33),
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  validator: (value) {
                                    return Validator.paymentPrice(
                                        value, controller.userValueCashback);
                                  },
                                  onFieldSubmitted: (_) => node.unfocus(),
                                  onChanged: (value) {
                                    if (controller.formKeyValue.currentState!
                                        .validate()) {}
                                    controller.valuePaymentUser(value);

                                    //print(3345.99 > 2299.99);
                                    // print(int.parse(value));
                                  },
                                  onSaved: (_) => {}),
                              const SizedBox(
                                height: 33,
                              ),
                              Center(
                                  child: CashbackButtons.cashbackButton(
                                      context: context,
                                      title: 'Revisar',
                                      onTap: () {
                                        if (controller
                                            .paymentUser.value.isEmpty || double.parse(controller
                                                  .paymentUser.value
                                                  .replaceAll('.', '')
                                                  .replaceAll(',', '.')) == 0.0) {
                                          CashbackSnackBar.snackbarCustom(
                                              title: 'Atenção',
                                              description:
                                                  'Por favor, digite um valor válido',
                                              context: context,
                                              bgColor:
                                                  CashbackThemes.primaryRegular,
                                              textColor:
                                                  CashbackThemes.whiteCashback,
                                              iconType: 1);
                                        } else {
                                          if (double.parse(controller
                                                  .paymentUser.value
                                                  .replaceAll('.', '')
                                                  .replaceAll(',', '.')) >
                                              double.parse(controller
                                                  .userValueCashback
                                                  .replaceAll('.', '')
                                                  .replaceAll(',', '.'))) {

                                            if (controller
                                                .formKeyValue.currentState!
                                                .validate()) {

                                                }
                                          } else {

                                            Modular.to.pushNamed(
                                                AppRoutes.paymentResume);
                                          }
                                        }
                                        FocusScope.of(context).unfocus();
                                      })),
                            ],
                          ),
                        ),
                      ),
                    );
        });
  }
}
