import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/controller/profile_controller.dart';
import 'package:untitled/utilits.dart';
import 'package:untitled/view/edit_profile.dart';
import 'package:untitled/view/home.dart';
import 'package:untitled/view/login.dart';
import 'package:untitled/view/map_list.dart';
import 'package:untitled/view/profile.dart';
import 'package:http/http.dart' as http;

import '../widgets/app_drawer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController controller = Get.put(ProfileController());

  File? imagePickFile;
  bool _isProfileUpdate = false;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color:AppUtilits.black
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()=>Get.to(ProfileEdit(), transition: Transition.rightToLeft),
            icon: Icon(Icons.edit),
            color: AppUtilits.gold,
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(
          size: 30,//change size on your need
          color: Colors.black45,//change color on your need
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child:    Obx(()=>
        controller.isLoading.value ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
          ],
        ) :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
               children: [
                 Container(
                   width: 120,
                   child: Stack(
                     children: [

                       ClipRRect(
                           child: controller.profileModel?.user?.image == null ?
                           Image.network("https://www.pngkey.com/png/full/52-523516_empty-profile-picture-circle.png", height: 120, width: 120, fit: BoxFit.cover,)
                          :Image.network("${AppConfig.domain_name}/${controller.profileModel?.user?.image}", height: 150, width: 150, fit: BoxFit.cover,),
                       ),
                       Positioned(
                         top: 0,
                         right: 0,
                         child: Container(
                           width: 40,
                           height: 40,
                           padding: EdgeInsets.all(3),
                           decoration: BoxDecoration(
                             color: Colors.black45,
                             borderRadius: BorderRadius.circular(100)
                           ),
                           child: IconButton(
                             onPressed: ()=>showBottomShit(),
                             icon: Icon(Icons.edit),
                             color: AppUtilits.gold,
                             iconSize: 20,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(width: 20,),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("${controller.profileModel?.user?.name}",
                       style: TextStyle(
                         fontSize: 25,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     SizedBox(height: 12,),
                     Text("${controller.profileModel?.user?.email}",
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                     SizedBox(height: 8,),
                     Text("${controller.profileModel?.user?.phone}",
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 )
               ],
             ),
            SizedBox(height: 30,),
            Divider(height: 1,),
            SizedBox(height: 30,),
            Text("Social Contact",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
            SizedBox(height: 20,),
            
            buildSocialContact(
              socialIcon: FontAwesomeIcons.facebook,
              checked: Icons.check_circle,
              title: "Facebook",
              isCheck: controller.profileModel?.user?.facebook != null ? true : false,
            ),
            buildSocialContact(
              socialIcon: FontAwesomeIcons.instagram,
              checked: Icons.check_circle,
              title: "Instagram",
              isCheck:  controller.profileModel?.user?.instagram != null ? true : false,
            ),
            buildSocialContact(
              socialIcon: FontAwesomeIcons.twitter,
              checked: Icons.check_circle,
              title: "Twitter",
              isCheck:  controller.profileModel?.user?.twitter != null ? true : false,
            ),

            SizedBox(height: 30,),
            TextButton(
              onPressed: ()=>Get.to(Login()),
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10,),
                  Text("Logout"),
                ],
              ),
            )
            
          ],
        ),
      ),
      ),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppUtilits.gold,
        onPressed: () =>Get.to(UserMapList()),
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
                  size: 30,
                ),
                onPressed: () =>Get.to(Home(), transition: Transition.leftToRight),
              ),
              IconButton(
                icon: Icon(
                  Icons.group,
                  size: 35,
                  color: AppUtilits.gold,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
      ),
    );
  }

  Container buildSocialContact({
  required IconData socialIcon,
    required IconData checked,
    required String title,
    required bool isCheck,
}) {
    return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: AppUtilits.gold)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                 children: [
                   Icon(
                     socialIcon,
                   ),
                   SizedBox(width: 10,),
                   Text("$title",
                     style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.w600
                     ),
                   )
                 ],
               ),

                isCheck ? Icon(
                  checked,
                  color: Colors.green,
                ) : Text("Not Linked",
                  style: TextStyle(color: Colors.redAccent),
                )
              ],
            ),
          );
  }
  showBottomShit()async{
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('From Gallery'),
                  onTap: () =>_changeProfilePic(ImageSource.gallery),
              ),
              ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('From Camera'),
                  onTap: () =>controller.ImagePic(ImagePicker().pickImage(source: ImageSource.camera))
              ),

            ],
          );
        });
  }

  //TODO: CHANGE PROFILE PICTURE METHOD
  Future<void> _changeProfilePic(ImageSource imageType) async {
    setState(() {
      _isProfileUpdate = true;
      Navigator.pop(context);
    });
    try {
      final XFile? pickPhoto = await _picker.pickImage(source: imageType);
      if (pickPhoto == null) return;

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      //Store Data
      var token = localStorage.getString('token');

      String url = AppConfig.UPDATE_PROFILE;
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath(
            'image', pickPhoto.path.toString()));
      var response = await request.send();
      print("status code === ${response.statusCode}");
      print("status code === ${response.request}");
      print("status code === ${response.headers}");
      if (response.statusCode == 200) {
        setState(() {
          _isProfileUpdate = false;
        });
        AppPopUp.showTost(title: "Profile Picture uploaded");
        Get.offAll(Profile());
      } else {
        print(response.statusCode);
        AppPopUp.showTost(title: "Something went wearing. Try again.");
      }
      setState(() {
        imagePickFile = File(pickPhoto.path);
        _isProfileUpdate = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      _isProfileUpdate = false;
    });

  }


}
