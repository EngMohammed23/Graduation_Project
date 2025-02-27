import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'chat_owner_screen.dart';

class RequestsScreen extends StatelessWidget {
  final String projectId;

  RequestsScreen({required this.projectId});

  void updateRequestStatus(String requestId, String newStatus) {
    FirebaseFirestore.instance.collection('requests').doc(requestId).update({
      'status': newStatus,
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
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              String requestId = request.id;
              String userId = request['userId'];
              String daysNeeded = request['daysNeeded'];
              String status = request['status'];
              String price = request['price'];

              Icon statusIcon;
              if (status == 'pending') {
                statusIcon = Icon(Icons.hourglass_empty, color: Colors.orange);
              } else if (status == 'accepted') {
                statusIcon = Icon(Icons.check_circle, color: Colors.green);
              } else {
                statusIcon = Icon(Icons.cancel, color: Colors.red);
              }

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text('${'user'.tr()}: $userId', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'daysNeeded'.tr()}: $daysNeeded', style: TextStyle(fontSize: 14.0)),
                      Text('${'price'.tr()}: $price', style: TextStyle(fontSize: 14.0)),
                      Text('${'status'.tr()}: ${status.tr()}', style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      statusIcon,
                      if (status == 'accepted')
                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.blue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatOwnerScreen(
                                  projectId: projectId,
                                  userId: userId,
                                ),
                              ),
                            );
                          },
                        ),
                      if (status == 'pending')
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () => updateRequestStatus(requestId, 'accepted'),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => updateRequestStatus(requestId, 'rejected'),
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
