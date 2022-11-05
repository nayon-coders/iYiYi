import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:untitled/utilits.dart';import '../app_config.dart';
import '../controller/profile_controller.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  ProfileController controller = Get.put(ProfileController());

  final _editKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController fb;
  late TextEditingController inst;
  late TextEditingController tw;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController(text: controller.profileModel?.user?.name);
    email = TextEditingController(text: controller.profileModel?.user?.email);
    phone = TextEditingController(text: controller.profileModel?.user?.phone);
    fb = TextEditingController(text: controller.profileModel?.user?.facebook);
    inst = TextEditingController(text: controller.profileModel?.user?.instagram);
    tw = TextEditingController(text: controller.profileModel?.user?.twitter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   width: 120,
            //   child: ClipRRect(
            //     child: controller.profileModel?.user?.image == null ?
            //     Image.network("https://www.pngkey.com/png/full/52-523516_empty-profile-picture-circle.png", height: 120, width: 120, fit: BoxFit.cover,)
            //         :Image.network("${AppConfig.domain_name}/${controller.profileModel?.user?.image}", height: 150, width: 150, fit: BoxFit.cover,),
            //   ),
            // ),

            Form(
              key: _editKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(

                    controller: name,
                    decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                        ),
                        prefixIcon: Icon(Icons.person_outline)
                    ),
                  ),

                  SizedBox(height: 30,),
                  Text("Phone Number",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                        hintText: "Number",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                        ),
                        prefixIcon: Icon(Icons.phone_android)
                    ),
                  ),

                  SizedBox(height: 30,),

                  Text("Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                        ),
                        prefixIcon: Icon(Icons.email_outlined)
                    ),
                  ),
                  SizedBox(height: 30,),
                  Divider(height: 1,),
                  SizedBox(height: 30,),
                  Text("Facebook",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: fb,
                    decoration: InputDecoration(
                        hintText: "https://www.facebook.com/nayon.talukder.581",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                        ),
                        prefixIcon: Icon(Icons.facebook)
                    ),
                  ),
                  SizedBox(height: 30,),
                  const Text("Instagram",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: tw,
                    decoration: InputDecoration(
                        hintText: "nayon.talukder.581",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.instagram)
                    ),
                  ),
                  SizedBox(height: 30,),
                  const Text("Twitter",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: inst,
                    decoration: InputDecoration(
                        hintText: "nayon_talukder5",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.twitter)
                    ),
                  ),

                  SizedBox(height: 40,),

                  InkWell(
                    onTap: (){
                      if(_editKey.currentState!.validate()){
                        controller.updateProfile(
                          name: name.text,
                          email: email.text,
                          phone: phone.text,
                          tw: tw.text,
                          fb: fb.text,
                          insta: inst.text,
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 60, right: 60),
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppUtilits.gold
                      ),
                      child: Center(
                        child: controller.isLoading.value ? SpinKitThreeInOut(
                          color: AppUtilits.white,
                          size: 40.0,
                        ):Text("Change Profile",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: AppUtilits.white),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }






}
