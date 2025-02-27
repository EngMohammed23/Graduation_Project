import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedRole = "Owner";

  @override
  void initState() {
    super.initState();
    nameController.text = "Michael Scott";
    usernameController.text = "@Michael";
    emailController.text = "michael@gmail.com";
    phoneController.text = "+970 525 488 9625";
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('updateProfile'.tr(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/three.jpg"),
                radius: 50,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.edit, color: Colors.white, size: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildTextField("fullName".tr(), nameController),
              SizedBox(height: 20),
              _buildTextField("username".tr(), usernameController),
              SizedBox(height: 20),
              _buildTextField("email".tr(), emailController),
              SizedBox(height: 20),
              _buildTextField("phone".tr(), phoneController, prefixIcon: _buildFlagIcon()),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      value: "Owner",
                      groupValue: selectedRole,
                      title: Text("projectOwner".tr()),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value.toString();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: "Contractor",
                      groupValue: selectedRole,
                      title: Text("contractor".tr()),
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF003366),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "save".tr(),
                  style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {Widget? prefixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: "enter".tr(args: [label]),
          ),
        ),
      ],
    );
  }

  Widget _buildFlagIcon() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.asset('assets/images/palestine_flag.png', width: 20),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class UpdateProfileScreen extends StatefulWidget {
//   const UpdateProfileScreen({super.key});
//
//   @override
//   _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   String selectedRole = "Project Owner"; // لتحديد الدور الافتراضي
//
//   @override
//   void initState() {
//     super.initState();
//     // يمكنك استرجاع البيانات من Firebase هنا أو تعيين القيم الافتراضية
//     nameController.text = "Michael Scott";
//     usernameController.text = "@Michael";
//     emailController.text = "michael@gmail.com";
//     phoneController.text = "+970 525 488 9625";
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     usernameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage("assets/images/three.jpg"),
//                 radius: 50,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: AlignmentDirectional.topEnd,
//                       child: CircleAvatar(
//                         radius: 15,
//                         backgroundColor: Colors.blue,
//                         child: Icon(Icons.edit, color: Colors.white, size: 15),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               _buildTextField("Your Name", nameController),
//               SizedBox(height: 20),
//               _buildTextField("Username", usernameController),
//               SizedBox(height: 20),
//               _buildTextField("Email", emailController),
//               SizedBox(height: 20),
//               _buildTextField("Phone", phoneController,
//                   prefixIcon: _buildFlagIcon()),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Expanded(
//                     child: RadioListTile(
//                       value: "Project Owner",
//                       groupValue: selectedRole,
//                       title: Text("Project Owner"),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedRole = value.toString();
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: RadioListTile(
//                       value: "Contractor",
//                       groupValue: selectedRole,
//                       title: Text("Contractor"),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedRole = value.toString();
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0XFF003366),
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   "Save",
//                   style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller,
//       {Widget? prefixIcon}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label),
//         SizedBox(height: 5),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             prefixIcon: prefixIcon,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             hintText: "Enter $label",
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFlagIcon() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Image.asset('assets/images/palestine_flag.png', width: 20),
//     );
//   }
// }
