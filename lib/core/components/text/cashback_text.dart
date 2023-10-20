import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:flutter/material.dart';

class CashbackText {
  static Widget textPrimary({
    required String text,
     TextAlign? textAlign,
     Color? color = CashbackThemes.primaryText,
     double? fontSize,
     FontWeight? fontWeight = FontWeight.w700,
     TextDecoration? decoration,
     TextOverflow? textOverflow,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        overflow: textOverflow
      ),
    );
  }

    static Widget textSecundary({
    required String text,
     TextAlign? textAlign,
     Color? color = CashbackThemes.secundaryText,
     double? fontSize,
     FontWeight? fontWeight = FontWeight.w400,
        TextOverflow? textOverflow,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      overflow: textOverflow,
    );
  }

    static Widget textButtonUnderline({
    required String text,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: textPrimary(
        text: text,
        fontWeight: FontWeight.w700,
        fontSize: 10,
        decoration: TextDecoration.underline,
       // color: color ?? SyxThemes.secundaryText,
      ),
    );
  }

    static Widget parternRinch({
    required List<InlineSpan> textSpan,
    String? textPrimary,
    double? fontSize = 12.0,
    FontWeight? fontWeight = FontWeight.w400,
    double? heigth = 1.8, 
    Color? color = CashbackThemes.primaryText,
    String? fontFamily,
    TextAlign? textAlign = TextAlign.start,
    bool? overflow = false,
  }) {
   
      return RichText(
        textAlign: textAlign!,
        text: TextSpan(
            spellOut: false,
            style: TextStyle(
                color: color,
                fontSize: fontSize,
                
                fontWeight: fontWeight,
                overflow: overflow == true ? TextOverflow.ellipsis : null,
                decoration: TextDecoration.none),
                
            text: textPrimary,
            
            children: textSpan),
      );
    
  }
}
