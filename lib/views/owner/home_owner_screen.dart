import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:takatuf/views/contractor/projects_contractor.dart';
import 'package:takatuf/views/owner/projects_owner.dart';
import 'package:takatuf/views/worker/workers_screen.dart';
import '../requests_all_screen.dart';
import 'Requests_Screen.dart';

class HomeOwnerScreen extends StatefulWidget {
  HomeOwnerScreen({super.key});

  @override
  State<HomeOwnerScreen> createState() => _HomeOwnerScreenState();
}

class _HomeOwnerScreenState extends State<HomeOwnerScreen> {
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
            // ListTile(
            //   leading: Icon(Icons.search),
            //   title: Text('search'.tr()),
            //   onTap: () {},
            // ),
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
        title: Center(child: Text('homeOwner'.tr(),style: GoogleFonts.tajawal(

        ),),),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/setting_screen');
                },
                icon: Icon(Icons.settings),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/favorites_screen');
              //   },
              //   icon: Icon(Icons.favorite),
              // )
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
                stream: FirebaseFirestore.instance.collection('projects').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final projects = snapshot.data!.docs;
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: projects.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 13),
                    itemBuilder: (context, index) {
                      final project = projects[index].data() as Map<String, dynamic>;
                      return InkWell(
                        onTap: () {
                          if (userId != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RequestsScreen(projectId: projects[index].id),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('loginRequired'.tr())),
                            );
                          }
                        },
                        child: Container(
                          width: 200,
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
                                project['title'] ?? 'noTitle'.tr(),
                                style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                project['description'] ?? 'noDescription'.tr(),
                                style: GoogleFonts.tajawal(
                                  color: const Color(0xFF979797),
                                  fontSize: 12,
                                ),
                        maxLines: 2,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${'expectedDelivery'.tr()}: ${project['expectedDelivery'] ?? 'unknown'.tr()}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${'duration'.tr()}: ${project['duration'] ?? 'unknown'.tr()}',
                                style: GoogleFonts.tajawal(
                                  color: Colors.black,
                                  fontSize: 12,
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
    );
  }
}

