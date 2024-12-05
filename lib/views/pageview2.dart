import 'package:flutter/material.dart';

// class Pageview2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 350,
//             height: 450,
//             margin: EdgeInsets.only(top: 20),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/two.jpg'),
//                 fit: BoxFit.cover,
//               ),
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.all(Radius.circular(15.0)),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 40),
//             child: Text("Connect with certified contractors"),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Add your functionality here
//                   print("Button 1 clicked!");
//                 },
//                 child: Text("Button 1"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add your functionality here
//                   print("Button 2 clicked!");
//                 },
//                 child: Text("Button 2"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class Pageview2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            alignment: Alignment.centerRight,
          ),
          Container(
            width: 350,
            height: 450,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/two.jpg',
                    ),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
          Container(
              margin: EdgeInsets.only(top: 40),
              child: Text("Connect with certified contractors"))
        ],
      ),
    );
  }
}
