import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takatuf/controller/contractor/projects_controller.dart';
import 'package:takatuf/views/contractor/project_details_screen.dart';
import '../../controller/contractor/home_contractor_controller.dart';

class HomeContractor extends StatelessWidget {
  HomeContractor({super.key});

  final HomeContractorController homeController = Get.put(HomeContractorController());
  final ProjectsController projectsController = Get.put(ProjectsController());

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
              leading: Icon(Icons.search),
              title: Text('search'.tr()),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Center(child: Text('homeContractor'.tr())),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/setting_screen');
                },
                icon: Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search_screen');
                },
                icon: Icon(Icons.search),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/projects_contractor');
                  },
                  child: Text(
                    'seeAll'.tr(),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF979797),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // ✅ تحديد ارتفاع مناسب لضبط عرض المشاريع
            SizedBox(
              height: 280, // يمكنك ضبط الارتفاع هنا حسب الحاجة
              child: Obx(() {
                if (homeController.projects.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.projects.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 13),
                  itemBuilder: (context, index) {
                    final project = homeController.projects[index];

                    return InkWell(
                      onTap: () {
                        Get.to(ProjectDetailsScreen(
                          projectId: project.id,
                          project: project,
                          userId: projectsController.userId.value ?? '',
                          email: projectsController.email.value ?? '',
                        ));
                      },
                      child: Container(
                        width: 240,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: const Color(0xFFCDD4D9)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                'assets/images/three.jpg',
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              project.title ?? 'noTitle'.tr(),
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              project.description ?? 'noDescription'.tr(),
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF979797),
                                fontSize: 12,
                              ),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${'expectedDelivery'.tr()}: ${project.expectedDelivery ?? 'unknown'.tr()}',
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${'expectedBudget'.tr()}: ${project.duration ?? 'unknown'.tr()}',
                              maxLines: 1,
                              style: GoogleFonts.poppins(
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
              }),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'workers'.tr(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/workers_screen');
                  },
                  child: Text(
                    'seeAll'.tr(),
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF979797),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:takatuf/controller/contractor/projects_controller.dart';
// import 'package:takatuf/views/contractor/project_details_screen.dart';
// import '../../controller/contractor/home_contractor_controller.dart';
//
// class HomeContractor extends StatelessWidget {
//   HomeContractor({super.key});
//
//   // الحصول على الـ Controllers
//   final HomeContractorController homeController = Get.put(HomeContractorController());
//   final ProjectsController projectsController = Get.put(ProjectsController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFF6C89A4),
//               ),
//               child: Center(
//                 child: Text(
//                   'menu'.tr,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home),
//               title: Text('home'.tr),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.search),
//               title: Text('search'.tr),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         title: Center(child: Text('homeContractor'.tr)),
//         actions: [
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/setting_screen');
//                 },
//                 icon: Icon(Icons.settings),
//               ),
//               IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/search_screen');
//                 },
//                 icon: Icon(Icons.search),
//               )
//             ],
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(6),
//               child: Image.asset(
//                 'assets/images/three.jpg',
//                 width: double.infinity,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'projects'.tr,
//                   style: GoogleFonts.poppins(
//                     color: Colors.black,
//                     fontSize: 22,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/projects_contractor');
//                   },
//                   child: Text(
//                     'seeAll'.tr,
//                     style: GoogleFonts.poppins(
//                       color: const Color(0xFF979797),
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: Obx(() {
//                 if (homeController.projects.isEmpty) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 return ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: homeController.projects.length,
//                   separatorBuilder: (context, index) => const SizedBox(width: 13),
//                   itemBuilder: (context, index) {
//                     final project = homeController.projects[index];
//
//                     return InkWell(
//                       onTap: () {
//                         Get.to(ProjectDetailsScreen(
//                           projectId: project.id,
//                           project: project,
//                           userId: projectsController.userId.value ?? '',
//                           email: projectsController.email.value ?? '',
//                         ));
//                       },
//                       child: Container(
//                         width: 220,
//                         height: 350,
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(width: 1, color: const Color(0xFFCDD4D9)),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(6),
//                               child: Image.asset(
//                                 'assets/images/three.jpg',
//                                 width: double.infinity,
//                                 height: 120,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Text(
//                               project.title ?? 'noTitle'.tr,
//                               style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               project.description ?? 'noDescription'.tr,
//                               style: GoogleFonts.poppins(
//                                 color: const Color(0xFF979797),
//                                 fontSize: 12,
//                               ),
//                               maxLines: 2,
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               '${'expectedDelivery'.tr}: ${project.expectedDelivery ?? 'unknown'}',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               '${'expectedBudget'.tr}: ${project.duration ?? 'unknown'}',
//                               style: GoogleFonts.poppins(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'workers'.tr,
//                   style: GoogleFonts.poppins(
//                     color: Colors.black,
//                     fontSize: 22,
//                   ),
//                 ),
//                 Spacer(),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/workers_screen');
//                   },
//                   child: Text(
//                     'seeAll'.tr,
//                     style: GoogleFonts.poppins(
//                       color: const Color(0xFF979797),
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:takatuf/controller/contractor/projects_controller.dart';
// // import 'package:takatuf/views/contractor/project_details_screen.dart';
// // import '../../controller/contractor/home_contractor_controller.dart';
// //
// // class HomeContractor extends StatelessWidget {
// //   HomeContractor({super.key});
// //
// //   // الحصول على الـ Controllers
// //   final HomeContractorController homeController = Get.put(HomeContractorController());
// //   final ProjectsController projectsController = Get.put(ProjectsController());
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       drawer: Drawer(
// //         child: ListView(
// //           padding: EdgeInsets.zero,
// //           children: [
// //             DrawerHeader(
// //               decoration: BoxDecoration(
// //                 color: Color(0xFF6C89A4),
// //               ),
// //               child: Center(
// //                 child: Text(
// //                   'menu'.tr,
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 24,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.home),
// //               title: Text('home'.tr),
// //               onTap: () {},
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.search),
// //               title: Text('search'.tr),
// //               onTap: () {},
// //             ),
// //           ],
// //         ),
// //       ),
// //       appBar: AppBar(
// //         elevation: 0,
// //         centerTitle: true,
// //         title: Center(child: Text('homeContractor'.tr)),
// //         actions: [
// //           Row(
// //             children: [
// //               IconButton(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/setting_screen');
// //                 },
// //                 icon: Icon(Icons.settings),
// //               ),
// //               IconButton(
// //                 onPressed: () {
// //                   Navigator.pushNamed(context, '/search_screen');
// //                 },
// //                 icon: Icon(Icons.search),
// //               )
// //             ],
// //           )
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(30.0),
// //         child: Column(
// //           children: [
// //             // بيانات المشاريع
// //             Obx(() {
// //               if (homeController.projects.isEmpty) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }
// //               return Expanded(
// //                 child: ListView.builder(
// //                   itemCount: homeController.projects.length,
// //                   itemBuilder: (context, index) {
// //                     final project = homeController.projects[index];
// //                     return InkWell(
// //                       onTap: () {
// //                         Get.to(ProjectDetailsScreen(
// //                           projectId: project.id,
// //                           project: project,
// //                           userId: projectsController.userId.value ?? '',
// //                           email: projectsController.email.value ?? '',
// //                         ));
// //                       },
// //                       child: Container(
// //                         width: double.infinity,
// //                         padding: const EdgeInsets.all(15),
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(15),
// //                           border: Border.all(width: 1, color: Color(0xFFCDD4D9)),
// //                         ),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             ClipRRect(
// //                               borderRadius: BorderRadius.circular(6),
// //                               child: Image.asset(
// //                                 project.imageUrl,
// //                                 width: double.infinity,
// //                                 height: 120,
// //                                 fit: BoxFit.cover,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 20),
// //                             Text(
// //                               project.title,
// //                               style: GoogleFonts.poppins(
// //                                 color: Colors.black,
// //                                 fontSize: 15,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 2),
// //                             Text(
// //                               project.description,
// //                               style: GoogleFonts.poppins(
// //                                 color: const Color(0xFF979797),
// //                                 fontSize: 12,
// //                               ),
// //                               maxLines: 2,
// //                             ),
// //                             const SizedBox(height: 2),
// //                             Text(
// //                               '${'expectedDelivery'.tr}: ${project.expectedDelivery}',
// //                               style: GoogleFonts.poppins(
// //                                 color: Colors.black,
// //                                 fontSize: 12,
// //                               ),
// //                             ),
// //                             const SizedBox(height: 2),
// //                             Text(
// //                               '${'projectDuration'.tr}: ${project.description}', // تعديل هنا بدل expectedBudget
// //                               style: GoogleFonts.poppins(
// //                                 color: Colors.black,
// //                                 fontSize: 12,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               );
// //             }),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
