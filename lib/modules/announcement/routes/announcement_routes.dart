import 'package:cashback/modules/announcement/acicla/acicla_page.dart';
import 'package:cashback/modules/announcement/parterns_details/parterns_page.dart';
import 'package:cashback/modules/announcement/promotions/promotions_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import '../acicla/controller/acicla_controller.dart';
import '../parterns/controller/parterns_controller.dart';
import '../parterns/parterns_cash_page.dart';
import '../parterns_details/controller/parterns_detail_controller.dart';
import '../promotions/controller/promotions_controller.dart';

class AnnouncementRoutes extends Module {

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => Get.put(AciclaController())),
        Bind.lazySingleton((i) => Get.put(ParternsController())),
        Bind.lazySingleton((i) => Get.put(ParternsDetailController())),
        Bind.lazySingleton((i) => Get.put(PromotionsController())),


      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/acicla', child: (context, args) =>  const AciclaPage()),
        ChildRoute('/', child: (context, args) => const ParternsListPage()),
        ChildRoute('/:category/:slug', child: (context, args) =>const ParternsDetailPage()),
        ChildRoute('/promocoes', child: (context, args) =>const  PromotionsPage()),   
      ];
}


