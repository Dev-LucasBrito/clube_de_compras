import 'package:flutter_modular/flutter_modular.dart';

class MenuRoutes extends Module {

  @override
  List<Bind> get binds => [
      //  Bind.lazySingleton((i) => Get.put(PaymentController())),
      ];

  @override
  List<ModularRoute> get routes => [
     //   ChildRoute('/scan-qrcode', child: (context, args) =>  const PaymentScanQrCodePage()),
     //   ChildRoute('/resume', child: (context, args) => const PaymentResumePage()),
     //   ChildRoute('/checkout', child: (context, args) =>const PaymentCheckout()),
     //   ChildRoute('/secrete-key', child: (context, args) =>const  PaymentSecretKeyPage()),   
     //   ChildRoute('/value', child: (context, args) =>const  PaymentValuePage()),   
      ];
}