import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/view/home.dart';
import 'package:untitled/view/login.dart';

import '../utilits.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getCurrentLocation()async{
    Future<Position> data = _determinePosition();
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    data.then((value) => setState((){
      print("value $value");
      _prfs.setDouble("lat", value.latitude);
      _prfs.setDouble("long", value.longitude);

      if(_prfs.getString("isLogin") == "1"){
        Get.to(Home(), transition: Transition.rightToLeft);
      }else{
        Get.to(Login(), transition: Transition.rightToLeft);
      }
    }));
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 30, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/flash_bg.png",),

              SizedBox(height: 100,),

              RichText(
                text: TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w300,
                    color: AppUtilits.black
                  ),
                  children: const <TextSpan>[
                    TextSpan(text: 'iYYi',
                        style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          color: AppUtilits.gold,
                        ),
                    ),
                  ],
                ),
              ),
              Text("Geting your current location...",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
              SizedBox(height: 30,),
              SpinKitThreeInOut(
                color: AppUtilits.gold,
                size: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
