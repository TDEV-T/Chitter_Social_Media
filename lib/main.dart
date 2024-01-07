import 'package:chitter/app_router.dart';
import 'package:chitter/themes/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.lightTheme,
    debugShowCheckedModeBanner: false,
    initialRoute: AppRouter.login,
    routes: AppRouter.routes,
  ));
}
