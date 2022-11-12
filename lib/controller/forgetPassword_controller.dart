import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/view/OTP.dart';
import 'package:untitled/view/login.dart';
import 'package:untitled/view/reset-pass.dart';

import '../view/forget_pass.dart';
class ForgetPassController extends GetxController{

  final otp = TextEditingController();
  final retypePassword = TextEditingController();

  var isSendEmail = false.obs;
  var isOTPSend = false.obs;
  var isPasswordSet = false.obs;

  void senOtp(email)async{
    isSendEmail.value = true;

    var response = await http.post(Uri.parse(AppConfig.SEND_CODE),
      body: {
        "email" : email,
      },
    );
    var data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      Get.to(OTP(eamil: email,));
      AppPopUp.showTost(title: "${data["message"]}" );
    }else{
      AppPopUp.showTost(title: "${data["message"]}" );
    }



    isSendEmail.value = false;
  }



  void otpVerify(email, token)async{
    isOTPSend.value = true;

    var response = await http.post(Uri.parse(AppConfig.CHECK_TOKEN),
      body: {
        "email" : email,
        "token" : token,
      },
    );
    var data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      Get.to(ResetPass(email: email,));
      AppPopUp.showTost(title: "${data["message"]}" );
    }else{
      AppPopUp.showTost(title: "${data["message"]}" );
    }

    isOTPSend.value = false;
  }


  void resetPass(pass, email)async{
    print(email);
    isPasswordSet.value = true;

    var response = await http.post(Uri.parse(AppConfig.RESET_PASS),
      body: {
        "email" : email,
        "new_password": pass,
      },
    );
    print(response.statusCode);
    var data = jsonDecode(response.body);
    print(data);
    if(response.statusCode == 200){
      Get.to(Login());
      AppPopUp.showTost(title: "${data["message"]}" );
    }else{
      AppPopUp.showTost(title: "${data["message"]}" );
    }

    isPasswordSet.value = false;
  }


}