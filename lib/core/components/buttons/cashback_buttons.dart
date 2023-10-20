import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CashbackButtons {
  static Widget cashbackButton({required context, required title, required onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CashbackThemes.primaryLight,
                  CashbackThemes.primaryRegular,
                ])),
        child: Center(
            child: CashbackText.textPrimary(text: title, color: Colors.white)),
      ),
    );
  }
  static Widget cashbackButtonWithLoading({required context, required title, required onTap, required  isLoading}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CashbackThemes.primaryLight,
                  CashbackThemes.primaryRegular,
                ])),
        child: isLoading == true ? Center(
          child: SizedBox(
            width: 30,
            child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.white,
            size: 33,
              ),
          ),
        ): Center(
            child: CashbackText.textPrimary(text: title, color: Colors.white)),
      ),
    );
  }
}
