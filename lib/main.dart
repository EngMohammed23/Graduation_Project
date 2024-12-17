import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final VoidCallback onSuccess;

  SuccessScreen({required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    // إغلاق الواجهة بعد ثانيتين
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // إغلاق الشاشة
      onSuccess(); // تنفيذ الإجراء بعد الإغلاق
    });

    return Container(
      margin: EdgeInsets.only(top: 100), // مسافة من الأعلى لتظهر AppBar
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
    );
  }
}
