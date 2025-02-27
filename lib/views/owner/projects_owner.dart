import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/owner/Requests_Screen.dart';

class ProjectsOwner extends StatefulWidget {
  const ProjectsOwner({super.key});

  @override
  State<ProjectsOwner> createState() => _ProjectsOwnerState();
}

class _ProjectsOwnerState extends State<ProjectsOwner> {
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
          'projects'.tr(),
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
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
                            return Center(child: Text('errorFetchingData'.tr()));
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('noProjectsAvailable'.tr()));
                          }

                          final projectDocs = snapshot.data!.docs;

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: projectDocs.length,
                            itemBuilder: (context, index) {
                              final projectDoc = projectDocs[index];
                              final projectData = projectDoc.data() as Map<String, dynamic>;
                              final projectId = projectDoc.id;
                              final title = projectData['title'] ?? 'noTitle'.tr();
                              final description = projectData['description'] ?? 'unknown'.tr();
                              final duration = projectData['duration'] ?? 'unspecified'.tr();
                              final expectedDelivery = projectData['expectedDelivery'] ?? 'notAvailable'.tr();

                              return GestureDetector(
                                onTap: () {
                                  if (userId != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RequestsScreen(projectId: projectId),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('loginRequired'.tr())),
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
                                                '${'description'.tr()}: $description',
                                                style: GoogleFonts.inter(fontSize: 14),
                                              ),
                                              Text(
                                                '${'projectDuration'.tr()}: $duration',
                                                style: GoogleFonts.inter(fontSize: 14),
                                              ),
                                              Text(
                                                '${'expectedDelivery'.tr()}: $expectedDelivery',
                                                style: GoogleFonts.inter(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.asset(
                                            'assets/images/three.jpg',
                                            width: 160,
                                            height: 160,
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
