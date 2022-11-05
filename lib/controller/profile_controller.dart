import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/view/profile.dart';

import '../model/ProfileModel.dart';

class ProfileController extends GetxController{
  ProfileModel? profileModel;

  var image;
  var isUpload = false.obs;
  File? selectedFile;


  var password=true;
  final picker = ImagePicker();

  @override
  onInit(){
    super.onInit();
    GetProfile();
  }

  var isLoading = false.obs;

  GetProfile()async{
    isLoading.value = true;
    SharedPreferences _prfs =await SharedPreferences.getInstance();
    var token = await _prfs.getString("token");
    var userId = await _prfs.getString("user_id");
    print("user profile ===== $userId");
    var response = await http.get(Uri.parse(AppConfig.base_url+"/user-find/$userId"),
      headers: {
          "Authorization" : "Bearer $token",
      }
    );
    if(response.statusCode == 200){
      profileModel = ProfileModel.fromJson(jsonDecode(response.body));
      print(profileModel!.user!.name);
    }else{
      print("data is fetch prodble");
    }
    isLoading.value = false;
  }

  void isLoadingMethod(value){
    isLoading.value = value;
    update();
  }


  updateProfile({required String name, required String email, required String phone, required String fb, required String tw, required String insta})async{
    isLoadingMethod(true);
    SharedPreferences _prfs =await SharedPreferences.getInstance();
    var token = await _prfs.getString("token");
    var userId = await _prfs.getString("user_id");
    print("user profile ===== $userId");

    print(email);
    var response = await http.post(Uri.parse(AppConfig.PROFILE_UPDATE),
        body: {
          "name"      : name,
          "email"     : email,
          "phone"     : phone,
          "facebook"  : fb,
          "instagram" : insta,
          "twitter"   : tw,
        },
        headers: {
          "Authorization" : "Bearer $token",
        }
    );
    print(response.statusCode );
    print(response.body );
    if(response.statusCode == 200){
      AppPopUp.showTost(title: "Profile is updated");
      Get.offAll(Profile());
    }else{
      print(" somethis went warng with udated");
    }
    isLoadingMethod(false);
    update();
  }



  //TODO: Gallery Image picker
  ImagePic(pickImageType)async{
   isUpload.value = true;
    final pickerFile = await picker.getImage(source: pickImageType);
    if(pickerFile != null){
      print("Image file path === $pickerFile");

    }else{
      AppPopUp.showTost(title: "No Image Selected");
    }
   isUpload.value = false;


  }





}