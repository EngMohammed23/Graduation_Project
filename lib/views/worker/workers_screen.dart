import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('workers'.tr()),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8.0),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('userType', isEqualTo: 'Worker')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('errorFetchingWorkers'.tr()));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('noWorkersAvailable'.tr()));
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
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
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
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class WorkersScreen extends StatelessWidget {
//   const WorkersScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           const Text(
//             'العُمّال',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8.0),
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('users')
//                 .where('userType', isEqualTo: 'Worker')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               // في حال حدوث خطأ
//               if (snapshot.hasError) {
//                 return const Text('حدث خطأ في جلب بيانات العُمّال');
//               }
//               // في حال انتظار البيانات
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               // في حال عدم وجود بيانات
//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Text('لا يوجد عُمّال حاليًا');
//               }
//
//               // عرض قائمة العمّال
//               final workerDocs = snapshot.data!.docs;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: workerDocs.length,
//                 itemBuilder: (context, index) {
//                   final workerData = workerDocs[index].data() as Map<String, dynamic>;
//                   final email = workerData['email'] ?? 'No email';
//                   final fullName = workerData['fullName'] ?? 'No name';
//                   final uid = workerData['uid'] ?? 'No UID';
//
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: ListTile(
//                       title: Text(fullName),
//                       subtitle: Text('Email: $email\nUID: $uid'),
//                       isThreeLine: true,
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
