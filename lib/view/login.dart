import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:untitled/app_config.dart';
import 'package:untitled/controller/auth_controller.dart';
import 'package:untitled/view/signup.dart';

import '../utilits.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  AuthController authController = Get.put(AuthController());


  final _loginKey = GlobalKey<FormState>();
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
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              child: Column(
                children: [
                  Image.asset("assets/images/logo.jpg"),

                  SizedBox(height: 40,),

                  Form(
                    key: _loginKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          validator: (val){
                            if(val!.isEmpty){
                              return "Email must not be empty";
                            }else if(!val.contains("@")){
                              return "Invalid email";
                            }
                            return null;
                          },
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
                          validator: (val){
                            if(val!.isEmpty){
                              return "Password must not be empty";
                            }else if(val.length < 6){
                              return "Password more then 6 characters";
                            }
                            return null;
                          },
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 10,),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: (){},
                      child: Text("Forget your password? "),
                    ),
                  ),

                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(_loginKey.currentState!.validate()){
                        controller.login(email: controller.email.text, pass: controller.pass.text);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 60, right: 60),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppUtilits.gold
                      ),
                      child: Center(
                        child: controller.isLoading.value ? SpinKitThreeInOut(
                          color: AppUtilits.white,
                          size: 40.0,
                        ):Text("Login",
                          style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: AppUtilits.white),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: ()=>Get.to(SignUp(), transition: Transition.rightToLeft),
                      child: Text("I don't have account. Sign Up?"),
                    ),
                  ),



                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
