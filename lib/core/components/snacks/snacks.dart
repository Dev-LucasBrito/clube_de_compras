import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cashback/core/components/hero/cashback_hero.dart';
import 'package:cashback/core/components/text/cashback_text.dart';
import 'package:flutter/material.dart';

class CashbackSnackBar {
  static snackbarCustom(
      {required String title,
      required String description,
      required context,
      required Color bgColor,
      required Color textColor,
      ///1 - alert, 2 - sucesso, 3 - Erro, 4 - logo
      required int iconType,
      ///1 - alert, 2 - sucesso, 3 - Erro, 4 - logo 
      }) {
    return AnimatedSnackBar(
      builder: ((context) {
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(9)),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  iconType == 1
                      ? Icon(
                          Icons.info,
                          color: textColor,
                        )
                      : iconType == 2
                          ? Icon(
                              Icons.check,
                              color: textColor,
                            )
                          : iconType == 3
                              ? Icon(
                                  Icons.error,
                                  color: textColor,
                                )
                              : CashbackHero.heroContainer(),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CashbackText.textPrimary(text: title, color: textColor),
                        const SizedBox(
                          height: 3,
                        ),
                        CashbackText.textSecundary(
                            text: description, color: textColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ).show(context);
  }

  static snackbarError({
    String? title = 'Erro',
    required String description,
    required  context,
  }) {
    return AnimatedSnackBar.rectangle(
      title!,
      description,
      type: AnimatedSnackBarType.error,
    ).show(
      context,
    );
  }

  static snackbarSuccess({
    String? title = 'Sucesso',
    required String description,
    required  context,
  }) {
    return AnimatedSnackBar.rectangle(
      title!,
      description,
      type: AnimatedSnackBarType.success,
    ).show(
      context,
    );
  }

  static snackbarWarning({
    String? title = 'Aviso',
    required String description,
    required  context,
  }) {
    return AnimatedSnackBar.rectangle(
      title!,
      description,
      type: AnimatedSnackBarType.warning,
    ).show(
      context,
    );
  }
}
