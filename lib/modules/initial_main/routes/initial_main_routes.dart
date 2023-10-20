import 'package:cashback/modules/initial_main/intro_screen/controller/intro_screen_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';


import '../../../core/controllers/auth_controller.dart';
import '../intro_screen/intro_screen_page.dart';
import '../splash/splash_page.dart';

class InitialMainRoute extends Module {

  @override
  List<Bind> get binds => [
      Bind.instance(Get.put(AuthController())),
         Bind.instance(Get.put(IntroScreenController())),
      ];

  @override
  List<ModularRoute> get routes => [
    
  ChildRoute('/intro-screen', child: (context, args) =>  const IntroScreenPage()),   
  ChildRoute('/', child: (context, args) =>const  SplashPage()),   
  
      ];
}