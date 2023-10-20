import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../controller/payment_controller.dart';
import '../pages/payment_checkout_page.dart';
import '../pages/payment_resume_page.dart';
import '../pages/payment_scan_qr_code_page.dart';
import '../pages/payment_secret_key_page.dart';
import '../pages/payment_value.dart';

class PaymentRoutes extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => Get.put(PaymentController())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/scan-qrcode',
            child: (context, args) => const PaymentScanQrCodePage()),
        ChildRoute('/resumo',
            child: (context, args) => const PaymentResumePage()),
        ChildRoute('/checkout',
            child: (context, args) => const PaymentCheckout()),
        ChildRoute('/secret-key',
            child: (context, args) => const PaymentSecretKeyPage()),
        ChildRoute('/realizar',
            child: (context, args) => const PaymentValuePage()),
      ];
}
//"destino":"13.299.555\/0001-28","valor":"15.00"
//https://clubdedecompras.app.br/pagamento/valor?destino=13299555000128&valor=15.00

