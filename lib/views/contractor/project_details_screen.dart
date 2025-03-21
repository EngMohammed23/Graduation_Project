
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import '../chat/chat_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final String projectId;
  final String userId;
  final String email;

  const ProjectDetailsScreen({super.key, required this.projectId, required this.userId,required this.email, required project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  TextEditingController _daysController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String requestStatus = 'none';
  String requestId = '';
  Map<String, dynamic>? projectData;

  @override
  void initState() {
    super.initState();
    fetchProjectDetails();
    checkRequestStatus();
  }
    void sendRequest() async {
    String daysNeeded = _daysController.text.trim();
    String price = _priceController.text.trim();

    if (daysNeeded.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('errorEnterData'.tr())),
      );
      return;
    }

    var newRequest = await FirebaseFirestore.instance.collection('requests').add({
      'projectId': widget.projectId,
      'userId': widget.userId,
      'daysNeeded': daysNeeded,
      'price': price,
      'status': 'pending',
      'email':widget.email,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      requestStatus = 'pending';
      requestId = newRequest.id;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('requestSent'.tr())),
    );
  }


  void fetchProjectDetails() async {
    var project = await FirebaseFirestore.instance
        .collection('projects')
        .doc(widget.projectId)
        .get();

    if (project.exists) {
      setState(() {
        projectData = project.data();
      });
    }
  }

  void checkRequestStatus() async {
    var request = await FirebaseFirestore.instance
        .collection('requests')
        .where('projectId', isEqualTo: widget.projectId)
        .where('userId', isEqualTo: widget.userId)
        .get();

    if (request.docs.isNotEmpty) {
      setState(() {
        requestStatus = request.docs.first['status'];
        requestId = request.docs.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: projectData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      'assets/images/three.jpg',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${'title'.tr()}: ${projectData!['title']}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('${'description'.tr()}: ${projectData!['description']}',
                            style: TextStyle(fontSize: 16, color: Colors.black54)),
                        SizedBox(height: 8),
                        Text('${'expectedBudget'.tr()}: ${projectData!['duration']}',
                            style: TextStyle(fontSize: 16, color: Colors.black54)),
                        SizedBox(height: 8),
                        Text('${'expectedDelivery'.tr()}: ${projectData!['expectedDelivery']}',
                            style: TextStyle(fontSize: 16, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (requestStatus == 'none')
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _daysController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'requiredDays'.tr(),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'priceInDollars'.tr(),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    height: 56,
                    minWidth: double.infinity,
                    color: Color(0XFF003366),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Text('submitRequest'.tr()),
                    onPressed: sendRequest,
                  ),
                ],
              )
            else if (requestStatus == 'pending')
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: MaterialButton(
                  height: 56,
                  minWidth: double.infinity,
                  textColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Text('waitingApproval'.tr()),
                  onPressed: null,
                ),
              )
            else if (requestStatus == 'accepted')
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    MaterialButton(
                      height: 56,
                      minWidth: 200,
                      color: Colors.blue,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chat),
                          SizedBox(width: 5),
                          Text('openChat'.tr()),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              projectId: widget.projectId,
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              else if (requestStatus == 'rejected')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 10),
                      Text('requestRejected'.tr(), style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'chat_screen.dart';
//
// class ProjectDetailsScreen extends StatefulWidget {
//   final String projectId;
//   final String userId;
//
//   const ProjectDetailsScreen({super.key, required this.projectId, required this.userId});
//
//   @override
//   State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
// }
//
// class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
//   TextEditingController _daysController = TextEditingController();
//   TextEditingController _priceController = TextEditingController();
//   String requestStatus = 'none';
//   String requestId = '';
//   Map<String, dynamic>? request;
//
//
//   @override
//   void initState() {
//     super.initState();
//     checkRequestStatus();
//   }
//
//   void checkRequestStatus() async {
//     var request = await FirebaseFirestore.instance
//         .collection('requests')
//         .where('projectId', isEqualTo: widget.projectId)
//         .where('userId', isEqualTo: widget.userId)
//         .get();
//
//     if (request.docs.isNotEmpty) {
//       setState(() {
//         requestStatus = request.docs.first['status'];
//         requestId = request.docs.first.id;
//       });
//     }
//   }
//
//   void sendRequest() async {
//     String daysNeeded = _daysController.text.trim();
//     String price = _priceController.text.trim();
//
//     if (daysNeeded.isEmpty || price.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('errorEnterData'.tr())),
//       );
//       return;
//     }
//
//     var newRequest = await FirebaseFirestore.instance.collection('requests').add({
//       'projectId': widget.projectId,
//       'userId': widget.userId,
//       'daysNeeded': daysNeeded,
//       'price': price,
//       'status': 'pending',
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     setState(() {
//       requestStatus = 'pending';
//       requestId = newRequest.id;
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('requestSent'.tr())),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.share),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: ListView(
//           children: [
//             Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                     child: Image.asset(
//                       'assets/images/three.jpg',
//                       width: double.infinity,
//                       height: 150,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('${'title'.tr()}: home', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                         SizedBox(height: 8),
//                         Text('${'description'.tr()}: lol xd lamfo', style: TextStyle(fontSize: 16, color: Colors.black54)),
//                         SizedBox(height: 8),
//                         Text('${'projectDuration'.tr()}: 1000- 2000', style: TextStyle(fontSize: 16, color: Colors.black54)),
//                         SizedBox(height: 8),
//                         Text('${'expectedDelivery'.tr()}: 20', style: TextStyle(fontSize: 16, color: Colors.black54)),
//                         SizedBox(height: 8),
//                         Text('${'requiredSkills'.tr()}: hmafa', style: TextStyle(fontSize: 16, color: Colors.black54)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//
//             if (requestStatus == 'none')
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _daysController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: 'requiredDays'.tr(),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           controller: _priceController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: 'priceInDollars'.tr(),
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   MaterialButton(
//                     height: 56,
//                     minWidth: double.infinity,
//                     color: Color(0XFF003366),
//                     textColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     child: Text('submitRequest'.tr()),
//                     onPressed: sendRequest,
//                   ),
//                 ],
//               )
//             else if (requestStatus == 'pending')
//               Container(
//                 padding: EdgeInsets.all(12),
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.cyan,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: MaterialButton(
//                   height: 56,
//                   minWidth: double.infinity,
//                   textColor: Colors.red,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   child: Text('waitingApproval'.tr()),
//                   onPressed: null,
//                 ),
//               )
//             else if (requestStatus == 'accepted')
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.check_circle, color: Colors.green),
//                     SizedBox(width: 10),
//                     MaterialButton(
//                       height: 56,
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.chat),
//                           SizedBox(width: 5),
//                           Text('openChat'.tr()),
//                         ],
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ChatContractorScreen(
//                               projectId: widget.projectId,
//                               ownerId: widget.userId,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 )
//               else if (requestStatus == 'rejected')
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.cancel, color: Colors.red),
//                       SizedBox(width: 10),
//                       Text('requestRejected'.tr(), style: TextStyle(fontSize: 16, color: Colors.red)),
//                     ],
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
