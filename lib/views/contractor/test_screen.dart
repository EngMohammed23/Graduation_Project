import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class ProjectsAndWorkersScreen extends StatelessWidget {
  const ProjectsAndWorkersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('projectsAndWorkers'.tr()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// قسم عرض المشاريع
            Text(
              'projects'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('projects').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('errorFetchingProjects'.tr());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('noProjectsAvailable'.tr());
                }

                final projectDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projectDocs.length,
                  itemBuilder: (context, index) {
                    final projectData = projectDocs[index].data() as Map<String, dynamic>;
                    final title = projectData['title'] ?? 'noTitle'.tr();
                    final description = projectData['description'] ?? 'noDescription'.tr();

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
            Text(
              'workers'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('userType', isEqualTo: 'Worker')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('errorFetchingWorkers'.tr());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('noWorkersAvailable'.tr());
                }

                final workerDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: workerDocs.length,
                  itemBuilder: (context, index) {
                    final workerData = workerDocs[index].data() as Map<String, dynamic>;
                    final email = workerData['email'] ?? 'noEmail'.tr();
                    final fullName = workerData['fullName'] ?? 'noName'.tr();
                    final uid = workerData['uid'] ?? 'noUID'.tr();

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(fullName),
                        subtitle: Text('${'email'.tr()}: $email\n${'uid'.tr()}: $uid'),
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
