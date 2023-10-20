import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';

class CashbackListWidget {
  static List<Widget> listOfRowsList({
    required List items,
  }) {
    List<Widget> lines = [];

    // ignore: unused_local_variable
    for (Map line in items) {
      lines.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: CashbackThemes.greyCashbackRegular,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CashbackText.textPrimary(
                      text: 'Nome do produto aqui',
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 16),
                  const SizedBox(
                    height: 15,
                  ),
                  CashbackText.parternRinch(textSpan: [
                    const TextSpan(
                        text: 'de: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    const TextSpan(
                        text: '5%',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough)),
                    const TextSpan(
                        text: '  por: ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    const TextSpan(
                        text: '7% de cashback',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: CashbackThemes.primaryRegular)),
                  ]),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return lines;
  }
}
