import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectsAndWorkersScreen extends StatelessWidget {
  const ProjectsAndWorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المشاريع والعُمّال'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// قسم عرض المشاريع
            const Text(
              'المشاريع',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('projects').snapshots(),
              builder: (context, snapshot) {
                // في حال حدوث خطأ
                if (snapshot.hasError) {
                  return const Text('حدث خطأ في جلب المشاريع');
                }
                // في حال انتظار البيانات
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // في حال عدم وجود بيانات
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('لا توجد مشاريع متاحة');
                }

                // عرض قائمة المشاريع
                final projectDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,                // للسماح بقائمة مدمجة مع عناصر أخرى
                  physics: const NeverScrollableScrollPhysics(), // لمنع التمرير داخل القائمة
                  itemCount: projectDocs.length,
                  itemBuilder: (context, index) {
                    final projectData = projectDocs[index].data() as Map<String, dynamic>;
                    final title = projectData['title'] ?? 'بدون عنوان';
                    final description = projectData['description'] ?? 'لا يوجد وصف';

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(title),
                        subtitle: Text(description),
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 16.0),

            /// قسم عرض العمّال (Workers)
            const Text(
              'العُمّال',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('userType', isEqualTo: 'Worker')
                  .snapshots(),
              builder: (context, snapshot) {
                // في حال حدوث خطأ
                if (snapshot.hasError) {
                  return const Text('حدث خطأ في جلب بيانات العُمّال');
                }
                // في حال انتظار البيانات
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // في حال عدم وجود بيانات
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('لا يوجد عُمّال حاليًا');
                }

                // عرض قائمة العمّال
                final workerDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: workerDocs.length,
                  itemBuilder: (context, index) {
                    final workerData = workerDocs[index].data() as Map<String, dynamic>;
                    final email = workerData['email'] ?? 'No email';
                    final fullName = workerData['fullName'] ?? 'No name';
                    final uid = workerData['uid'] ?? 'No UID';

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(fullName),
                        subtitle: Text('Email: $email\nUID: $uid'),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
