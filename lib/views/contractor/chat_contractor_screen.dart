import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatContractorScreen extends StatefulWidget {
  final String projectId;
  final String ownerId; // معرف صاحب المشروع

  ChatContractorScreen({required this.projectId, required this.ownerId});

  @override
  _ChatContractorScreenState createState() => _ChatContractorScreenState();
}

class _ChatContractorScreenState extends State<ChatContractorScreen> {
  final TextEditingController _messageController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  void sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

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
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
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
// class ChatContractorScreen extends StatefulWidget {
//   final String projectId;
//   final String userId;
//
//   ChatContractorScreen({required this.projectId, required this.userId});
//
//   @override
//   _ChatContractorScreenState createState() => _ChatContractorScreenState();
// }
//
// class _ChatContractorScreenState extends State<ChatContractorScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void sendMessage() {
//     String? senderId = _auth.currentUser?.uid;
//     if (senderId != null && _messageController.text.isNotEmpty) {
//       FirebaseFirestore.instance.collection('chats').add({
//         'projectId': widget.projectId,
//         'senderId': senderId,
//         'receiverId': widget.userId,
//         'message': _messageController.text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       _messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('الدردشة')),
//       body: Column(
//         children: [
//           Expanded(child: Text('سيتم عرض الرسائل هنا')),
//           TextField(controller: _messageController),
//           IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
//         ],
//       ),
//     );
//   }
// }
