import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/home.dart';
import '../view/login.dart';

class GetuserLocationController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
  }

  var isDataSet = false.obs;

  void isdataSetMethod(value){
    isDataSet.value = value;
    update();
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

  void getCurrentLocation()async{
    isdataSetMethod(true);
    Future<Position> data = _determinePosition();
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    data.then((value) {
      print("value $value");
      _prfs.setDouble("lat", value.latitude);
      _prfs.setDouble("long", value.longitude);

      if (_prfs.getString("isLogin") == "1") {
        Get.to(Home(), transition: Transition.rightToLeft);
      } else {
        Get.to(Login(), transition: Transition.rightToLeft);
      }
    });
    isdataSetMethod(false);
  }



}