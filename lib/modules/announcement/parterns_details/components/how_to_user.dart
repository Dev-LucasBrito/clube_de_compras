import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';

class HowToUse extends StatelessWidget {
  final String textNumber;
  final String title;
  final String description;
  const HowToUse({Key? key, required this.textNumber, required this.title, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21,right: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CashbackText.textPrimary(text: textNumber, fontSize: 18),
         const SizedBox(height: 9,),
          CashbackText.textPrimary(text: title, fontSize: 18, color: CashbackThemes.primaryRegular),
            const SizedBox(height: 9,),
          CashbackText.textSecundary(text: description, fontSize: 18),

        
        ],
      ),
    );
  }
}
