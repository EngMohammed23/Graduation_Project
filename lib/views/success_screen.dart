import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final VoidCallback onSuccess;

  SuccessScreen({required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    // استخدام Future.delayed لإغلاق الشاشة بعد 2 ثانية
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // إغلاق الشاشة
      onSuccess(); // تنفيذ ما بعد الإغلاق
    });

    return Scaffold(
      // شاشة بحجم كامل
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                size: 80,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Success!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
