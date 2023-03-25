import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:urgent/card.dart';
class HomePage extends StatefulWidget {
  String? email;
  HomePage({super.key,this.email});

  @override
  State<HomePage> createState() => _HomePageState(email);
}
class _HomePageState extends State<HomePage> {
  final ref=FirebaseFirestore.instance.collection('message');
  String? email;
  int id=0;
  _sendmessage(context)async{
    TextEditingController mes=TextEditingController();
    TextEditingController rec=TextEditingController();
    var message=await showDialog(context: context,builder:(BuildContext context){
    return AlertDialog(content: TextField(controller: mes,decoration: InputDecoration(hintText:"message"),),actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text("save"))],);
    });
    var reciever=await showDialog(context: context,builder:(BuildContext context){
    return AlertDialog(content: TextField(controller: rec,decoration: InputDecoration(hintText:"reciever email"),),actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text("save"))],);
    });
    if(id>2){
      id=0;
    }
    ref.add({
      'message':mes.text,
      'sender' :email,
      'reciever':rec.text,
      'id':id
    });
  }
  _noti(String a){
    AwesomeNotifications().createNotification(content: NotificationContent(
      id:10,
      channelKey: 'urgent_channel',
      title: 'urgent Notification',
      body: a,
      criticalAlert: true,
    ),
    );
  }
  @override
  _HomePageState(this.email);
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("It's Urgent")),
        body: Column(children: [
          Expanded(child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map<Widget>((Notification) {
                  if(Notification.get('reciever')==email){
                    _noti(Notification.get('message'));
                    return Container(
                      color: card().l[id],
                      child: Text(Notification.get('message')));
                  }
                  return SizedBox.shrink();
                } ).toList(),
              );
            },
          )),
          TextButton(onPressed: (){
            _sendmessage(context);
          }, child: Text("NEW NOTIFICATION"))
        ],)
      ),
    );
  }
}