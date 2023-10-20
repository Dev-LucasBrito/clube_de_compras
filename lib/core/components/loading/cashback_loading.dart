import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CashbackLoading {
  static Widget cashbackLoadingScaffold({required String title}) {
    return Scaffold(
        backgroundColor: CashbackThemes.whiteCashback,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      width: 50,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: CashbackThemes.primaryRegular,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              CashbackText.textPrimary(text: title),
            ],
          ),
        ));
  }

  static Widget loading({double? size = 50 }) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: CashbackThemes.primaryRegular,
      size: size!,
    );
  }
}
