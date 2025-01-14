import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});

  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Color(0xFF003366)), // زر الإغلاق
          onPressed: () {
            Navigator.of(context).pop(); // العودة للواجهة السابقة
          },
        ),
        backgroundColor: Colors.white, // خلفية AppBar بيضاء
        elevation: 0,
      ),
      backgroundColor: Colors.white, // خلفية الشاشة بيضاء
      body: Padding(
        padding: const EdgeInsets.only(
            top: 50.0, left: 16.0, right: 16.0), // تحريك كل العناصر لأسفل
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // محاذاة للعناصر إلى اليسار
          children: [
            Text(
              'Enter verification code',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We sent you a verification code via SMS.',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                color: Colors.black.withOpacity(0.4), // شفافية 40%
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 30), // مسافة 30 من الأعلى والأسفل
                    width: 50,
                    height: 50,
                    child: TextField(
                      controller: controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context)
                              .nextFocus(); // الانتقال للحقول التالية تلقائيًا
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50), // مسافة إضافية فوق الزر
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366),
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                // منطق التأكيد هنا
                print(
                    "Verification code entered: ${controllers.map((c) => c.text).join()}");
              },
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text: 'Don’t receive it? ',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Click here',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Color(0xFF003366),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Resend code tapped!");
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
