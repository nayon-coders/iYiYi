import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/location_controller.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/controller/userlist_controller.dart';
import 'package:untitled/utilits.dart';
import 'package:untitled/view/map_list.dart';
import 'package:untitled/view/profile.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/view/single_user.dart';
import '../widgets/app_drawer.dart';
import 'map.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController.setLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.APP_NAME.toString(),
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
          size: 40,//change size on your need
          color: AppUtilits.gold,//change color on your need
        ),
      ),
      drawer: AppDrawer(),

      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("List Of Users",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.refresh),
                )
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: GetBuilder<UserListController>(
                init: UserListController(),
                builder: (controller) {
                  if(controller.isLoading.value){
                    return  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (_, index){
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade200,
                          highlightColor: Colors.white,
                          child: ListTile(
                            title: Container(width: 200, height: 40, color: Colors.white,),
                            subtitle:Container(width: 200, height: 30, color: Colors.white,),
                            leading: Container(width: 60, height: 60, decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(100)),),
                            trailing:  Container(width: 20, height: 20, decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(100)),),
                          ),
                        );
                      },
                    );
                  }else {
                    return ListView.builder(
                      itemCount: controller.userListModel?.data?.length,
                      itemBuilder: (_, index) {
                        var data = controller.userListModel?.data?[index];
                        print(data);
                        return ListTile(
                          title: Text("${data?.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text("Online"),
                              SizedBox(width: 5,),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.green
                                ),
                              )
                            ],
                          ),
                          leading: InkWell(
                              onTap: (){
                                print(data?.name);
                                print(data?.image);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>SingleUser(id: "${data?.id}",
                                    )));
                              },
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: data?.image== null
                                  ? Image.network(
                                  "https://www.pngkey.com/png/full/52-523516_empty-profile-picture-circle.png")
                                  : Image.network("${AppConfig
                                  .domain_name}/${data?.image}",
                                height: 60, width: 60, fit: BoxFit.cover,),
                            ),
                          ),
                          trailing: InkWell( 
                              onTap: ()=>Get.to(MapScreen(lat: double.parse("${data?.location?.latitude}"), long:  double.parse("${data?.location?.longitude}"),id: "${data?.id}", name: "${data?.name}",)),
                              child: Icon(Icons.location_on_outlined)),
                        );
                      },
                    );
                  }
                }
              ),
            ),

          ],
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppUtilits.gold,
        onPressed: () => Get.to(UserMapList()),
        tooltip: 'MAP',
        child: Icon(Icons.location_on_outlined),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 7, bottom: 7),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 35,
                  color: AppUtilits.gold,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.group,
                  size: 35,
                ),
                onPressed: () =>Get.to(Profile(), transition: Transition.rightToLeft),
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
      ),
    );
  }


}
