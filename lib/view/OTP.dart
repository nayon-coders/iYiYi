import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/forgetPassword_controller.dart';
import 'package:untitled/view/signup.dart';

import '../controller/profile_controller.dart';
import '../utilits.dart';

class OTP extends StatefulWidget {
  final String eamil;
  const OTP({Key? key, required this.eamil}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  ForgetPassController controller = Get.put(ForgetPassController());

  final otp = TextEditingController();


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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("OTP",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: otp,
              decoration: InputDecoration(
                hintText: "OTP",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey.shade100)
                ),

              ),
              validator: (val){
                if(val!.isEmpty){
                  return "OTP must not be empty";
                }
                return null;
              },
            ),

            SizedBox(height: 20,),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                controller.otpVerify(widget.eamil, otp.text);
              },
              child: Container(
                margin: EdgeInsets.only(left: 60, right: 60),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppUtilits.gold
                ),
                child: Obx(()=> Center(
                  child: controller.isOTPSend.value? const SpinKitThreeInOut(
                    color: AppUtilits.white,
                    size: 40.0,
                  ):const Text("Verify",
                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: AppUtilits.white),
                  ),
                ),),
              ),
            ),
           const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}




