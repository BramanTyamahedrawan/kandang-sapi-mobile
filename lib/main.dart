import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:crud_flutter_api/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async { 
  try {
    // Pastikan Flutter binding diinisialisasi
    WidgetsFlutterBinding.ensureInitialized();

    // Inisialisasi storage dan locale
    await Future.wait([
      GetStorage.init(),
      initializeDateFormatting('id_ID', null),
    ]);

    final box = GetStorage();
    Intl.defaultLocale = 'id_ID';

    // Tambahkan error handling untuk pembacaan token
    final token = box.read("token");
    print('Token: $token');

    runApp(
      GetMaterialApp(
        title: "Application",
        initialRoute: token == null ? Routes.START : Routes.NAVIGATION,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        defaultTransition: Transition.fade,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  } catch (e, stackTrace) {
    print('Initialization error: $e');
    print('Stack trace: $stackTrace');
  }
}
