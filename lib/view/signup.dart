import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/auth_controller.dart';
import 'package:untitled/view/home.dart';
import 'package:untitled/view/login.dart';

import '../app_config.dart';
import '../utilits.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthController controller = Get.put(AuthController());
  final _signUpKey = GlobalKey<FormState>();

  late bool password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
          child: Column(
            children: [
              Image.asset("assets/images/logo.jpg", height: 150, width: 200, fit: BoxFit.cover,),

              SizedBox(height: 20,),
              Form(
                key: _signUpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: controller.name,
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
                      controller: controller.phone,
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
                      controller: controller.email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                          ),
                          prefixIcon: Icon(Icons.email_outlined)
                      ),
                    ),

                    SizedBox(height: 30,),

                    Text("Password",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      obscureText: password,
                      controller: controller.pass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                          ),
                          prefixIcon: Icon(Icons.key),
                          suffixIcon: IconButton(
                            onPressed: ()=>setState(() {
                              password = !password;
                            }),
                            icon: Icon(password ? Icons.visibility : Icons.visibility_off),
                          )
                      ),
                    )

                  ],
                ),
              ),

              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  if(_signUpKey.currentState!.validate()){
                    controller.signUp();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 60, right: 60),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppUtilits.gold
                  ),
                  child: Obx(()=>Center(
                      child:  controller.isLoading.value ? SpinKitThreeInOut(
                        color: AppUtilits.white,
                        size: 40.0,
                      ):Text("Sign Up",
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: AppUtilits.white),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: ()=>Get.to(Login(), transition: Transition.rightToLeft),
                  child: Text("I already have an account. Login"),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
