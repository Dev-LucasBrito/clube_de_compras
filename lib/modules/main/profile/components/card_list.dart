import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';

class CardListComponent extends StatelessWidget {
  final String text;
  final String? subText;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool? hasEdit;
 const CardListComponent(
      {Key? key,
      required this.icon,
      required this.text,
      this.subText = '',
      this.hasEdit = true,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 21, right: 21, bottom: 27),
        child: Row(
          children: [
            Container(
              height: 39,
              width: 39,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    colors: [color, color.withOpacity(0.5)]),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(
                icon,
                color: CashbackThemes.whiteCashback,
                size: 18,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CashbackText.textPrimary(text: text),
                  Visibility(
                      visible: subText!.isNotEmpty,
                      child: CashbackText.textSecundary(
                          text: subText!,
                          color: CashbackThemes.greyCashbackDark, textOverflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
            const Spacer(),
            Visibility(
              visible: hasEdit!,
              child: const Icon(Icons.arrow_right)),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
