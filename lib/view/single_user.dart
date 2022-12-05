import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/block_controller.dart';
import 'package:untitled/controller/profile_controller.dart';
import 'package:untitled/utilits.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/singleuser_controller.dart';
import '../controller/userlist_controller.dart';

class SingleUser extends StatefulWidget {
  final String? id;

  const SingleUser({Key? key, required this.id}) : super(key: key);

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  SingleUserController controller = Get.put(SingleUserController());
  BlockController blockController = Get.put(BlockController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSingleUserList(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
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
      body: Obx(()=>SingleChildScrollView(
          child: controller.isLoading.value ? Center(child: CircularProgressIndicator()) : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
              ),
                child: ClipRRect(
                  child:controller.userModel?.user?.image == null
                      ?Image.asset("assets/images/profile.jpg"):Image.network("${AppConfig.domain_name}/${controller.userModel?.user?.image}",
                        fit: BoxFit.cover,
                      ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${controller.userModel?.user?.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("${controller.userModel?.user?.email}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 7,),
                    Text("${controller.userModel?.user?.phone}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.grey
                      ),
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
                    controller.userModel?.user?.facebook != null ? buildSocialContact(
                      socialIcon: FontAwesomeIcons.facebook,
                      checked: Icons.check_circle,
                      title: "Facebook",
                      isCheck: controller.userModel?.user?.image != null ? true : false,
                      url: 'https://facebook.com/${controller.userModel?.user?.instagram}',
                    ):Center(),
                    controller.userModel?.user?.instagram != null ? buildSocialContact(
                      socialIcon: FontAwesomeIcons.instagram,
                      checked: Icons.check_circle,
                      title: "Instagram",
                      isCheck: controller.userModel?.user?.instagram != null ? true : false,
                      url: 'https://instagram.com/${controller.userModel?.user?.instagram}',
                    ):Center(),
                    controller.userModel?.user?.twitter!= null ? buildSocialContact(
                      socialIcon: FontAwesomeIcons.twitter,
                      checked: Icons.check_circle,
                      title: "Twitter",
                      isCheck: controller.userModel?.user?.twitter != null ? true : false,
                      url: 'https://twitter.com/${controller.userModel?.user?.twitter}',
                    ):Center(),
                    controller.userModel?.user?.twitter== null && controller.userModel?.user?.facebook== null && controller.userModel?.user?.instagram== null
                        ? Center(
                      child: Text("Social contact not set this profile"),
                    ):Center(),

                    SizedBox(height: 50,),
                    Divider(height: 1, color: Colors.grey,),
                    SizedBox(height: 10,),
                     ListTile(
                      onTap: (){
                        block();
                      },
                      title: Text("Block User"),
                      subtitle: Text("If you block this user, you can not see until you unblock."),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    SizedBox(height: 10,),
                    Divider(height: 1, color: Colors.grey,),
                    SizedBox(height: 10,),
                    ListTile(
                     onTap: ()=>reports(),
                     title: Text("Report User"),
                     subtitle: Text("You can report this user."),
                     trailing: Icon(Icons.arrow_forward_ios),
                   ),
                    SizedBox(height: 10,),
                    Divider(height: 1, color: Colors.grey,),
                    SizedBox(height: 50,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Container buildSocialContact({
    required IconData socialIcon,
    required IconData checked,
    required String title,
    required bool isCheck,
    required String url,
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

          isCheck ? TextButton(
            onPressed: ()async {
              launch(url);
            },
            child: Text("Click",
              style: TextStyle(
                color: Colors.redAccent
              ),
            ),
          ): Text("Not Linked",
            style: TextStyle(color: Colors.redAccent),
          )
        ],
      ),
    );
  }

  block() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure?'),
        content:  Text('You want to block?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: (){
              blockController.block(controller.userModel?.user?.userId, context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }


  reports() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Report User'),
        content: TextFormField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Somethings...",
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: (){
              blockController.block(controller.userModel?.user?.userId, context);
            },
            child: const Text('Reports & Block'),
          ),
        ],
      ),
    );
  }




}

