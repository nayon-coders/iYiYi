import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{

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


  void login()async{
    SharedPreferences _prfs = await SharedPreferences.getInstance();


    print(email.text);


  }

}