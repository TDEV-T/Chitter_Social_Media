import 'dart:convert';

import 'package:chitter/app_router.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/themes/styles.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

var initialRoute = AppRouter.login;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Utility.initSharedPrefs();

  String? token = Utility.getSharedPrefs("token");

  if (token != null) {
    try{
      var resp = await RestAPI().CurUser(token);

      if (resp != null) {
        var decoded = jsonDecode(resp);
        Utility().logger.i(decoded);
        if (decoded["status"]){
          initialRoute = AppRouter.home;
        }
      }
    }catch(e){
      Utility().logger.e(e);
    }
  }

  runApp(MaterialApp(
    theme:  AppTheme.lightTheme,
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoute,
    routes: AppRouter.routes,
  ));
}
