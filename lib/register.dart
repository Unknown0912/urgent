import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}
TextEditingController email= TextEditingController();
TextEditingController Password= TextEditingController();
String message="";
class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Welcome",style: TextStyle(color: Colors.black),)
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
            child: TextField(controller: email,decoration: InputDecoration(hintText:"Username"))),
            Container(
              child: TextField(controller: Password,obscureText: true,decoration: InputDecoration(hintText: "Password")),
            ),
            TextButton(onPressed:() async {
               setState(() {
                    message = "";
                  });
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text, password: Password.text);
                    Navigator.pop(context);
                  } catch (e) {
                    print(e);
                    setState(() {
                      message = e.toString();
                    });
                  }
                  },child: Text("Register")),
                  Text(message)            
          ])
          ),
        ),
      );
  }
}