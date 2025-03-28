import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  bool isPasswordHidden = true;
  bool isRepeatPasswordHidden = true;

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
              'createNewPassword'.tr(),
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'chooseStrongPassword'.tr(),
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: passwordController,
              obscureText: isPasswordHidden,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: "enterPassword".tr(),
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
                labelText: 'password'.tr(),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: repeatPasswordController,
              obscureText: isRepeatPasswordHidden,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: "repeatPassword".tr(),
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
                labelText: 'repeatPasswordLabel'.tr(),
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isRepeatPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  onPressed: () {
                    setState(() {
                      isRepeatPasswordHidden = !isRepeatPasswordHidden;
                    });
                  },
                ),
              ),
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
                  if (passwordController.text == repeatPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("passwordUpdated".tr()),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("passwordMismatch".tr()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'verifyNewPassword'.tr(),
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

