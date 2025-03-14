import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

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
    }).catchError((error) {
      print("❌ خطأ أثناء إرسال الرسالة: $error");
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
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        'errorLoadingMessages'.tr(args: [snapshot.error.toString()]),
                      ));
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

                messages.sort((a, b) {
                  var timeA = (a['timestamp'] as Timestamp?)?.toDate() ?? DateTime(2000);
                  var timeB = (b['timestamp'] as Timestamp?)?.toDate() ?? DateTime(2000);
                  return timeB.compareTo(timeA);
                });

                return ListView.builder(
                  reverse: true, // ترتيب الرسائل من الأحدث إلى الأقدم
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data() as Map<String, dynamic>;

                    if (!message.containsKey('senderId') || !message.containsKey('message')) {
                      return SizedBox();
                    }

                    bool isMe = message['senderId'] == currentUserId;
                    Timestamp? timestamp = message['timestamp'] as Timestamp?;
                    String time = timestamp != null
                        ? DateFormat('hh:mm a').format(timestamp.toDate())
                        : '...';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['message'],
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 12,
                                color: isMe ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
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

