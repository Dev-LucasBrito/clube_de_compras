import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CashbackDrawer {
  static drawer() {
    return Drawer(
      child: SafeArea(
        child: Column(children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: CashbackThemes.greyCashbackRegular),
          ),
          const SizedBox(
            height: 21,
          ),
          CashbackText.textSecundary(text: 'BEM VINDO'),
          CashbackText.textPrimary(text: 'LUCAS GABRIEL'),
          const SizedBox(
            height: 41,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.trophy,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Cliente ouro'),
              ],
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.percent,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Promoções'),
              ],
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.bolt,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Super Cashback'),
              ],
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.book,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Minhas Reservas'),
              ],
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          Container(
            height: 2,
            color: CashbackThemes.greyCashbackLight,
          ),
          const SizedBox(
            height: 31,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.person,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Minha conta'),
              ],
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.bookBookmark,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Termos de uso'),
              ],
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                const Icon(
                  FontAwesomeIcons.book,
                  size: 18,
                ),
                const SizedBox(
                  width: 9,
                ),
                CashbackText.textPrimary(text: 'Politica de privacidade'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
