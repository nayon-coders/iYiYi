import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/view/home.dart';
import 'package:untitled/view/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController{

  //firebase instance

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  var passwordVisi =  true.obs;
  var isLoading = false.obs;

  @override
 void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  
  void isLoadingMethod(value){
    isLoading.value = value;
    update();
  }


  void login({required String email, required String pass})async{
    isLoadingMethod(true);
    SharedPreferences _prfs = await SharedPreferences.getInstance();

    print(email);

    //create
    try {
      var response = await http.post(Uri.parse(AppConfig.login),
        body: {
          "email" : email,
          "password" : pass,
        }
      );
      print(response.body);
      print(response.statusCode);
      //check if success return
      if(response.statusCode == 200){
        _prfs.setString("token", '${jsonDecode(response.body)["data"]["auth_token"]}');
        _prfs.setString("user_id", '${jsonDecode(response.body)["data"]["user_id"]}');
        _prfs.setString("isLogin", '1');
        AppPopUp.showTost(title: jsonDecode(response.body)["message"]);
        print(_prfs.getString("token"));
        print(_prfs.getString("user_id"));
        Get.to(Home(), transition: Transition.zoom);
      }else{
        AppPopUp.showTost(title: jsonDecode(response.body)["message"]);      }
    } catch (e) {
      print("error $e");
    }
    isLoadingMethod(false);
  }

  void signUp()async{
    isLoadingMethod(true);
    print(isLoading.value);
    SharedPreferences _prfs = await SharedPreferences.getInstance();

    Map<String, String> userData = {
      "name" : name.text,
      "phone" : phone.text,
      "email" : email.text,
      "password" : pass.text,
    };
    //create
    try {
      var response = await http.post(Uri.parse(AppConfig.signup),
          body: userData
      );
      print(response.body);
      if(response.statusCode == 200){
        _prfs.setString("isLogin", '1');
        _prfs.setString("token", '${jsonDecode(response.body)["user"]["auth_token"]}');
        _prfs.setString("user_id", '${jsonDecode(response.body)["user"]["user_id"]}');
        AppPopUp.showTost(title: jsonDecode(response.body)["message"]);
       Get.offAll(Home(), transition: Transition.zoom);
      }else{
        AppPopUp.showTost(title: jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      print("error $e");
    }
    isLoadingMethod(false);
    print(isLoading.value);
  }


  void signOut()async{

  }


}

