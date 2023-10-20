import 'package:cashback/modules/main/alerts/alerts_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../home/controller/home_controller.dart';
import '../home/home_page.dart';
import '../profile/controller/profile_controller.dart';
import '../profile/profile_page.dart';
import '../selected_payment/selected_payment.dart';
import '../statement/controller/statement_controller.dart';
import '../statement/statement_page.dart';

class MainRoutes extends Module {
 // final regExp = RegExp("bot|google|baidu|bing|msn|teoma|slurp|yandex");
 // regExp.hasMatch(html.window.navigator.userAgent) ? WebHomeBot() :   

  

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => Get.put(HomeController())),
        Bind.lazySingleton((i) => Get.put(ProfileController())),
        Bind.lazySingleton((i) => Get.put(StatementController())),

      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) =>  const HomePage()),
        ChildRoute('/profile', child: (context, args) => const ProfilePage()),
        ChildRoute('/selected-payment', child: (context, args) =>const SelectedPayment()),
        ChildRoute('/statement', child: (context, args) =>const  StatementPage()),
        ChildRoute('/alerts', child: (context, args) =>const  AlertsPage()),
      ];
}