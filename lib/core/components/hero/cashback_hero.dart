import 'package:flutter/material.dart';



class CashbackHero{

  static Widget heroContainer(
   {
      double? height = 70,
      double? width = 70,
      }

  ){
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
       
        image:const DecorationImage(image: AssetImage('assets/images/logo.webp')),
      ),
    );
  }

}