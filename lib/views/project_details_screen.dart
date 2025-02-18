import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;
  final String userId; // معرف المستخدم الذي يقدم الطلب

  const ProjectDetailsScreen({super.key, required this.projectId, required this.userId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  TextEditingController _daysController = TextEditingController();
  bool isRequestPending = false;

  @override
  void initState() {
    super.initState();
    checkIfRequestExists();
  }

  void checkIfRequestExists() async {
    var request = await FirebaseFirestore.instance
        .collection('requests')
        .where('projectId', isEqualTo: widget.projectId)
        .where('userId', isEqualTo: widget.userId)
        .get();

    if (request.docs.isNotEmpty) {
      setState(() {
        isRequestPending = true;
      });
    }
  }

  void sendRequest() async {
    String daysNeeded = _daysController.text.trim();

    if (daysNeeded.isEmpty) {
      Get.snackbar('خطأ', 'يرجى إدخال عدد الأيام المطلوبة');
      return;
    }

    await FirebaseFirestore.instance.collection('requests').add({
      'projectId': widget.projectId,
      'userId': widget.userId,
      'daysNeeded': daysNeeded,
      'status': 'pending', // قيد الانتظار
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      isRequestPending = true;
    });

    Get.snackbar('تم الإرسال', 'تم إرسال طلبك بنجاح');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('projects')
            .doc(widget.projectId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('المشروع غير موجود'));
          }

          var projectData = snapshot.data!.data() as Map<String, dynamic>;
          String title = projectData['title'] ?? 'بدون عنوان';
          String description = projectData['description'] ?? 'لا يوجد وصف';
          String duration = projectData['duration'] ?? 'غير متوفر';
          String relatedSkills = projectData['relatedSkills'] ?? 'غير متوفر';

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    children: [
                      Image.asset('assets/images/three.jpg', fit: BoxFit.cover),
                      SizedBox(height: 9),
                      Text(duration,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.black54)),
                      SizedBox(height: 3),
                      Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.black)),
                      SizedBox(height: 3),
                      Text(description,
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.black)),
                      SizedBox(height: 10),
                      Text('المهارات المطلوبة: $relatedSkills',
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black)),
                    ],
                  ),
                ),
                Spacer(),
                if (!isRequestPending)
                  Column(
                    children: [
                      TextField(
                        controller: _daysController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'أدخل عدد الأيام المطلوبة',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        height: 56,
                        minWidth: 300,
                        color: Color(0XFF003366),
                        textColor: Colors.white,
                        child: Text('تقديم طلب'),
                        onPressed: sendRequest,
                      ),
                    ],
                  )
                else
                  MaterialButton(
                    height: 56,
                    minWidth: 300,
                    color: Colors.grey,
                    textColor: Colors.white,
                    child: Text('بانتظار القبول'),
                    onPressed: null,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ProjectDetailsScreen extends StatefulWidget {
//   final String projectId;
//
//   const ProjectDetailsScreen({super.key, required this.projectId});
//
//   @override
//   State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
// }
//
// class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.share),
//           ),
//         ],
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance
//             .collection('projects')
//             .doc(widget.projectId)
//             .get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return Center(child: Text('المشروع غير موجود'));
//           }
//
//           var projectData = snapshot.data!.data() as Map<String, dynamic>;
//           String title = projectData['title'] ?? 'بدون عنوان';
//           String description = projectData['description'] ?? 'لا يوجد وصف';
//           String duration = projectData['duration'] ?? 'غير متوفر';
//           String expectedDelivery =
//               projectData['expectedDelivery'] ?? 'غير متوفر';
//           String relatedSkills = projectData['relatedSkills'] ?? 'غير متوفر';
//
//           return Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     children: [
//                       Container(
//                         child: Image.asset('assets/images/three.jpg',),
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/three.jpg'),
//                               fit: BoxFit.cover, // Adjust as needed
//                             ),
//                             border: Border.all(
//                               width: 3,
//                             ),
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       SizedBox(height: 9),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(duration,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 12, color: Colors.black54)),
//                               SizedBox(height: 3),
//                               Text(title,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 20, color: Colors.black)),
//                               SizedBox(height: 3),
//                               Text(description,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 18, color: Colors.black)),
//                               SizedBox(height: 10),
//                               Text('المهارات المطلوبة: $relatedSkills',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 16, color: Colors.black)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     MaterialButton(
//                       height: 56,
//                       minWidth: 300,
//                       color: Color(0XFF003366),
//                       textColor: Colors.white,
//                       child: Text('تقديم طلب'),
//                       onPressed: () {},
//                     ),
//
//
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
//



// SizedBox(width: 10),
// Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Text('تاريخ التسليم المتوقع', style: GoogleFonts.poppins(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w500)),
//     SizedBox(height: 5),
//     Text(expectedDelivery, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500)),
//   ],
// ),

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ProjectDetailsScreen extends StatefulWidget {
//   const ProjectDetailsScreen({super.key});
//
//   @override
//   State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
// }
//
// class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
//   double _rating = 3.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(Icons.arrow_back_outlined)),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Icon(Icons.share)),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/images/three.jpg'),
//             SizedBox(height: 9,),
//             SizedBox(
//               height: 400,
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Nov 4 - 5 min read',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black54),),
//                     SizedBox(height: 3,),
//                     Text('Well, well, well, how the turntables',style: GoogleFonts.poppins(fontSize: 20,color: Colors.black)),
//                     SizedBox(height: 3,),
//                     Text("Wikipedia is the best thing ever. Anyone in the world can write anything they want about any subject. So you know you are getting the best possible information."
//                         "\n And I knew exactly what to do. But in a much more real sense, I had no idea what to do.Okay, too many different words from coming at me from too many different sentences."
//                         "\n Wikipedia is the best thing ever. Anyone in the world can write anything they want about any subject. So you know you are getting the best possible information.",
//                       style: GoogleFonts.poppins(fontSize: 18,color: Colors.black,),),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment:  MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 MaterialButton(
//                     height: 56,
//                     minWidth: 100,
//                     color: Color(0XFF003366),
//                     textColor: Colors.white,
//                     child: Text('تقديم طلب'),
//                     onPressed: () {
//
//                     }),
//                 SizedBox(width: 10,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text('Expected Delivery Date',style: GoogleFonts.poppins(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.w500),),
//                   ],
//                 ),
//                 SizedBox(width: 10,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text('15-10-2024',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
//                     SizedBox(height: 8,),
//                     Text('%50',style: GoogleFonts.poppins(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
//                     ]),
//                   ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
