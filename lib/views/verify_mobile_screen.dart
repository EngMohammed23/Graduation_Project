import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'success_screen.dart';
import 'signin_screen.dart'; // واجهة تسجيل الدخول

class VerifyMobileScreen extends StatelessWidget {
  final phoneController = TextEditingController();

  VerifyMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Mobile',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.black, // لون النص أسود
          ),
        ),
        backgroundColor: Colors.white, // خلفية AppBar بيضاء
        iconTheme: IconThemeData(
          color: Color(0xFF003366), // لون السهم
        ),
        elevation: 0, // إزالة الظل
      ),
      backgroundColor: Colors.white, // خلفية الشاشة بالكامل بيضاء
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05, // Margin علوي
          left: 16.0,
          right: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify your mobile',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We will send a text to verify your number. No fees will apply.',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your number',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF003366),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () async {
                  if (phoneController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter your mobile number!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else if (!RegExp(r'^[0-9]+$')
                      .hasMatch(phoneController.text)) {
                    Get.snackbar(
                      'Error',
                      'Please enter a valid mobile number!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    // Spinner أثناء معالجة الطلب
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF003366),
                          ),
                        );
                      },
                    );

                    await Future.delayed(
                        Duration(seconds: 2)); // محاكاة التأخير
                    Navigator.of(context).pop(); // إغلاق Spinner
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SuccessScreen(
                          onSuccess: () {
                            // الانتقال إلى شاشة تسجيل الدخول بعد النجاح
                            Get.to(() => SigninScreen());
                          },
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
