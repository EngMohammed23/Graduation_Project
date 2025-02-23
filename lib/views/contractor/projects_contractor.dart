import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takatuf/views/contractor/project_details_screen.dart';

class ProjectsContractor extends StatefulWidget {
  const ProjectsContractor({super.key});

  @override
  State<ProjectsContractor> createState() => _ProjectsContractorState();
}

class _ProjectsContractorState extends State<ProjectsContractor> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0XFF003366),
      appBar: AppBar(
        backgroundColor: const Color(0XFF003366),
        title: Text(
          'المشاريع',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
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
                              final duration = projectData['duration'] ?? 'غير محدد';
                              final expectedDelivery = projectData['expectedDelivery'] ?? 'غير متوفر';

                              return GestureDetector(
                                onTap: () {
                                  if (userId != null) {
                                    print("Navigating to ProjectDetailsScreen with projectId: $projectId and userId: $userId");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProjectDetailsScreen(
                                          projectId: projectId,
                                          userId: userId!,
                                        ),
                                      ),
                                    );
                                  } else {
                                    print("User not logged in");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('يجب تسجيل الدخول أولًا')),
                                    );
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 4,
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // النصوص على اليسار
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                title,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "الوصف: $description",
                                                style: GoogleFonts.inter(fontSize: 14),
                                              ),
                                              Text(
                                                "المدة: $duration",
                                                style: GoogleFonts.inter(fontSize: 14),
                                              ),
                                              Text(
                                                "التسليم المتوقع: $expectedDelivery يوم",
                                                style: GoogleFonts.inter(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // الصورة على اليمين
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.asset(
                                            'assets/images/three.jpg',
                                            width: 160,  // تكبير الصورة
                                            height: 160,  // تكبير الصورة
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
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
