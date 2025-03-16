import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takatuf/views/others/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: Text('profile'.tr(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        elevation: 5,
        backgroundColor: const Color(0XFF003366),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/setting_screen');
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching profile data'));
          }

          userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};

          return ListView(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0XFF003366),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    ClipOval(
                      child: Image.asset(
                        "assets/images/three.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userData["fullName"] ?? "غير متوفر",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text('email'.tr(), style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 3),
                    Text(userData["email"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    Text('phoneNumber'.tr(), style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 3),
                    Text(userData["phoneNumber"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    Text('userType'.tr(), style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 3),
                    Text(userData["userType"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 180,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.all(30),
                    width: 50,
                    height: 50,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:  Color(0XFF003366),
                    ),
                    child: IconButton(
                        onPressed: () async {
                          final updatedUserData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UpdateProfileScreen(
                                userId: widget.userId,
                                name: userData['fullName'] ?? '',
                                email: userData['email'] ?? '',
                                phone: userData['phoneNumber'] ?? '',
                              ),
                            ),
                          );
                          if (updatedUserData != null) {
                            setState(() {
                              userData = updatedUserData;
                            });
                          }
                        },
                        icon: Icon(Icons.edit, size: 30, color: Colors.white,)
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:takatuf/views/others/update_profile_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final String userId;
//
//   const ProfileScreen({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   late Map<String, dynamic> userData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const SizedBox.shrink(),
//         title: Text('profile'.tr(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
//         centerTitle: true,
//         elevation: 5,
//         backgroundColor: const Color(0XFF003366),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, '/setting_screen');
//             },
//             icon: const Icon(Icons.settings, color: Colors.white),
//           ),
//         ],
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error fetching profile data'));
//           }
//
//           userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
//
//           return ListView(
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Color(0XFF003366),
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 16),
//                     ClipOval(
//                       child: Image.asset(
//                         "assets/images/three.jpg",
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       userData["fullName"] ?? "غير متوفر",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 5),
//                     Text('email'.tr(), style: const TextStyle(fontSize: 20)),
//                     const SizedBox(height: 3),
//                     Text(userData["email"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
//                     const SizedBox(height: 15),
//                     Text('phoneNumber'.tr(), style: const TextStyle(fontSize: 20)),
//                     const SizedBox(height: 3),
//                     Text(userData["phoneNumber"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
//                     const SizedBox(height: 15),
//                     Text('userType'.tr(), style: const TextStyle(fontSize: 20)),
//                     const SizedBox(height: 3),
//                     Text(userData["userType"] ?? "غير متوفر", style: const TextStyle(fontSize: 20)),
//                     SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 180,),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Container(
//                     margin: EdgeInsetsDirectional.all(30),
//                     width: 50,
//                     height: 50,
//                     decoration:  BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color:  Color(0XFF003366),
//                     ),
//                     child: IconButton(
//                         onPressed: () async {
//                           final updatedUserData = await Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => UpdateProfileScreen(
//                                 userId: widget.userId,
//                                 name: userData['fullName'] ?? '',
//                                 email: userData['email'] ?? '',
//                                 phone: userData['phoneNumber'] ?? '',
//                               ),
//                             ),
//                           );
//                           if (updatedUserData != null) {
//                             setState(() {
//                               userData = updatedUserData;
//                             });
//                           }
//                         },
//                         icon: Icon(Icons.edit, size: 30, color: Colors.white,)
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
