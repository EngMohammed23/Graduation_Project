import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Color(0xFF003366)), // أيقونة الإغلاق
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الشاشة
          },
        ),
        backgroundColor: Colors.white, // خلفية AppBar بيضاء
        elevation: 0, // إزالة الظل
      ),
      backgroundColor: Colors.white, // خلفية الشاشة بيضاء
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // محاذاة النصوص إلى اليسار
          children: [
            SizedBox(height: 50), // لإزاحة العناصر لأسفل قليلاً
            Text(
              'Forget Password?',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left, // محاذاة النص لليسار
            ),
            SizedBox(height: 10),
            Text(
              'Enter your email below and we will send you a reset email.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: Colors.black.withOpacity(0.4), // شفافية 40%
              ),
              textAlign: TextAlign.left, // محاذاة النص لليسار
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              textAlign: TextAlign.left, // محاذاة الإدخال لليسار
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  fontSize: 13,
                  fontFamily: 'Poppins',
                ),
                labelText: 'Email',
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
                  // منطق إرسال البريد الإلكتروني هنا
                  print("Reset email sent to: ${emailController.text}");
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
            ),
          ],
        ),
      ),
    );
  }
}
