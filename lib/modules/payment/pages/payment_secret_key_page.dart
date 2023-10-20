import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/buttons/cashback_buttons.dart';
import 'package:cashback/core/components/forms/cashback_inputs.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/modules/payment/controller/payment_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSecretKeyPage extends StatelessWidget {
  const PaymentSecretKeyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode node = FocusScope.of(context);
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (controller) {
          return Scaffold(
            appBar: CashbackAppBar.appBarBack(onTap: () {}),
            body: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(21.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CashbackText.textPrimary(
                        text:
                            'Solicite ao estabelecimento\na chave de identificação.',
                        fontSize: 18),
                    const SizedBox(
                      height: 9,
                    ),
                    FormInputFieldWithIcon(
                        controller: controller.secretkey,
                        iconPrefix: Icons.person,
                        sizeIcon: 28,
                        paddingIcon: 12,
                        textInputAction: TextInputAction.done,
                        labelText: '',
                        inputBorder: InputBorder.none,
                        styleMain: const TextStyle(fontSize: 21),
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        validator: (value) {
                          return value!.length == 18 ? '' : 'Inválido';
                        },
                        onFieldSubmitted: (_) => node.nextFocus(),
                        onChanged: (value) {
                          controller.validateValue(value);

                          // print(3345.99 > 2299.99);
                          // print(int.parse(value));
                        },
                        onSaved: (_) => {}),
                    const SizedBox(
                      height: 21,
                    ),
                    //  Obx(
                    //    () => Visibility(
                    //      visible: controller.cnpj
                    //          .contains(controller.cnpjWritten.value),
                    //      child: Padding(
                    //        padding: const EdgeInsets.only(left: 21),
                    //        child: Row(
                    //          mainAxisAlignment: MainAxisAlignment.start,
                    //          children: [
                    //            CashbackText.textSecundary(text: 'Loja:  '),
                    //            CashbackText.textPrimary(
                    //                text: controller.owner.value),
                    //          ],
                    //        ),
                    //      ),
                    //    ),
                    //  ),
                    const SizedBox(
                      height: 33,
                    ),
                    Center(
                        child: CashbackButtons.cashbackButton(
                            context: context,
                            title: 'Continuar',
                            onTap: () {
                              controller.getAssociado();
                              FocusScope.of(context).unfocus();

                              Modular.to.pushNamed(AppRoutes.paymentValue);
                            }))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
