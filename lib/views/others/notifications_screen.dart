import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isSwitched = false;
  bool isSwitched1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('notifications'.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'pushNotifications'.tr(),
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              subtitle: Text(
                'pushNotificationsDesc'.tr(),
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
              trailing: Switch(
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'emailNotifications'.tr(),
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              subtitle: Text(
                'emailNotificationsDesc'.tr(),
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
              ),
              trailing: Switch(
                value: isSwitched1,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched1 = value;
                  });
                },
              ),
            ),
            SizedBox(height: 50),
            Text(
              'email'.tr(),
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(
              'emailAddress'.tr(),
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            MaterialButton(
              height: 31,
              minWidth: 109,
              color: Color(0XFF003366),
              textColor: Colors.white,
              child: Text('change'.tr()),
              onPressed: () {},
            ),
            SizedBox(height: 20),
            Text(
              'password'.tr(),
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(
              'changePasswordDesc'.tr(),
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            MaterialButton(
              height: 31,
              minWidth: 109,
              color: Color(0XFF003366),
              textColor: Colors.white,
              child: Text('change'.tr()),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
