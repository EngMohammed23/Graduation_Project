import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'edit_project_screen.dart';

/// واجهة عرض المشاريع
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('allProjects'.tr()),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
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

          final projectsDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: projectsDocs.length,
            itemBuilder: (context, index) {
              final doc = projectsDocs[index];
              final data = doc.data() as Map<String, dynamic>;

              final title = data['title'] ?? 'noTitle'.tr();
              final description = data['description'] ?? 'noDescription'.tr();
              final duration = data['duration'] ?? 'noBudget'.tr();
              final expectedDelivery = data['expectedDelivery'] ?? 'notSpecified'.tr();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(
                    '$description\n${'budget'.tr()}: $duration\n${'expectedDelivery'.tr()}: $expectedDelivery',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditProjectScreen(
                                projectId: doc.id,
                                projectData: data,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('deleteProject'.tr()),
                              content: Text('${'confirmDeleteProject'.tr()} "$title"?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('cancel'.tr()),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await FirebaseFirestore.instance
                                        .collection('projects')
                                        .doc(doc.id)
                                        .delete();
                                  },
                                  child: Text('delete'.tr(), style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'edit_project_screen.dart';
//
// /// واجهة عرض المشاريع
// class ProjectsScreen extends StatelessWidget {
//   const ProjectsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // نستخدم StreamBuilder لجلب البيانات بشكل مستمر من Firestore
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('جميع المشاريع'),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('projects').snapshots(),
//         builder: (context, snapshot) {
//           // في حال وجود خطأ
//           if (snapshot.hasError) {
//             return const Center(child: Text('حدث خطأ في جلب البيانات'));
//           }
//           // في حال انتظار البيانات
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           // إذا لم يكن هناك بيانات
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('لا يوجد مشاريع حاليا'));
//           }
//
//           // تحويل المستندات إلى ListView
//           final projectsDocs = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: projectsDocs.length,
//             itemBuilder: (context, index) {
//               // جلب بيانات المشروع
//               final doc = projectsDocs[index];
//               final data = doc.data() as Map<String, dynamic>;
//
//               // قراءة الحقول المراد عرضها
//               final title = data['title'] ?? 'بدون عنوان';
//               final description = data['description'] ?? 'لا توجد تفاصيل';
//               final duration = data['duration'] ?? 'لا توجد ميزانية';
//               final expectedDelivery = data['expectedDelivery'] ?? 'غير محدد';
//
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: ListTile(
//                   title: Text(title),
//                   subtitle: Text('$description\nالميزانية: $duration\nالتسليم المتوقّع: $expectedDelivery'),
//                   isThreeLine: true,
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // زر تعديل
//                       IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.blue),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => EditProjectScreen(
//                                 projectId: doc.id,
//                                 projectData: data,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       // زر حذف
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           // تأكيد الحذف
//                           showDialog(
//                             context: context,
//                             builder: (_) => AlertDialog(
//                               title: const Text('حذف المشروع'),
//                               content: Text('هل أنت متأكد من حذف "$title"؟'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context), // إغلاق الحوار
//                                   child: const Text('إلغاء'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     Navigator.pop(context); // إغلاق الحوار
//                                     // حذف المستند من Firestore
//                                     await FirebaseFirestore.instance
//                                         .collection('projects')
//                                         .doc(doc.id)
//                                         .delete();
//                                   },
//                                   child: const Text('حذف', style: TextStyle(color: Colors.red)),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
