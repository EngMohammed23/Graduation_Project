import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SuccessScreen extends StatelessWidget {
  final VoidCallback onSuccess;

  const SuccessScreen({super.key, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // إغلاق الشاشة بعد ثانيتين
      Future.microtask(onSuccess); // تنفيذ الإجراء بعد الإغلاق مباشرة
    });

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: MediaQuery.of(context).size.width * 0.2,
              color: Color(0xFF003366),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'success'.tr(),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.09,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// class SuccessScreen extends StatelessWidget {
//   final VoidCallback onSuccess;
//
//   const SuccessScreen({super.key, required this.onSuccess});
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.of(context).pop(); // إغلاق الشاشة بعد ثانيتين
//       onSuccess(); // تنفيذ الإجراء المطلوب
//     });
//
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       margin: EdgeInsets.only(
//           top:
//               MediaQuery.of(context).size.height * 0.1), // نسبة 10% من الارتفاع
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width *
//                 0.4, // نسبة 40% من عرض الشاشة
//             height: MediaQuery.of(context).size.width * 0.4,
//             decoration: BoxDecoration(
//               color: Colors.blue.shade100,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.check,
//               size: MediaQuery.of(context).size.width *
//                   0.2, // نسبة 20% من عرض الشاشة
//               color: Color(0xFF003366),
//             ),
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.height *
//                   0.02), // نسبة 2% من ارتفاع الشاشة
//           Text(
//             'Success!',
//             style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.width *
//                     0.09, // نسبة 9% من عرض الشاشة
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Poppins',
//                 color: Colors.black,
//                 decoration: TextDecoration.none),
//           ),
//         ],
//       ),
//     );
//   }
// }
