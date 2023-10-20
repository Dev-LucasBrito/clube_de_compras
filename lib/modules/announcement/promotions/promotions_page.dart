import 'package:cashback/core/components/alert_dialog/cashback_alert_dialog.dart';
import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/cards/cashback_cards.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/modules/announcement/promotions/controller/promotions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromotionsController>(
        init: PromotionsController(),
        builder: (controller) {
          return Scaffold(
            appBar: CashbackAppBar.appBarBack(onTap: () {}),
            body: controller.loadingPromotions
                ? Center(
                    child: CashbackLoading.cashbackLoadingScaffold(
                        title: 'Carregando..'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.promotions.length,
                        itemBuilder: (context, index) {
                          var promotion = controller.promotions[index];
                          return InkWell(
                            onTap: () {
                              CashbackAlertDialog.detailAlertPromotions(
                                  context: context, promotionsModel: promotion);
                            },
                            child: CashbackCards.promotion(
                                context: context, promotionsModel: promotion),
                          );
                        }),
                  ),
          );
        });
  }
}
