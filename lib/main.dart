import 'package:flutter/material.dart';
import 'package:urgent/loginpage.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    AwesomeNotifications().initialize(
  null,
  [
    NotificationChannel(
        channelKey: 'urgent_channel',
        channelName: 'urgent',
        channelDescription: 'urgent app',
        importance: NotificationImportance.Max,
        // soundSource: 'resource://raw/check',
        playSound: true        
        )
  ],
  debug: true
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
        AwesomeNotifications().isNotificationAllowed().then((value){
      if(!value){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'urgent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginpage(),
    );
  }
}
