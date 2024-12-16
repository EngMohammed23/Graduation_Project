import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyMobileScreen extends StatelessWidget {
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Mobile',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF003366),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // النص يبدأ من اليسار
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF003366), width: 1.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/palestine_flag.png', // صورة العلم
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '+970',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.grey.withOpacity(0.5), // الخط الفاصل
                  ),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number, // الأرقام فقط
                      decoration: InputDecoration(
                        hintText: 'Enter your number',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        border: InputBorder.none, // إزالة الإطار الداخلي
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (phoneController.text.isNotEmpty) {
                  Get.snackbar('Success', 'Verification code sent!',
                      snackPosition: SnackPosition.BOTTOM);
                } else {
                  Get.snackbar('Error', 'Please enter your mobile number!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                }
              },
              child: Text(
                'Continue',
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
    );
  }
}
