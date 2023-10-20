import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/initial_main/intro_screen/controller/intro_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenPage extends StatelessWidget {
  const IntroScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroScreenController>(
        init: IntroScreenController(),
        builder: (controller) {
          return Scaffold(
            body: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: "Bem Vindo!",
                  body:
                      "Bem vindo ao Clube de Compras Acicla, o app que te dá cashback em todas as suas compras com nossos parceiros!",
                  image: Center(
                      child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/intro1.webp')),
                    ),
                  )),
                  decoration: const PageDecoration(),
                ),
                PageViewModel(
                  title: "Como ganhar?",
                  bodyWidget: CashbackText.parternRinch(
                      textPrimary:
                          "Para começar a ganhar seus cashback é bem simples.",
                      textSpan: [
                        const TextSpan(
                            text:
                                '\n\n 1º - Crie sua conta!\n\n 2º - Sempre que comprar com nossos parceiros, basta dizer seu CPF!',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        const TextSpan(
                          text:
                              '\n\nSimples né ? Arraste para o lado e veja como usar ->',
                        )
                      ],
                      textAlign: TextAlign.start,
                      fontSize: 16),
                  image: Center(
                      child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/intro2.webp')),
                    ),
                  )),
                  decoration: const PageDecoration(),
                ),
                PageViewModel(
                  title: "Como usar ?",
                  bodyWidget: CashbackText.parternRinch(
                      textPrimary:
                          "Para usar seu cashback também é bem simples: ",
                      textSpan: [
                        const TextSpan(
                            text:
                                '\n\n 1º - Vá até um dos nossos parceiros e diga que gostaria de utilizar seus pontos;'
                                '\n\n 2º - Abra o aplicativo e clique em usar pontos;'
                                '\n\n 3º - Escaneie o QR code do nosso parceiro ou peça a chave;'
                                '\n\n 4º - Depois digite o valor e utilize seus pontos.',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        const TextSpan(
                          text:
                              '\n\nAgora você já pode sair usando seus cashbacks!',
                        )
                      ],
                      textAlign: TextAlign.start,
                      fontSize: 16),
                  image: Center(
                      child: SizedBox(
                    height: 250,
                    width: 250,
                    
                    child:Image.asset('assets/images/comoganhar.webp')
                  )),
                  decoration: const PageDecoration(),
                ),
              ],
              onDone: () {
                controller.onIntroEnd();
                // When done button is press
              },
              onSkip: () {
                // You can also override onSkip callback
              },
              showBackButton: false,
              next: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: CashbackThemes.primaryRegular),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_right,
                      size: 26,
                    ),
                  )),
              done: const Text("Pronto",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              dotsDecorator: DotsDecorator(
                  size: const Size.square(10.0),
                  activeSize: const Size(20.0, 10.0),
                  activeColor: CashbackThemes.primaryRegular,
                  color: Colors.black26,
                  spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0))),
            ),
          );
        });
  }
}
