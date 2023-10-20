import 'dart:io';

import 'package:cashback/core/components/cards/cashback_cards.dart';
import 'package:cashback/core/components/loading/cashback_loading.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/models/statement_model.dart';
import 'package:cashback/modules/main/statement/controller/statement_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:upgrader/upgrader.dart';

import '../../../core/theme/cashback_theme.dart';

class StatementPage extends StatelessWidget {
  const StatementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatementController>(
        init: StatementController(),
        builder: (controller) {
          return UpgradeAlert(
             upgrader: Upgrader(
              showIgnore: false,
              showLater: false,
              shouldPopScope: ()=> false,
              dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material ,
              showReleaseNotes: false,
              minAppVersion: '1.0.7'
            ),
            child: Scaffold(
            
              body: Stack(
                children: [
                   Container(
                        height: 240,
                        decoration: const BoxDecoration(
                          color: CashbackThemes.darkCashback,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 21),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                CashbackText.textSecundary(
                                    text: 'Disponível:',
                                    color: CashbackThemes.whiteCashback,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: CashbackText.textPrimary(
                                          text: 'Cb\$',
                                          fontSize: 16,
                                          color: CashbackThemes.whiteCashback),
                                    ),
                                    controller.valueVisibility
                                        ? CashbackText.textPrimary(
                                            text: controller
                                                .authController.saldoString,
                                            color: CashbackThemes.whiteCashback,
                                            fontSize: 33)
                                        : Container(
                                            height: 25,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: CashbackThemes
                                                  .greyCashbackRegular,
                                            )),
                                     const SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.setVisibilityValue();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Icon(
                                          controller.valueVisibility
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash,
                                          color: CashbackThemes.whiteCashback,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                   
                                  ],
                                ),
                                const SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  children: [
                                    CashbackText.textSecundary(
                                        text: 'A receber:  ',
                                        color: CashbackThemes.whiteCashback,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w200),
                                    CashbackText.textSecundary(
                                      text: 'Cb\$ 00,00',
                                      color: CashbackThemes.whiteCashback,
                                      fontSize: 13,
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                  Padding(
                     padding: const EdgeInsets.only(top: 140),
                    child: Container(
                       constraints: const BoxConstraints(maxWidth: 700),
                            decoration: const BoxDecoration(
                                color: CashbackThemes.whiteCashback,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(33),
                                    topRight: Radius.circular(33))),
                      child: controller.isLoading
                      ? SizedBox(
                          child: Center(child: CashbackLoading.cashbackLoadingScaffold(title: 'Carregando')),
                        )
                      : controller.statementModel.isEmpty ? Center(
                        child: SizedBox(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              CashbackText.textPrimary(text: 'Nenhuma transação feita...')
                            ]),
                          ),
                        ),
                      ) : Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(21)),
                        child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.statementModel.length,
                                      itemBuilder: (context, index) {
                                        StatementModel statement =
                                            controller.statementModel[index];
            
                                        if (controller.statementModel.length > 3 && index != 0) {
                                          StatementModel st2 =
                                              controller.statementModel[index - 1];
            
                                          return ('${st2.date!.day}/${st2.date!.month}/${st2.date!.year}') != 
                                          ('${statement.date!.day}/${statement.date!.month}/${statement.date!.year}')
                                              ? CashbackCards.cardStatement2(
                                                  statementModel: statement)
                                              : CashbackCards.cardStatement(
                                                  statementModel: statement);
                                        } else if (index == 0) {
                                          return CashbackCards.cardStatement2(
                                              statementModel: statement);
                                        }else{
                                             return CashbackCards.cardStatement(
                                            statementModel: statement);
                                        }
                                     
                                      }),
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  )
                ],
              )),
          );
        });
  }
}
