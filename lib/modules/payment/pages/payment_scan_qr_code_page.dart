import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/payment/components/qrcode_overlay.dart';
import 'package:cashback/modules/payment/controller/payment_controller.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PaymentScanQrCodePage extends StatelessWidget {
  const PaymentScanQrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (controller) {
          var scanArea = 300.0;
          //  controller.controller!.resumeCamera();
          return controller.isLoadingScaan == true
              ? CashbackLoading.cashbackLoadingScaffold(title: 'validando')
              : Scaffold(
                  body: Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                              flex: 5,
                              child: MobileScanner(
                                allowDuplicates: false,
                                onDetect: (barcode, args) {
                                  if (barcode.rawValue == null) {
                                  } else if (barcode.rawValue!.contains(
                                      'https://clubedecompras.app.br/pagamento/realizar?destino=')) {
                                    final String code = barcode.rawValue!;

                                    controller.readingOfQrCodeInternal({
                                      'destino': code
                                          .replaceAll(
                                              'https://clubedecompras.app.br/pagamento/realizar?destino=',
                                              '')
                                          .replaceAll('&valor=', '-')
                                          .split('-')[0],
                                      'valor': code
                                          .replaceAll(
                                              'https://clubedecompras.app.br/pagamento/realizar?destino=',
                                              '')
                                          .replaceAll('&valor=', '-')
                                          .split('-')[1],
                                    });
                                    controller.isLoadingScaan = false;
                                    Modular.to
                                        .pushNamed(AppRoutes.paymentValue);
                                  } else if (controller.statusQr == false) {
                                    controller.setStatusQr(true);
                                    Future.delayed(const Duration(microseconds: 1),
                                        () {
                                      controller.setStatusQr(true);
                                    });
                                    CashbackAlertDialog.alertInfoWithButton(
                                        context: context,
                                        onTap: () {
                                          controller.setStatusQr(false);
                                          Modular.to.pop();
                                        },
                                        text:
                                            'Atenção, QRCODE inválido!');
                                  }
                                },
                              )),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: ShapeDecoration(
                            shape: QrScannerOverlayShape(
                                borderColor: CashbackThemes.primaryRegular,
                                borderRadius: 10,
                                borderLength: 30,
                                borderWidth: 10,
                                cutOutSize: scanArea)),
                      )
                    ],
                  ),
                );
        });
  }
}
