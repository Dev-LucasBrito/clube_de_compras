import 'package:cashback/modules/initial_main/intro_screen/controller/intro_screen_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../core/controllers/auth_controller.dart';
import '../modules/announcement/routes/announcement_routes.dart';
import '../modules/auth/routes/auth_routes.dart';
import '../modules/initial_main/routes/initial_main_routes.dart';
import '../modules/main/routes/main_routes.dart';
import '../modules/payment/routes/payment_routes.dart';

class AppRoutesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.instance(Get.put(AuthController())),
        Bind.instance(Get.put(IntroScreenController())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: InitialMainRoute()),
        ModuleRoute('/auth', module: AuthRoute()),
        ModuleRoute('/home', module: MainRoutes()),
        ModuleRoute('/associados', module: AnnouncementRoutes()),
        ModuleRoute('/pagamento', module: PaymentRoutes()),

        // WildcardRoute(
        //     child: (context, args) => SyxNothingHere.notFound(context)),
      ];
}

class AppRoutes {
  static const String paymentResume = '/pagamento/resumo';
  static const String paymentValue = '/pagamento/realizar';
  static const String paymentCheckout = '/pagamento/checkout';
  static const String paymentQrCode = '/pagamento/scan-qrcode';
  static const String paymentSecretKey = '/pagamento/secret-key';
  //https://clubdedecompras.app.br/pagamento/valor?destino=13299555000128&valor=15.00
  //https://clubedecompras.app.br/associado/detalhes/dolcella-95

  //static const String paterns = '/announcement/paterns';
  static const String partners = '/associados/';
  static const String promotions = '/associados/promocoes';
  static const String acicla = '/associados/acicla';
  static const String partnersDetail = '/associados/:category/:slug';
  

  static const String signIn = '/auth/signin';
  static const String signUp = '/auth/signup';

  static const String home = '/home/';

  static const String splash = '/';
  static const String introScreen = '/intro-screen';
}
