import 'dart:ffi';

import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:get/get.dart';

import '../models/UserModel.dart';

class UserController extends GetxController {
  var myself = UserModel().obs;


  @override
  void onInit() async {
    super.onInit();
    int id = Utility.getSharedPrefs("userid");
    fetchMySelf(id);
  }
  
   Future<bool> fetchMySelf(int id) async {
      var usrResult = await RestAPI().getUserById(id);

      if (usrResult != null){
        myself.value = usrResult;
        return true;
      }

      return false;
   }
  
}