import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takatuf/model/owner/home_owner_controller.dart';
import 'package:takatuf/views/others/requests_all_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/owner/projects_owner.dart';
import 'package:takatuf/views/owner/requests_screen.dart';

class HomeOwnerScreen extends StatefulWidget {
  HomeOwnerScreen({super.key});

  @override
  State<HomeOwnerScreen> createState() => _HomeOwnerScreenState();
}

class _HomeOwnerScreenState extends State<HomeOwnerScreen> {
  final controller = Get.put(HomeOwnerController());
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
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6C89A4),
              ),
              child: Center(
                child: Text(
                  'menu'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('home'.tr()),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.request_page),
              title: Text('request'.tr()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestsAllScreen(projectId: 'mdcvkdmckm'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Center(child: Text('homeOwner'.tr(),style: GoogleFonts.tajawal())),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/setting_screen');
                },
                icon: Icon(Icons.settings),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/three.jpg',
                width: double.infinity,
                height: 182,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'projects'.tr(),
                  style: GoogleFonts.tajawal(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProjectsOwner()),
                    );
                  },
                  child: Text(
                    'seeAll'.tr(),
                    style: GoogleFonts.tajawal(
                      color: const Color(0xFF979797),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('projects').where('userId', isEqualTo: userId).snapshots(),
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
                    scrollDirection: Axis.horizontal,
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
                        child:Container(
                                    width: 200,
                                    margin: EdgeInsetsDirectional.symmetric(horizontal: 5),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFFCDD4D9),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.asset(
                                            'assets/images/three.jpg',
                                            width: double.infinity,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          title,
                                          style: GoogleFonts.tajawal(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          description,
                                          style: GoogleFonts.tajawal(
                                            color: const Color(0xFF979797),
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${'expectedDelivery'.tr()}: ${expectedDelivery}',
                                          style: GoogleFonts.tajawal(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${'expectedBudget'.tr()}: ${duration}',
                                          style: GoogleFonts.tajawal(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),)
                      );
                    },
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}

