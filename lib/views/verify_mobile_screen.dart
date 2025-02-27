import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'success_screen.dart';
import 'signin_screen.dart';

class VerifyMobileScreen extends StatelessWidget {
  final phoneController = TextEditingController();

  VerifyMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'verifyMobile'.tr(),
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFF003366),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
          left: 16.0,
          right: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'verifyYourMobile'.tr(),
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'verificationMessage'.tr(),
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
                  hintText: 'enterNumber'.tr(),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                  ),
                  labelText: 'mobileNumber'.tr(),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("enterMobileNumber".tr()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(phoneController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("invalidMobileNumber".tr()),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
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

                    await Future.delayed(Duration(seconds: 2));
                    Navigator.of(context).pop();

                    showGeneralDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: Duration(milliseconds: 300),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SuccessScreen(
                          onSuccess: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SigninScreen()),
                            );
                          },
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'verify'.tr(),
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
