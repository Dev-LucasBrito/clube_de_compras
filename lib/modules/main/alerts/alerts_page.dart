import 'package:cashback/core/components/app_bar/cashback_app_bar.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CashbackAppBar.appBarBack(onTap: () {
        Modular.to.pop();
      }),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(child: CashbackText.textPrimary(text: 'Nenhuma mensagem recebida.'),)
          ],
        ),
      ),
    );
  }
}
