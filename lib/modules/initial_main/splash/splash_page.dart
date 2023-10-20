import 'package:cashback/core/controllers/auth_controller.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (context) {
          return Scaffold(
            body: Container(
              color: CashbackThemes.whiteCashback,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/intro1.webp')),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21,),
                  Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      width: 50,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: CashbackThemes.primaryRegular,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
                ],
              ),
            ),
          );
        });
  }
}
