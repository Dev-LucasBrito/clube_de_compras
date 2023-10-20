import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';

class ContentTopRecoveryPassword extends StatelessWidget {
  final String title;
  final String text;

  const ContentTopRecoveryPassword({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:  const  EdgeInsets.only(left: 21),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CashbackText.textPrimary(
                text: title,
                color: CashbackThemes.secundaryText,
                fontSize: 18,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 280,
                child: CashbackText.textSecundary(
                  text: text,
                  color: CashbackThemes.secundaryText,
                  fontSize: 14,
                  textAlign: TextAlign.start,
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
