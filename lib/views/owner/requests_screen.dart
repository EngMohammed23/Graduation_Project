import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:takatuf/views/chat/chat_screen.dart';
import 'chat_owner_screen.dart';

class RequestsScreen extends StatelessWidget {
  final String projectId;

  RequestsScreen({required this.projectId});

  void updateRequestStatus(String requestId, String newStatus, BuildContext context) {
    FirebaseFirestore.instance.collection('requests').doc(requestId).update({
      'status': newStatus,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request $newStatus successfully!'.tr()), backgroundColor: Colors.green),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update request'.tr()), backgroundColor: Colors.red),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('incomingRequests'.tr())),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where('projectId', isEqualTo: projectId)
            .snapshots(),
        builder: (context, snapshot) {
          // تحقق إذا كانت البيانات ما زالت في حالة انتظار أو هناك خطأ
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator()); // عرض مؤشر التحميل أثناء انتظار البيانات
          }

          if (snapshot.hasError) {
            return Center(child: Text('errorLoadingMessages'.tr(args: [snapshot.error.toString()])));
          }

          // تحقق من وجود بيانات
          var requests = snapshot.data!.docs;
          if (requests.isEmpty) {
            return Center(
              child: Text('noData'.tr(), style: TextStyle(fontSize: 18)), // رسالة إذا كانت القائمة فارغة
            );
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              String requestId = request.id;
              String userId = request['userId'] ?? 'Unknown';
              String daysNeeded = request['daysNeeded'] ?? '0';
              String status = request['status'] ?? 'pending';
              String price = request['price'] ?? 'N/A';
              String email = request['email'] ?? 'example@gmail.com';

              // ترجمة الحالة
              Map<String, String> statusTranslations = {
                'pending': 'قيد الانتظار'.tr(),
                'accepted': 'مقبول'.tr(),
                'rejected': 'مرفوض'.tr(),
              };

              // تحديد لون الخلفية بناءً على الحالة
              Color cardColor;
              if (status == 'accepted') {
                cardColor = Colors.green.shade100; // 🟢 أخضر فاتح جدًا عند القبول
              } else if (status == 'rejected') {
                cardColor = Colors.red.shade100; // 🔴 أحمر فاتح جدًا عند الرفض
              } else {
                cardColor = Colors.white; // ⚪️ اللون الافتراضي عند `pending`
              }

              return Card(
                color: cardColor,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text('${'user'.tr()}: $email',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'daysNeeded'.tr()}: $daysNeeded', style: TextStyle(fontSize: 14.0)),
                      Text('${'price'.tr()}: $price', style: TextStyle(fontSize: 14.0)),
                      Text('${'status'.tr()}: ${statusTranslations[status] ?? status}',
                          style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status == 'accepted')
                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  projectId: projectId,
                                  userId: userId,
                                ),
                              ),
                            );
                          },
                        ),
                      if (status == 'pending') // ✅ عرض أزرار القبول/الرفض فقط إذا كان الطلب قيد الانتظار
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () => updateRequestStatus(requestId, 'accepted', context),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => updateRequestStatus(requestId, 'rejected', context),
                            ),
                          ],
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
