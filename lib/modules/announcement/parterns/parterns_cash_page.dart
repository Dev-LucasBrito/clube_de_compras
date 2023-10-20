import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/cards/cashback_cards.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/modules/announcement/parterns/controller/parterns_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParternsListPage extends StatelessWidget {
  const ParternsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParternsController>(
        init: ParternsController(),
        builder: (controller) {
          return Scaffold(
            appBar: CashbackAppBar.appBarBack(onTap: () {}),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.loadingBanersAssociados
                  ? CashbackLoading.cashbackLoadingScaffold(
                      title: 'Carregando parceiros...')
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.parterns.length,
                      itemBuilder: (context, index) {
                        var parterns = controller.parterns[index];
                        return CashbackCards.parternsMore(
                            context: context, partensCashbackModel: parterns);
                      }),
            ),
          );
        });
  }
}
