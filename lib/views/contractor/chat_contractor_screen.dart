import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatContractorScreen extends StatefulWidget {
  final String projectId;
  final String ownerId; // معرف صاحب المشروع

  const ChatContractorScreen({required this.projectId, required this.ownerId});

  @override
  _ChatContractorScreenState createState() => _ChatContractorScreenState();
}

class _ChatContractorScreenState extends State<ChatContractorScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  void sendMessage() {
    if (_messageController.text.trim().isEmpty || currentUserId == null) return;

    FirebaseFirestore.instance.collection('chats').add({
      'projectId': widget.projectId,
      'senderId': currentUserId,
      'receiverId': widget.ownerId,
      'message': _messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('chat'.tr())),
        body: Center(child: Text('pleaseLoginToChat'.tr())),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('chat'.tr())),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where('projectId', isEqualTo: widget.projectId)
                  .where(Filter.or(
                Filter('senderId', isEqualTo: currentUserId),
                Filter('receiverId', isEqualTo: currentUserId),
              ))
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('errorLoadingMessages'.tr()));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'noMessagesYet'.tr(),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true, // عرض الرسائل من الأحدث إلى الأقدم
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data() as Map<String, dynamic>;

                    if (!message.containsKey('senderId') || !message.containsKey('message')) {
                      return SizedBox(); // تجنب حدوث أخطاء بسبب بيانات غير مكتملة
                    }

                    bool isMe = message['senderId'] == currentUserId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['message'],
                          style: TextStyle(color: isMe ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'writeMessage'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ChatContractorScreen extends StatefulWidget {
//   final String projectId;
//   final String ownerId; // معرف صاحب المشروع
//
//   const ChatContractorScreen({required this.projectId, required this.ownerId});
//
//   @override
//   _ChatContractorScreenState createState() => _ChatContractorScreenState();
// }
//
// class _ChatContractorScreenState extends State<ChatContractorScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
//
//   void sendMessage() {
//     if (_messageController.text.trim().isEmpty || currentUserId == null) return;
//
//     FirebaseFirestore.instance.collection('chats').add({
//       'projectId': widget.projectId,
//       'senderId': currentUserId,
//       'receiverId': widget.ownerId,
//       'message': _messageController.text.trim(),
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (currentUserId == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text('الدردشة')),
//         body: Center(child: Text('الرجاء تسجيل الدخول لعرض الدردشة')),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: Text('الدردشة')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .where('projectId', isEqualTo: widget.projectId)
//                   .where(Filter.or(
//                 Filter('senderId', isEqualTo: currentUserId),
//                 Filter('receiverId', isEqualTo: currentUserId),
//               ))
//                   // .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 if (snapshot.hasError) {
//                   return Center(child: Text('حدث خطأ أثناء تحميل الرسائل!'));
//                 }
//
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Text(
//                       'لا توجد رسائل حتى الآن',
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   );
//                 }
//
//                 var messages = snapshot.data!.docs;
//
//                 return ListView.builder(
//                   reverse: true, // عرض الرسائل من الأحدث إلى الأقدم
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index].data() as Map<String, dynamic>;
//
//                     if (!message.containsKey('senderId') || !message.containsKey('message')) {
//                       return SizedBox(); // تجنب حدوث أخطاء بسبب بيانات غير مكتملة
//                     }
//
//                     bool isMe = message['senderId'] == currentUserId;
//
//                     return Align(
//                       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.blue : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           message['message'],
//                           style: TextStyle(color: isMe ? Colors.white : Colors.black),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'اكتب رسالة...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send, color: Colors.blue),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
