import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/cards/cashback_cards.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/modules/announcement/acicla/controller/acicla_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AciclaPage extends StatelessWidget {
  const AciclaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AciclaController>(
        init: AciclaController(),
        builder: (controller) {
          return Scaffold(
            appBar: CashbackAppBar.appBarBack(onTap: () {}),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.loadingBanersAcicla
                  ? CashbackLoading.cashbackLoadingScaffold(
                      title: 'Carregando Mural')
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              mainAxisExtent: 200,
                              crossAxisSpacing: 9,
                              mainAxisSpacing: 9),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.bannersAcicla.length,
                      itemBuilder: (context, index) {
                        var banners = controller.bannersAcicla[index];
                        return CashbackCards.bannersAcicla(muralModel: banners);
                      }),
            ),
          );
        });
  }
}
