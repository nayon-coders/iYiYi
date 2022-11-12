import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/location_controller.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/controller/userlist_controller.dart';
import 'package:untitled/model/ProfileModel.dart';
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
  UserListController userListController = Get.put(UserListController());
  LocationController locationController = Get.put(LocationController());

  bool _isList = false;

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
        automaticallyImplyLeading: false,
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
      

      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("List Of Users",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: ()=>userListController.getUserList(),
                        icon: Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            _isList = !_isList;
                          });
                        },
                        icon: _isList ? Icon(Icons.list) : Icon(Icons.grading),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),

            _isList ? Expanded(
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
                          onTap: (){
                            print(data?.name);
                            print(data?.image);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>SingleUser(id: "${data?.id}",
                                )));
                          },
                          title: Text("${data?.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20
                            ),
                          ),
                          subtitle: Text(
                            "${data?.phone}",
                            textAlign: TextAlign.start,
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
                            onTap: ()=>Get.to(SingleUser(id: data?.id.toString())),
                              // onTap: ()=>Get.to(MapScreen(lat: double.parse("${data?.location?.latitude}"), long:  double.parse("${data?.location?.longitude}"),id: "${data?.id}", name: "${data?.name}",)),
                              child: Icon(Icons.arrow_forward_ios)),
                        );
                      },
                    );
                  }
                }
              ),
            ) : Expanded(
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
                          child: GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemCount: 10,
                            itemBuilder: (_, index) {
                              var data = controller.userListModel?.data?[index];
                              return InkWell(
                                onTap: () =>
                                    Get.to(SingleUser(id: data?.id.toString())),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(color: Colors.black,)
                                ),
                              );
                            },

                          ),
                        );
                      },
                    );
                  }

                  return GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: controller.userListModel?.data?.length,
                    itemBuilder: (_, index) {
                      var data = controller.userListModel?.data?[index];
                      return InkWell(
                        onTap: () =>
                            Get.to(SingleUser(id: data?.id.toString())),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [

                                ClipRRect(
                                  child: data?.image == null
                                      ? Image.asset("assets/images/profile.jpg")
                                      : Image.network(
                                    "${AppConfig.domain_name}/${data?.image}",
                                    height: 200, width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Padding(padding: EdgeInsets.all(10),
                                    child: Container(
                                      child: Text("${data?.name}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppUtilits.gold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                              ],)
                        ),
                      );
                    },

                  );
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
