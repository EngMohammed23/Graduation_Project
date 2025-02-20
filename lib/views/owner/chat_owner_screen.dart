import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatOwnerScreen extends StatefulWidget {
  final String projectId;
  final String userId; // معرف المقاول الذي قدم الطلب

  const ChatOwnerScreen({required this.projectId, required this.userId});

  @override
  _ChatOwnerScreenState createState() => _ChatOwnerScreenState();
}

class _ChatOwnerScreenState extends State<ChatOwnerScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  void sendMessage() {
    if (_messageController.text.trim().isEmpty || currentUserId == null) return;

    FirebaseFirestore.instance.collection('chats').add({
      'projectId': widget.projectId,
      'senderId': currentUserId,
      'receiverId': widget.userId,
      'message': _messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('الدردشة')),
        body: Center(child: Text('الرجاء تسجيل الدخول لعرض الدردشة')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('الدردشة')),
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
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('  : ${snapshot.hasError.toString()}حدث خطأ أثناء تحميل الرسائل! '));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد رسائل حتى الآن',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data() as Map<String, dynamic>;

                    // تأكد من أن الرسالة تحتوي على الحقول المطلوبة
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
                      hintText: 'اكتب رسالة...',
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
// class ChatOwnerScreen extends StatefulWidget {
//   final String projectId;
//   final String userId; // معرف المقاول الذي قدم الطلب
//
//   const ChatOwnerScreen({required this.projectId, required this.userId});
//
//   @override
//   _ChatOwnerScreenState createState() => _ChatOwnerScreenState();
// }
//
// class _ChatOwnerScreenState extends State<ChatOwnerScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//   void sendMessage() {
//     if (_messageController.text.trim().isEmpty) return;
//
//     FirebaseFirestore.instance.collection('chats').add({
//       'projectId': widget.projectId,
//       'senderId': currentUserId,
//       'receiverId': widget.userId,
//       'message': _messageController.text.trim(),
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//                   .orderBy('timestamp', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator()); // عرض التحميل فقط في البداية
//                 }
//
//                 if (snapshot.hasError) {
//                   return Center(child: Text('حدث خطأ أثناء تحميل الرسائل'));
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
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
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



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ChatOwnerScreen extends StatefulWidget {
//   final String projectId;
//   final String userId; // معرف المقاول الذي قدم الطلب
//
//   const ChatOwnerScreen({required this.projectId, required this.userId});
//
//   @override
//   _ChatOwnerScreenState createState() => _ChatOwnerScreenState();
// }
//
// class _ChatOwnerScreenState extends State<ChatOwnerScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//   void sendMessage() {
//     if (_messageController.text.trim().isEmpty) return;
//
//     FirebaseFirestore.instance.collection('chats').add({
//       'projectId': widget.projectId,
//       'senderId': currentUserId,
//       'receiverId': widget.userId,
//       'message': _messageController.text.trim(),
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//                   .orderBy('timestamp', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//
//                 var messages = snapshot.data!.docs;
//
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
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


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ChatOwnerScreen extends StatefulWidget {
//   final String projectId;
//   final String userId;
//
//   const ChatOwnerScreen({required this.projectId, required this.userId});
//
//   @override
//   _ChatOwnerScreenState createState() => _ChatOwnerScreenState();
// }
//
// class _ChatOwnerScreenState extends State<ChatOwnerScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//   void sendMessage() {
//     if (_messageController.text.trim().isEmpty) return;
//
//     FirebaseFirestore.instance.collection('chats').add({
//       'projectId': widget.projectId,
//       'senderId': currentUserId,
//       'receiverId': widget.userId,
//       'message': _messageController.text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('الدردشة')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('chats')
//                   .where('projectId', isEqualTo: widget.projectId)
//                   .orderBy('timestamp', descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 var messages = snapshot.data!.docs;
//                 if (!snapshot.hasData) return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var message = messages[index];
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
//
//
//                 return Center(child: CircularProgressIndicator());
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
