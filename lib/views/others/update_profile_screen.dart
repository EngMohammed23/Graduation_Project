import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String email;
  final String phone;

  const UpdateProfileScreen({
    Key? key,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    phoneController.text = widget.phone;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'fullName': nameController.text,
      'phoneNumber': phoneController.text,
    });

    // إرجاع البيانات المحدثة إلى ProfileScreen
    Navigator.pop(context, {
      'fullName': nameController.text,
      'phoneNumber': phoneController.text,
      'email': widget.email,  // يمكنك إضافة البيانات الأخرى هنا إذا أردت
      'userType': widget.email,  // تعديل هذا حسب البيانات المتاحة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_sharp,color: Colors.white,)),
        backgroundColor: const Color(0xFF003366),
        title: Text('Update Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/three.jpg'),
                radius: 70,
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(height: 20),
              _buildTextField('Full Name', nameController),
              SizedBox(height: 20),
              _buildTextField('Phone Number', phoneController),
              SizedBox(height: 40),
              MaterialButton(
                onPressed: _updateProfile,
                minWidth: double.infinity,
                elevation: 10,
                color: Color(0xFF003366),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter $label',
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/get_core.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   final String userId;
//   final String name;
//   final String email;
//   final String phone;
//
//   const UpdateProfileScreen({
//     Key? key,
//     required this.userId,
//     required this.name,
//     required this.email,
//     required this.phone,
//   }) : super(key: key);
//
//   @override
//   _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.name;
//     phoneController.text = widget.phone;
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }
//
//   void _updateProfile() async {
//     await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
//       'fullName': nameController.text,
//       'phoneNumber': phoneController.text,
//     });
//
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_sharp,color: Colors.white,)),
//         backgroundColor: const Color(0xFF003366),
//         title: Text('Update Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white)),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage('assets/images/three.jpg'),
//                 radius: 70,
//                 backgroundColor: Colors.grey[200],
//               ),
//               SizedBox(height: 20),
//               _buildTextField('Full Name', nameController),
//               SizedBox(height: 20),
//               _buildTextField('Phone Number', phoneController),
//               SizedBox(height: 40),
//               MaterialButton(
//                 onPressed: _updateProfile,
//                 minWidth: double.infinity,
//                   elevation: 10,
//                   color: Color(0xFF003366),
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   'Save Changes',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         SizedBox(height: 5),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             hintText: 'Enter $label',
//             contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class UpdateProfileScreen extends StatefulWidget {
// //   final String userId;
// //   final String name;
// //   final String email;
// //   final String phone;
// //
// //   const UpdateProfileScreen({
// //     Key? key,
// //     required this.userId,
// //     required this.name,
// //     required this.email,
// //     required this.phone,
// //   }) : super(key: key);
// //
// //   @override
// //   _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
// // }
// //
// // class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController phoneController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     nameController.text = widget.name;
// //     phoneController.text = widget.phone;
// //   }
// //
// //   @override
// //   void dispose() {
// //     nameController.dispose();
// //     phoneController.dispose();
// //     super.dispose();
// //   }
// //
// //   void _updateProfile() async {
// //     await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
// //       'name': nameController.text,
// //       'phone': phoneController.text,
// //     });
// //
// //     Navigator.pop(context);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Update Profile'),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             CircleAvatar(
// //               backgroundImage: AssetImage('assets/images/three.jpg'),
// //               radius: 50,
// //             ),
// //             SizedBox(height: 20),
// //             TextField(
// //               controller: nameController,
// //               decoration: InputDecoration(labelText: 'Full Name'),
// //             ),
// //             SizedBox(height: 20),
// //             TextField(
// //               controller: phoneController,
// //               decoration: InputDecoration(labelText: 'Phone Number'),
// //             ),
// //             SizedBox(height: 40),
// //             ElevatedButton(
// //               onPressed: _updateProfile,
// //               child: Text('Save Changes'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// // //
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:easy_localization/easy_localization.dart';
// // //
// // // class UpdateProfileScreen extends StatefulWidget {
// // //   const UpdateProfileScreen({super.key, required String userId, required name, required email, required phone});
// // //
// // //   @override
// // //   _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
// // // }
// // //
// // // class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
// // //   final TextEditingController nameController = TextEditingController();
// // //   final TextEditingController emailController = TextEditingController();
// // //   final TextEditingController phoneController = TextEditingController();
// // //
// // //   String selectedRole = "Owner";
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     nameController.text = "Michael Scott";
// // //     emailController.text = "michael@gmail.com";
// // //     phoneController.text = "+970 525 488 9625";
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     nameController.dispose();
// // //     emailController.dispose();
// // //     phoneController.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: Icon(Icons.arrow_back, color: Colors.black),
// // //           onPressed: () {
// // //             Navigator.pop(context);
// // //           },
// // //         ),
// // //         title: Text('updateProfile'.tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
// // //         centerTitle: true,
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(25.0),
// // //         child: SingleChildScrollView(
// // //           child: Column(
// // //             children: [
// // //               CircleAvatar(
// // //                 backgroundImage: AssetImage("assets/images/three.jpg"),
// // //                 radius: 50,
// // //                 child: Stack(
// // //                   children: [
// // //                     Align(
// // //                       alignment: AlignmentDirectional.topEnd,
// // //                       child: CircleAvatar(
// // //                         radius: 15,
// // //                         backgroundColor: Colors.blue,
// // //                         child: Icon(Icons.edit, color: Colors.white, size: 15),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               SizedBox(height: 20),
// // //               _buildTextField("fullName".tr(), nameController,true),
// // //               SizedBox(height: 20),
// // //               _buildTextField("email".tr(), emailController,prefixIcon: Icon(Icons.person),false),
// // //               SizedBox(height: 20),
// // //               _buildTextField("phone".tr(), phoneController, prefixIcon: _buildFlagIcon(),true),
// // //               SizedBox(height: 40),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   Navigator.pop(context);
// // //                 },
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: Color(0XFF003366),
// // //                   minimumSize: Size(double.infinity, 50),
// // //                   shape: RoundedRectangleBorder(
// // //                     borderRadius: BorderRadius.circular(10),
// // //                   ),
// // //                 ),
// // //                 child: Text(
// // //                   "save".tr(),
// // //                   style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildTextField(String label, TextEditingController controller,bool? enabel ,{Widget? prefixIcon} ) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(label),
// // //         SizedBox(height: 5),
// // //         TextField(
// // //           enabled: enabel,
// // //           controller: controller,
// // //           decoration: InputDecoration(
// // //             prefixIcon: prefixIcon,
// // //             border: OutlineInputBorder(
// // //               borderRadius: BorderRadius.circular(10),
// // //             ),
// // //             hintText: "enter".tr(args: [label]),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildFlagIcon() {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(10.0),
// // //       child: Image.asset('assets/images/palestine_flag.png', width: 20),
// // //     );
// // //   }
// // // }
// // //
