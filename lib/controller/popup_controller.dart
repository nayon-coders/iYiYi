import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppPopUp{

  static Future<bool?> showTost({required String title, }){
      return Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor:Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

  }

static Future showPopUp({required String text, required String image}){
  return Get.defaultDialog(
    title: "",
    contentPadding: EdgeInsets.all(20),
    content: Column(
      children: [
        Lottie.asset("$image",
          reverse: true,
          repeat: true,
          width: 70,
          height: 70,
        ),
        SizedBox(height: 10,),
        Center(
          child: Text("$text",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    )
  );
}

}
