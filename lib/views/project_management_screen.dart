import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectManagementScreen extends StatelessWidget {
  final List<Map<String, String>> tasks = [
    {
      'status': 'Completed',
      'title': 'Well, well, well, how the turntables',
      'date': 'Nov 4 - 5 min',
      'image': 'assets/images/three.jpg', // رابط صورة
    },
    {
      'status': 'In Progress',
      'title': 'Well, well, well, how the turntables',
      'date': 'Nov 4 - 5 min',
      'image': 'assets/images/three.jpg',
    },
    {
      'status': 'In Progress',
      'title': 'Well, well, well, how the turntables',
      'date': 'Nov 4 - 5 min',
      'image': 'assets/images/three.jpg',
    },
    {
      'status': 'Completed',
      'title': 'Well, well, well, how the turntables',
      'date': 'Nov 4 - 5 min',
      'image': 'assets/images/three.jpg',
    },
    {
      'status': 'Publisher',
      'title': 'Well, well, well, how the turntables',
      'date': 'Nov 4 - 5 min',
      'image': 'assets/images/three.jpg',
    },
  ];

  ProjectManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color(0XFF003366),
      body: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Container(
            margin: EdgeInsetsDirectional.symmetric(horizontal: 35),
            height: 15,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color(0XFFE7F0FF)),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(30),
                    left: Radius.circular(30),
                  )),
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 40,
                  end: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Transform.translate(
                      offset: Offset(-15, 15),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            size: 30,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsetsDirectional.only(top: 0.0),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Padding(
                            padding:
                                const EdgeInsetsDirectional.only(bottom: 17.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 19,
                                            height: 19,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0XFFE7F0FF),
                                              border: Border.all(
                                                  color: Color(0XFFE7F0FF),
                                                  width: 1),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            task['status']!,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        task['title']!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 17),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        task['date']!,
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    task['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
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
