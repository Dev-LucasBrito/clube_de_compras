import 'package:cashback/core/biding/app_biding.dart';
import 'package:cashback/core/theme/cashback_theme.dart';
import 'package:cashback/routes/app_routes.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
    //Responsavel por iniciar a injeção de dependencia com o a lib GetX.
  WidgetsFlutterBinding.ensureInitialized();

    //Responsevel por guardar dados em memoria do app. 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
   //FirebaseAnalyticsObserver observer =
   //   FirebaseAnalyticsObserver(analytics: analytics);
  //Responsavel por iniciar a injeção de dependencia com o a lib GetX.
  WidgetsFlutterBinding.ensureInitialized();

  //Responsevel por guardar dados em memoria do app.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: CashbackThemes.darkCashback,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(ModularApp(
    module: AppRoutesModule(),
    child: GetMaterialApp.router(
      title: 'Cashback Acicla',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      theme: CashbackThemes.lightTheme,
      darkTheme: CashbackThemes.lightTheme,
      themeMode: ThemeMode.system,
    ),
  ));
}
