import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // تأكد من استيراد easy_localization
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import '../../controller/chat_controller.dart';


class ChatScreen extends StatelessWidget {
  final String projectId;
  final String userId;

  const ChatScreen({required this.projectId, required this.userId});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(title: Text('chat'.tr())), // استخدم .tr() من easy_localization
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: chatController.getMessages(projectId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('errorLoadingMessages'.tr(args: [snapshot.error.toString()])));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'noMessagesYet'.tr(), // استخدم .tr() من easy_localization
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                var messages = snapshot.data!;

                return ListView.builder(
                  reverse: true, // ترتيب الرسائل من الأحدث إلى الأقدم
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].data() as Map<String, dynamic>;

                    bool isMe = message['senderId'] == chatController.currentUserId;
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
                    controller: chatController.messageController,
                    decoration: InputDecoration(
                      hintText: 'writeMessage'.tr(), // استخدم .tr() من easy_localization
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () => chatController.sendMessage(projectId, userId),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
