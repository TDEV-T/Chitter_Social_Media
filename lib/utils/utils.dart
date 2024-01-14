import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static Future<String> checkNetwork() async {
    var CheckConnect = await Connectivity().checkConnectivity();

    if (CheckConnect == ConnectivityResult.none) {
      return "";
    } else if (CheckConnect == ConnectivityResult.wifi) {
      return "wifi";
    } else if (CheckConnect == ConnectivityResult.mobile) {
      return "mobile";
    }

    return "";
  }

  static SharedPreferences? _prefs;

  static Future initSharedPrefs() async =>
      _prefs = await SharedPreferences.getInstance();

  static dynamic getSharedPrefs(String key) {
    if (_prefs == null) return null;

    return _prefs!.get(key);
  }

  static Future<bool> setSharedPrefs(String key, dynamic value) async {
    if (_prefs == null) return false;

    if (value is String) return await _prefs!.setString(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);

    return false;
  }

  static Future<bool> removeSharedPrefs(String key) async {
    if (_prefs == null) return false;
    return await _prefs!.remove(key);
  }

  static Future<bool> clearSharedPrefs() async {
    if (_prefs == null) return false;
    return await _prefs!.clear();
  }

  static Future<bool> checkSharedPrefs(String key) async {
    if (_prefs == null) return false;

    return await _prefs!.containsKey(key);
  }

  static showSnackBar(String content) {
    return SnackBar(content: Text(content),behavior: SnackBarBehavior.floating);
  }

  static showAlertDialog(context, title, content) {
    AlertDialog buildAlertDialog(Color backgroundColor, IconData icon) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 35,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(content),
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ),
        ],
      );
    }

    switch (title) {
      case "ok":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: buildAlertDialog(Colors.green[700]!, Icons.check)),
        );
      case "error":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: buildAlertDialog(Colors.red[700]!, Icons.close)),
        );
      default:
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
              heightFactor: 0.4,
              child: buildAlertDialog(Colors.blue[700]!, Icons.info_outline)),
        );
    }
  }
}
