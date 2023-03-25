import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urgent/homepage.dart';
import 'package:urgent/register.dart';
import 'homepage.dart';
class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}
TextEditingController email= TextEditingController();
TextEditingController Password= TextEditingController();
String message="";
class _loginpageState extends State<loginpage> {
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email.text, password: Password.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => HomePage(email: email.text))));
                  } catch (e) {
                    print(e);
                    setState(() {
                      message = e.toString();
                    });
                  }
                  },child: Text("LOGIN")),
                  InkWell(onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>register()));
                  },child: Text("First time user-Register")),
                  Text(message),            
          ])
          ),
        ),
      );
  }
}