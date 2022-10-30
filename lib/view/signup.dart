import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_config.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

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
              Image.asset("assets/images/logo.jpg"),

              SizedBox(height: 40,),

              Form(
                key: _signUpKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    Text("Password",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      obscureText: password,
                      controller: pass,
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
                onTap: (){},
                child: Container(
                  margin: EdgeInsets.only(left: 60, right: 60),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppConfig.gold
                  ),
                  child: Center(
                    child: Text("Login",
                      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400, color: AppConfig.white),
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
}
