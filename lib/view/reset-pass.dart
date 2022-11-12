import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/forgetPassword_controller.dart';
import 'package:untitled/controller/popup_controller.dart';
import 'package:untitled/view/signup.dart';

import '../controller/profile_controller.dart';
import '../utilits.dart';

class ResetPass extends StatefulWidget {
  final String email;
  const ResetPass({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  ForgetPassController controller = Get.put(ForgetPassController());

  final resetPassKey = GlobalKey<FormState>();

  final pass = TextEditingController();
  final Cpass = TextEditingController();


  late bool password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back),
          color: AppUtilits.black,
        ),
        title: Text("Forget Passowrd",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color:AppUtilits.black
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: resetPassKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text("Reset Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: password,
                controller: pass,
                decoration: InputDecoration(
                    hintText: "New Password",
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
              ),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: password,
                controller: Cpass,
                decoration: InputDecoration(
                    hintText: "Retype Password",
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
                  }else if(val != pass.text){
                    return "Password not match";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  if(resetPassKey.currentState!.validate()){

                    controller.resetPass(pass.text, widget.email);
                  }

                },
                child: Container(
                  margin: EdgeInsets.only(left: 60, right: 60),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppUtilits.gold
                  ),
                  child: Obx(()=> Center(
                    child: controller.isPasswordSet.value ? const SpinKitThreeInOut(
                      color: AppUtilits.white,
                      size: 40.0,
                    ):const Text("Change password",
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: AppUtilits.white),
                    ),
                  ),),
                ),
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}




