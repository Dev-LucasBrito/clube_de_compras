import 'dart:io';

import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/hero/cashback_hero.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/modules/main/home/components/components.dart';
import 'package:cashback/modules/main/home/controller/home_controller.dart';
import 'package:cashback/modules/main/profile/profile_page.dart';
import 'package:cashback/modules/main/selected_payment/selected_payment.dart';
import 'package:cashback/modules/main/statement/statement_page.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return UpgradeAlert(
            upgrader: Upgrader(
              showIgnore: false,
              showLater: false,
              shouldPopScope: () => false,
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
              showReleaseNotes: false,
            ),
            child: Scaffold(
              // key: controller.scaffoldKey,
              extendBody: true,

              appBar: CashbackAppBar.appBar(
                  onTap: () {
                    //   controller.scaffoldKey.currentState!.openDrawer();
                  },
                  elevation: 0,
                  color: CashbackThemes.darkCashback,
                  colorIcons: CashbackThemes.whiteCashback,
                  name: controller.authController.user!.name),
              // drawer: CashbackDrawer.drawer(),
              backgroundColor: CashbackThemes.whiteCashback,
              body: SafeArea(
                child: Column(children: [
                  Visibility(
                    visible: false,
                    child: Container(
                      height: 75,
                      color: CashbackThemes.darkCashback,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 21, right: 21),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CashbackHero.heroContainer(height: 35, width: 35),
                            const Visibility(
                              visible: false,
                              child: Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(
                                  FontAwesomeIcons.bell,
                                  color: CashbackThemes.whiteCashback,
                                  size: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  controller.page == 0
                      ? const Flexible(child: HomeComponent())
                      : controller.page == 1
                          ? const Flexible(child: StatementPage())
                          : controller.page == 3
                              ? const Flexible(child: ProfilePage())
                              : controller.page == 2
                                  ? const Flexible(child: SelectedPayment())
                                  : const SizedBox(
                                      child:
                                          Center(child: Text('EM CONSTRUÇÃO')),
                                    ),
                ]),
              ),
              bottomNavigationBar: FluidNavBar(
                style: const FluidNavBarStyle(
                  barBackgroundColor: Color.fromARGB(255, 241, 241, 241),
                  iconSelectedForegroundColor: CashbackThemes.primaryRegular,
                  iconUnselectedForegroundColor: CashbackThemes.darkCashback,

                  // iconBackgroundColor: CashbackThemes.primaryRegular
                ),
                icons: [
                  FluidNavBarIcon(
                    icon: Icons.home,
                  ),
                  FluidNavBarIcon(
                    icon: Icons.list,
                  ),
                  FluidNavBarIcon(
                    icon: Icons.payment,
                  ),
                  FluidNavBarIcon(
                    icon: Icons.person,
                  ),
                ],
                onChange: (e) {
                  controller.setPages(e);
                }, // (4)
              ),
            ),
          );
        });
  }
}
