import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/model/UserListModel.dart';
import '../app_config.dart';


class UserListController extends GetxController{
  UserListModel? userListModel;
  onInit(){
    super.onInit();
    getUserList();
  }
  var isLoading = false.obs;
  void isLoadingMethod(value){
    isLoading.value = value;
    update();
  }
  Future<UserListModel?> getUserList()async{
    isLoadingMethod(true);
    SharedPreferences _prsf = await SharedPreferences.getInstance();
    var token = _prsf.getString("token");
    var response = await http.get(Uri.parse(AppConfig.profile_list),
        headers: {
          "Authorization" : "Bearer $token"
        });

    var data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      userListModel = UserListModel.fromJson(data);
      isLoadingMethod(false);
      return userListModel;
    }else{
      AppPopUp.showTost(title: "Some error while geting uer profile ${response.statusCode}");
    }
    isLoadingMethod(false);

  }





}