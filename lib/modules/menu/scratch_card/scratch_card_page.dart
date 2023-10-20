import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/menu/scratch_card/controller/scratch_card_controller.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCardPage extends StatelessWidget {
  const ScratchCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScratchCardController>(
        init: ScratchCardController(),
        builder: (controller) {
          return Scaffold(
            appBar: CashbackAppBar.appBarBack(onTap: () {}),
            body: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Stack(
                children: [
                  Center(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const  NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 130,
                                mainAxisExtent: 120,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 6),
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          // var menu = controller.menu[index];
                          return Scratcher(
                            brushSize: 30,
                            threshold: 50,
                            color: CashbackThemes.greyCashbackDark,
                            onChange: (value) {},
                            onThreshold: () {
                              //controller.controllerCenter.play();
                             
                            },
                            child: Container(
                              height: 300,
                              width: 300,
                              color: CashbackThemes.primaryRegular,
                            ),
                          );
                        }),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: controller.controllerCenter,
                      blastDirectionality: BlastDirectionality
                          .explosive, // don't specify a direction, blast randomly
                      shouldLoop:
                          true, // start again as soon as the animation is finished
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple
                      ], // manually specify the colors to be used
                      createParticlePath:
                          controller.drawStar, // define a custom shape/path.
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
