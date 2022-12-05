import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app_config.dart';

class BlockController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    blockList();
  }

  var isLoading = false.obs;
  void loading(value){
    isLoading.value = value;
    update();
  }

  void block(id, BuildContext context)async{
    loading(true);
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    var token = _prfs.getString("token");
      var res = await http.post(Uri.parse(AppConfig.BLOCK_USER),
        body: {
          "userId" : id.toString(),
        },
        headers: {
          "Authorization" : "Bearer $token"
        }
      );
      print(res.statusCode);
      print(res.body);
      if(res.statusCode == 200){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Successfully blocked."),
          duration: Duration(milliseconds: 3000),
        ));
        Navigator.pop(context);
      }else{
        print("Soemthing is worng");
      }

    loading(false);
  }


  var blockListModel;
  void blockList()async{
    loading(true);
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    var token = _prfs.getString("token");
    var res = await http.get(Uri.parse(AppConfig.BLOCK_USER_LIST),
      headers: {
        "Authorization" : "Bearer $token"
      }
    );
    if(res.statusCode == 200){
      blockListModel = jsonDecode(res.body)["data"];
      print("blockListModel $blockListModel");
    }else{
      print(res.statusCode);
    }
    loading(false);
  }
  
  
  void unblock(BuildContext context, id)async{
    loading(true);
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    var token = _prfs.getString("token");
    var res = await http.get(Uri.parse(AppConfig.UNBLOCK_USER+id),
      headers: {
        "Athurization" : "Bearer $token",
      }
    );
    print(res.body);
    print(res.body);
    if(res.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Successfully Unblock."),
        duration: Duration(milliseconds: 3000),
      ));
      Navigator.pop(context);
    }else{

    }
    loading(false);
  }



}