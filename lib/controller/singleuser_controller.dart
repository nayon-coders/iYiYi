import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/model/SingleUserModel.dart';

import '../app_config.dart';
class SingleUserController extends GetxController{


  SingleUserModel? userModel;
  var isLoading = false.obs;
  void isLoadingMethod(value){
    isLoading.value = value;
    update();
  }
  Future<SingleUserModel?> getSingleUserList(userId)async {
    isLoadingMethod(true);
    SharedPreferences _prsf = await SharedPreferences.getInstance();
    var token = _prsf.getString("token");
    var response = await http.get(Uri.parse(AppConfig.base_url + "/user-find/$userId"),
        headers: {
          "Authorization" : "Bearer $token"
        });

    var data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      userModel = SingleUserModel.fromJson(data);
      isLoadingMethod(false);
    }else{
      AppPopUp.showTost(title: "Some error while geting uer profile ${response.statusCode}");
    }
    isLoadingMethod(false);

  }

}