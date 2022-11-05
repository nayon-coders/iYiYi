import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app_config.dart';

class LocationController extends GetxController{

  void setLocation()async{
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    var lat = _prfs.getDouble("lat");
    var long = _prfs.getDouble("long");
    var token = _prfs.getString("token");

    print(lat);
    print(long);
    print(token);

    var response = await http.post(Uri.parse(AppConfig.MAP_STORE),
      body: {
        "latitude" : "${lat.toString()}",
        "longitude" : "${long.toString()}",
        "location" : "44",
      },
      headers: {
      "Accept" : "application/json",
        "Authorization" : "Bearer $token"
      }
    );
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      print("Location is set");
    }else{
      print("Location is not set");
    }
  }


}