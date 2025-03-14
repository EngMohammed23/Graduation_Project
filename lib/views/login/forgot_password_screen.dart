import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Color(0xFF003366)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'forgotPassword'.tr(),
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'enterEmailToReset'.tr(),
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: "enterYourEmail".tr(),
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
                labelText: 'email'.tr(),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366),
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  print("Reset email sent to: ${emailController.text}");
                },
                child: Text(
                  'continue'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

