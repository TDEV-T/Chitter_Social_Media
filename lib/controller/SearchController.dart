import 'package:chitter/models/SearchModel.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:get/get.dart';

class SearchGetxController extends GetxController{
  var searchResult = SearchModel().obs;


  Future<SearchModel> searchFunction(String search) async {
    SearchModel resp = await RestAPI().searchFunc(search);
    if (resp != null){
      searchResult.value = resp;
    }

    return resp;
  }


}