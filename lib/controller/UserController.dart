import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:get/get.dart';

import '../models/UserModel.dart';

class UserController extends GetxController {
  var myself = UserModel().obs;


  @override
  void onInit(){
    super.onInit();
    int id = Utility.getSharedPrefs("userid");
    fetchUserByID(id);
  }
  
   void fetchUserByID(int id) async {
      var usrResult = await RestAPI().GetUserProfileData(id);

      if (usrResult != null){
        myself.value = usrResult;
      }
   }
  
}