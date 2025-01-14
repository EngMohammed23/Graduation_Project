import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications_Screen extends StatefulWidget {
  const Notifications_Screen({super.key});

  @override
  State<Notifications_Screen> createState() => _Notifications_ScreenState();
}

class _Notifications_ScreenState extends State<Notifications_Screen> {
  bool isSwitched = false;
  bool isSwitched1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsetsDirectional.all(0),
              title: Text('Push Notifications',style: GoogleFonts.poppins(fontSize: 15),),
              subtitle: Text('I would not miss it for the world. But if something else came up I would definitely not go.',style: GoogleFonts.poppins(fontSize: 12,color: Colors.grey),),
              trailing:   Switch(
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value; // تغيير حالة السويتش
                  });
                },
              ),
            ),
            SizedBox(height: 30,),
            ListTile(
              contentPadding: EdgeInsetsDirectional.all(0),
              title: Text('Push Notifications',style: GoogleFonts.poppins(fontSize: 15),),
              subtitle: Text('I would not miss it for the world. But if something else came up I would definitely not go.',style: GoogleFonts.poppins(fontSize: 12,color: Colors.grey),),
              trailing:   Switch(
                value: isSwitched1,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched1 = value; // تغيير حالة السويتش
                  });
                },
              ),
            ),
            SizedBox(height: 50,),
            Text('Email',style: GoogleFonts.poppins(fontSize: 15),),
            SizedBox(height: 5,),
            Text('michael@dundermifflin.com',style: GoogleFonts.poppins(fontSize: 12,color: Colors.grey),),
            SizedBox(height: 10,),
            MaterialButton (
                height: 31,
                minWidth: 109,
                color: Color(0XFF003366),
                textColor: Colors.white,
                child: Text('Change'),
                onPressed: () {

                }),
            SizedBox(height: 20,),
            Text('Password',style: GoogleFonts.poppins(fontSize: 15),),
            SizedBox(height: 5,),
            Text('Click below to change your password. ',style: GoogleFonts.poppins(fontSize: 12,color: Colors.grey),),
            SizedBox(height: 10,),
            MaterialButton (
                height: 31,
                minWidth: 109,
                color: Color(0XFF003366),
                textColor: Colors.white,
                child: Text('Change'),
                onPressed: () {

                },)


          ],
        ),
      ),
    );
  }
}
