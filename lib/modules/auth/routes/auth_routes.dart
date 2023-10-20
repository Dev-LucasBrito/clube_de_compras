import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/modules/auth/recovery_pass/recovery_pass_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../sign_up/sign_up_page.dart';
import '../sing_in/sign_in_page.dart';

class AuthRoute extends Module {

  @override
  List<Bind> get binds => [
      Bind.lazySingleton((i) => Get.put(AuthController())),
      ];

  @override
  List<ModularRoute> get routes => [
    
  ChildRoute('/recovery-pass', child: (context, args) =>const  RecovaryPasswordPage()),   
  ChildRoute('/signup', child: (context, args) =>  const SignUpPage()),   
  ChildRoute('/signin', child: (context, args) =>const  SignInPage()),   
      ];
}