import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String description;
  final String contractor;

  const HomeCard({
    super.key,
    required this.title,
    required this.description,
    required this.contractor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(description),
          SizedBox(height: 8.0),
          Text('${'contractor'.tr()}: $contractor'),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              // Navigate to project details page
            },
            child: Text('viewProject'.tr()),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class HomeCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String contractor;
//
//   const HomeCard({super.key,
//     required this.title,
//     required this.description,
//     required this.contractor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Text(description),
//           SizedBox(height: 8.0),
//           Text('Contractor: $contractor'),
//           SizedBox(height: 8.0),
//           ElevatedButton(
//             onPressed: () {
//               // Navigate to project details page
//             },
//             child: Text('View Project'),
//           ),
//         ],
//       ),
//     );
//   }
// }