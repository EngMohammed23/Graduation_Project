import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takatuf/views/owner/Requests_Screen.dart';
import 'package:takatuf/views/contractor/project_details_screen.dart';

class ProjectsOwner extends StatefulWidget {
  const ProjectsOwner({super.key});

  @override
  State<ProjectsOwner> createState() => _ProjectsOwnerState();
}

class _ProjectsOwnerState extends State<ProjectsOwner> {
  String? userId; // ✅ تخزين معرف المستخدم

  @override
  void initState() {
    super.initState();
    _fetchUserId(); // ✅ جلب `userId` عند تحميل الصفحة
  }

  Future<void> _fetchUserId() async {
    final user = FirebaseAuth.instance.currentUser; // ✅ جلب المستخدم الحالي
    if (user != null) {
      setState(() {
        userId = user.uid; // ✅ تخزين `userId`
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0XFF003366),
      body: Column(
        children: [
          SizedBox(height: statusBarHeight),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(30),
                  left: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 40, end: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('projects').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(child: Text('حدث خطأ في جلب البيانات'));
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text('لا توجد مشاريع متاحة'));
                          }

                          final projectDocs = snapshot.data!.docs;

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: projectDocs.length,
                            itemBuilder: (context, index) {
                              final projectDoc = projectDocs[index];
                              final projectData = projectDoc.data() as Map<String, dynamic>;
                              final projectId = projectDoc.id;
                              final title = projectData['title'] ?? 'بدون عنوان';
                              final description = projectData['description'] ?? 'غير معروف';

                              return Padding(
                                padding: const EdgeInsetsDirectional.only(bottom: 17.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (userId != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RequestsScreen(projectId: projectId)
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('يجب تسجيل الدخول أولًا')),
                                      );
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              description,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.asset(
                                          'assets/images/three.jpg',
                                          width: 182,
                                          height: 182,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:takatuf/views/project_details_screen.dart';
//
// class Projects extends StatelessWidget {
//   final String userId; // ✅ إضافة معرف المستخدم
//
//   const Projects({super.key, required this.userId}); // ✅ استلام userId
//
//   @override
//   Widget build(BuildContext context) {
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//
//     return Scaffold(
//       backgroundColor: const Color(0XFF003366),
//       body: Column(
//         children: [
//           SizedBox(height: statusBarHeight),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 35),
//             height: 15,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(30),
//                 topRight: Radius.circular(30),
//               ),
//               color: Color(0XFFE7F0FF),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.horizontal(
//                   right: Radius.circular(30),
//                   left: Radius.circular(30),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsetsDirectional.only(start: 40, end: 40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Transform.translate(
//                       offset: const Offset(-15, 15),
//                       child: IconButton(
//                         onPressed: () => Navigator.pop(context),
//                         icon: const Icon(Icons.close, size: 30),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Expanded(
//                       child: StreamBuilder<QuerySnapshot>(
//                         stream: FirebaseFirestore.instance.collection('projects').snapshots(),
//                         builder: (context, snapshot) {
//                           if (snapshot.hasError) {
//                             return const Center(child: Text('حدث خطأ في جلب البيانات'));
//                           }
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                             return const Center(child: CircularProgressIndicator());
//                           }
//                           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                             return const Center(child: Text('لا توجد مشاريع متاحة'));
//                           }
//
//                           final projectDocs = snapshot.data!.docs;
//
//                           return ListView.builder(
//                             padding: EdgeInsets.zero,
//                             itemCount: projectDocs.length,
//                             itemBuilder: (context, index) {
//                               final projectDoc = projectDocs[index];
//                               final projectData = projectDoc.data() as Map<String, dynamic>;
//                               final projectId = projectDoc.id;
//                               final title = projectData['title'] ?? 'بدون عنوان';
//                               final expectedDelivery = projectData['expectedDelivery'] ?? 'غير متوفر';
//                               final duration = projectData['duration'] ?? 'غير متوفر';
//                               final description = projectData['description'] ?? 'غير معروف';
//                               final imageUrl = projectData['imageUrl'] ?? 'https://via.placeholder.com/150';
//
//                               return Padding(
//                                 padding: const EdgeInsetsDirectional.only(bottom: 17.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ProjectDetailsScreen(
//                                           projectId: projectId,
//                                           userId: userId, // ✅ تمرير معرف المستخدم عند فتح الصفحة
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               title,
//                                               style: GoogleFonts.poppins(
//                                                 fontWeight: FontWeight.normal,
//                                                 fontSize: 17,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 5),
//                                             Text(
//                                               description,
//                                               style: GoogleFonts.inter(
//                                                 fontSize: 12,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 5),
//                                             Text(
//                                               'المدة: $duration',
//                                               style: GoogleFonts.inter(
//                                                 fontSize: 12,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 5),
//                                             Text(
//                                               'التسليم المتوقع: $expectedDelivery',
//                                               style: GoogleFonts.inter(
//                                                 fontSize: 12,
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(6),
//                                         child: Image.asset(
//                                           'assets/images/three.jpg',
//                                           width: 182,
//                                           height: 182,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
