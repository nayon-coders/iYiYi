import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/controller/singleuser_controller.dart';
import 'package:untitled/controller/userlist_controller.dart';
import 'package:untitled/utilits.dart';
import 'dart:ui' as ui;

import 'package:untitled/view/single_user.dart';
class UserMapList extends StatefulWidget {

  const UserMapList({Key? key, }) : super(key: key);

  @override
  State<UserMapList> createState() => _UserMapListState();
}

class _UserMapListState extends State<UserMapList> {
  Completer<GoogleMapController> _controller = Completer();
  UserListController userListController = Get.put(UserListController());
  SingleUserController singleUserController = Get.put(SingleUserController());


  Future<Uint8List> getMarkeeIcon(String path, int width)async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData())!.buffer.asUint8List();
  }
  List<Marker> list = <Marker> [];
  List<Marker> marker = <Marker> [];
  var userId, lat, long;
  getUserid()async{
    SharedPreferences _prfs = await SharedPreferences.getInstance();
    userId = _prfs.getString("user_id");
    lat = _prfs.getDouble("lat");
    long = _prfs.getDouble("long");
    print("user id is = $userId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    getUserid();
  }

  Future load()async{
    print("object");
    final Uint8List markerIcon = await getMarkeeIcon("assets/images/flash_bg.png", 100);

    print("markerIcon $markerIcon");
    for(var i = 0 ; i < int.parse("${userListController.userListModel?.data?.length}"); i ++) {
      print("Mark id ${userListController.userListModel?.data?.length}");
      print("Mark id ${userListController.userListModel?.data?[i]?.name}");


      if (userListController.userListModel?.data?[i]?.location?.latitude !=
          null) {

        list.add(
          Marker(
              markerId: MarkerId("Mark id ${i}"),
              position: userListController.userListModel?.data?[i]?.location
                  ?.latitude != null ? LatLng(double.parse(
                  "${userListController.userListModel?.data?[i]?.location
                      ?.latitude}"),
                  double.parse(
                      "${userListController.userListModel?.data?[i]?.location
                          ?.longitude}")):LatLng(12.0, 10.0),


              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                  title: "${userListController.userListModel?.data?[i]?.name}",
                  snippet: "See Profile",
                  onTap: () =>
                      Get.to(SingleUser(
                          id: "${userListController.userListModel?.data?[i]
                              ?.id}"))
              )
          ),
        );
        setState(() {

        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Map",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color:AppUtilits.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          size: 30,//change size on your need
          color: Colors.black45,//change color on your need
        ),
      ),
      body: lat != null ? GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat!, long!),
          zoom: 17.4746,
        ),


        zoomGesturesEnabled: false,
        scrollGesturesEnabled: false,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: false,
        zoomControlsEnabled: false,
        circles: {
          Circle(
            circleId: CircleId("1"),
            radius: 150,
            center:  LatLng(lat!, long!),
            strokeColor: Colors.red,
            strokeWidth: 2, 
            fillColor: AppUtilits.gold.withOpacity(0.2)
          )
        },
        markers: Set<Marker>.of(list),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getBytesFromAsset({required String path, required int width}) {}
}
