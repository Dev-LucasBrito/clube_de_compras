import 'package:flutter/material.dart';

class CashbackThemes {
  CashbackThemes._();

  static const Color primaryDarker = Color(0xFF461E08);
  static const Color primaryDarK = Color(0xFF963D0B);
  static const Color primaryRegular = Color(0xFFDC5C14);
  static const Color primaryLight = Color(0xFFFF823C);
  static const Color primaryLightest = Color(0xFFFFA06B);
  static const Color primaryPastel = Color.fromARGB(255, 231, 143, 102);



  static const Color blue = Color.fromARGB(255, 20, 33, 220);

  static const Color primaryText = Color(0xFF1A1A1A);
  static const Color secundaryText = Color(0xFF666666);

  static const Color bgScaffold = Color(0xFFFFFFFF);

  static const Color darkCashback = Color(0xFF1A1A1A);
  static final Color darkCashback72 = const Color(0xFF1A1A1A).withOpacity(0.72);
  static const Color greyCashbackDarest = Color(0xFF363636);
  static const Color greyCashbackDarker = Color(0xFF666666);
  static const Color greyCashbackDark = Color(0xFFABABAB);
  static const Color greyCashbackRegular = Color(0xFFC7C7C7);
  static const Color greyCashbackLight = Color(0xFFE6E6E6);
  static const Color greyCashbackLighteste = Color(0xFFF2F2F2);

  static const Color whiteCashback = Color(0xFFFFFFFF);
  static const Color whiteCashbackRegular = Color(0xFFF2F2F2);
  static final Color whiteCashback75 = const Color(0xFFF2F2F2).withOpacity(0.75);
  static final Color whiteCashback50 = const Color(0xFFF2F2F2).withOpacity(0.50);
  static final Color whiteCashback25 = const Color(0xFFF2F2F2).withOpacity(0.25);

  static const Color success = Color(0xFF458723);
  static const Color successRegular = Color(0xFF63C132);
  static const Color successLight = Color(0xFFA1DA84);

  static const Color error = Color(0xFFA93422);
  static const Color errorRegular = Color(0xFFF24A30);
  static const Color errorLight = Color(0xFFF6806E);

  static const Color warningDark = Color(0xFFB3913C);
  static const Color warningRegular = Color(0xFFFFCF56);
  static const Color warningLight = Color(0xFFFFE29A);

  static const Color whatsAppColor = Color(0xFF0D9F16);

  static String font1 = "IBMPlexSans";
  static String font2 = "WorkSans";

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, 
    textTheme: const TextTheme(
    
    ).apply(
      bodyColor: primaryText,
      displayColor: Colors.blue,
    ),
    fontFamily: font1,
    primaryTextTheme: const TextTheme(
      ),
    scaffoldBackgroundColor: bgScaffold,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryDarK),
    appBarTheme: const AppBarTheme(
        backgroundColor: whiteCashbackRegular,
        titleTextStyle: TextStyle(color: primaryText),
        iconTheme: IconThemeData(color: primaryText)),
    colorScheme: const ColorScheme.light(
      primary: primaryText,
      // primaryVariant: primaryDarK
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: primaryDarK,
    ),
    buttonTheme: const ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                topRight: Radius.circular(4),
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4)))),
  );
}



/* inputDecorationTheme: const InputDecorationTheme(


      contentPadding: EdgeInsets.only(left: 24,right: 24),
      counterStyle: TextStyle(
        color: primaryDarK
      ),
      hintStyle: TextStyle(
        color: primaryText
      ),
      suffixStyle: TextStyle(
          color: primaryText
      ),
      prefixStyle: TextStyle(color: primaryDarK),
      border:  OutlineInputBorder(
          borderSide: BorderSide(color: whiteCashbackRegular),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
          topRight: Radius.circular(2),
          topLeft:  Radius.circular(2), bottomLeft:  Radius.circular(2)
         )
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteCashbackRegular),

          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
              topRight: Radius.circular(2),
              topLeft:  Radius.circular(2), bottomLeft:  Radius.circular(2)
          )
      ),

      focusedBorder: UnderlineInputBorder(

          borderSide: BorderSide(color: primaryDarK),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
              topRight: Radius.circular(2),
              topLeft:  Radius.circular(2), bottomLeft:  Radius.circular(2)
          )
      ),
      disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteCashbackRegular),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
              topRight: Radius.circular(2),
              topLeft:  Radius.circular(2), bottomLeft:  Radius.circular(2)
          )
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
              topRight: Radius.circular(2),
              topLeft:  Radius.circular(2), bottomLeft:  Radius.circular(2)
          )
      ),
      focusedErrorBorder: OutlineInputBorder(

          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),
              topRight: Radius.circular(2),
              topLeft:  Radius.circular(2), bottomLeft:  Radius.circular(2)
          )
      ),
      fillColor: whiteCashbackRegular
    ),*/