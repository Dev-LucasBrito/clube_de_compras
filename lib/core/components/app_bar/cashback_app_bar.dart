import 'package:cashback/core/components/hero/cashback_hero.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CashbackAppBar {
  static appBar(
      {double? elevation = 3,
      Color? color,
      Color? colorIcons,
      required onTap,
      required String name}) {
    return AppBar(
      elevation: elevation,
      backgroundColor: color,

      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CashbackHero.heroContainer(height: 45, width: 45),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CashbackText.textPrimary(
                  text: 'Olá, ${name.split(' ')[0]}',
                  color: CashbackThemes.whiteCashback),
              CashbackText.textSecundary(
                  text: 'bem vindo de volta',
                  color: CashbackThemes.whiteCashback,
                  fontWeight: FontWeight.w200),
            ],
          ),
          const Spacer(),
        ],
      ),
      //  title: CashbackHero.heroContainer(height: 35, width: 35),
      centerTitle: false,

      actions: [
        Visibility(
          visible: true,
          child: InkWell(
            onTap: () {
              Modular.to.pushNamed('/home/alerts');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                FontAwesomeIcons.bell,
                color: colorIcons,
                size: 21,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static appBarBack({
    double? elevation = 3,
    Color? color,
    Color? colorIcons,
    required onTap,
  }) {
    return AppBar(
      elevation: elevation,
      backgroundColor: color,
      centerTitle: true,
      title: CashbackHero.heroContainer(height: 35, width: 35),
      iconTheme: IconThemeData(color: colorIcons),
    );
  }
}
