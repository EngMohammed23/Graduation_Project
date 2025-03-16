import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takatuf/model/owner/home_owner_controller.dart';
import 'package:takatuf/views/contractor/project_details_screen.dart';

import '../owner/requests_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _recentSearches = [];
  final controller = Get.put(HomeOwnerController());

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<String> getCurrentUserType() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId == null) {
        print("❌ لم يتم العثور على معرف المستخدم في SharedPreferences");
        return "Unknown";
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        return userDoc['userType'] ?? "Unknown";
      } else {
        print("❌ المستخدم غير موجود في Firestore");
        return "Unknown";
      }
    } catch (e) {
      print("❌ خطأ أثناء جلب نوع المستخدم: $e");
      return "Error";
    }
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  Future<void> _saveSearchQuery(String query) async {
    if (query.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 5) {
        _recentSearches = _recentSearches.sublist(0, 5);
      }
      prefs.setStringList('recent_searches', _recentSearches);
    });
  }

  Future<void> _searchProjects(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('projects').get();

    List<Map<String, dynamic>> filteredResults = snapshot.docs
        .map((doc) => {
      "id": doc.id,
      ...doc.data() as Map<String, dynamic>,
    })
        .where((project) =>
    project.containsKey('title') &&
        project['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchResults = filteredResults;
    });

    _saveSearchQuery(query);
  }

  void _clearRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches.clear();
      prefs.remove('recent_searches');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text("بحث عن المشاريع", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 1)
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "ابحث عن مشروع...",
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onSubmitted: _searchProjects,
              ),
            ),

            SizedBox(height: 10),

            if (_recentSearches.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("عمليات البحث الأخيرة:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: _clearRecentSearches,
                        child: Text("مسح الكل", style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    children: _recentSearches.map((query) {
                      return ActionChip(
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        label: Text(query, style: TextStyle(color: Colors.blueAccent)),
                        onPressed: () {
                          _searchController.text = query;
                          _searchProjects(query);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),

            SizedBox(height: 10),

            Expanded(
              child: _searchResults.isEmpty
                  ? Center(child: Text("لا توجد نتائج بعد", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  var project = _searchResults[index];

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.business, color: Colors.white),
                      ),
                      title: Text(
                        project['title'] ?? "بدون عنوان",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "مدة التنفيذ: ${project['expectedDelivery'] ?? 'غير محددة'} يوم",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? userId = prefs.getString('userId');

                        if (userId == null) {
                          print("❌ لم يتم العثور على معرف المستخدم في SharedPreferences");
                          return;
                        }

                        DocumentSnapshot userDoc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .get();

                        String email = userDoc.exists ? userDoc['email'] ?? "" : "";

                        getCurrentUserType().then((userType) {
                          if (userType == "Owner") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RequestsScreen(projectId: project['id']),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectDetailsScreen(
                                  projectId: project['id'],
                                  userId: userId,
                                  email: email,
                                  project: project,
                                ),
                              ),
                            );
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/instance_manager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:takatuf/model/owner/home_owner_controller.dart';
// import 'package:takatuf/views/contractor/project_details_screen.dart';
//
// import '../owner/requests_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];
//   List<String> _recentSearches = [];
//   final controller = Get.put(HomeOwnerController());
//
//
//   @override
//   void initState() {
//     super.initState();
//     _loadRecentSearches();
//   }
//
//   Future<String> getCurrentUserType() async {
//     try {
//       // جلب userId من SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? userId = prefs.getString('userId'); // تأكد من أن 'userId' هو المفتاح الصحيح المخزن
//
//       if (userId == null) {
//         print("❌ لم يتم العثور على معرف المستخدم في SharedPreferences");
//         return "Unknown";
//       }
//
//       // جلب بيانات المستخدم من Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users') // تأكد أن هذا هو اسم مجموعة المستخدمين
//           .doc(userId)
//           .get();
//
//       if (userDoc.exists) {
//         return userDoc['userType'] ?? "Unknown"; // إرجاع نوع المستخدم أو "Unknown" إذا لم يكن موجودًا
//       } else {
//         print("❌ المستخدم غير موجود في Firestore");
//         return "Unknown";
//       }
//     } catch (e) {
//       print("❌ خطأ أثناء جلب نوع المستخدم: $e");
//       return "Error";
//     }
//   }
//   // تحميل عمليات البحث الأخيرة من التخزين المحلي
//   Future<void> _loadRecentSearches() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _recentSearches = prefs.getStringList('recent_searches') ?? [];
//     });
//   }
//
//   // حفظ عمليات البحث الأخيرة
//   Future<void> _saveSearchQuery(String query) async {
//     if (query.isEmpty) return;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _recentSearches.remove(query);
//       _recentSearches.insert(0, query);
//       if (_recentSearches.length > 5) {
//         _recentSearches = _recentSearches.sublist(0, 5); // الاحتفاظ بآخر 5 عمليات بحث
//       }
//       prefs.setStringList('recent_searches', _recentSearches);
//     });
//   }
//
//   // البحث في Firestore مع فلترة داخل التطبيق لدعم البحث الجزئي
//   Future<void> _searchProjects(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }
//
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('projects').get();
//
//     List<Map<String, dynamic>> filteredResults = snapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .where((project) =>
//         project['description'].toString().toLowerCase().contains(query.toLowerCase()))
//         .toList();
//
//     setState(() {
//       _searchResults = filteredResults;
//     });
//
//     _saveSearchQuery(query);
//   }
//
//   // مسح عمليات البحث الأخيرة
//   void _clearRecentSearches() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _recentSearches.clear();
//       prefs.remove('recent_searches');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("بحث عن المشاريع", style: TextStyle(color: Colors.white)),
//         backgroundColor: Color(0xFF003366),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           children: [
//             // حقل البحث المحسن بتصميم أنيق
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//                 boxShadow: [
//                   BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 1)
//                 ],
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: "ابحث عن مشروع...",
//                   prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 ),
//                 onSubmitted: _searchProjects,
//               ),
//             ),
//
//             SizedBox(height: 10),
//
//             // عرض عمليات البحث الأخيرة
//             if (_recentSearches.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("عمليات البحث الأخيرة:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       TextButton(
//                         onPressed: _clearRecentSearches,
//                         child: Text("مسح الكل", style: TextStyle(color: Colors.redAccent)),
//                       ),
//                     ],
//                   ),
//                   Wrap(
//                     spacing: 8,
//                     children: _recentSearches.map((query) {
//                       return ActionChip(
//                         backgroundColor: Colors.blueAccent.withOpacity(0.2),
//                         label: Text(query, style: TextStyle(color: Colors.blueAccent)),
//                         onPressed: () {
//                           _searchController.text = query;
//                           _searchProjects(query);
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//
//             SizedBox(height: 10),
//
//             // عرض نتائج البحث
//             Expanded(
//               child: _searchResults.isEmpty
//                   ? Center(child: Text("لا توجد نتائج بعد", style: TextStyle(color: Colors.grey)))
//                   : ListView.builder(
//                 itemCount: _searchResults.length,
//                 itemBuilder: (context, index) {
//                   var project = _searchResults[index];
//                   final projects = controller.projects[index];
//
//                   return Card(
//                     elevation: 3,
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.blueAccent,
//                         child: Icon(Icons.business, color: Colors.white),
//                       ),
//                       title: Text(
//                         project['description'],
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                         project['status'] ?? "بدون حالة",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       onTap: () {
//                         getCurrentUserType().then((userType) {
//                           if (userType == "Owner") {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => RequestsScreen(projectId: projects.id),
//                               ),
//                             );                            // ضع هنا الكود الخاص بالمالك
//                           } else {
//                             // Navigator.push(
//                             //   context,
//                             //   MaterialPageRoute(
//                             //     builder: (context) => ProjectDetailsScreen(projectId: projects.id, userId: userId, email: , project: project),
//                             //   ),
//                             // );                            // ضع هنا الكود الخاص بغير المالك
//                           }
//                         });
//
//
//
//                         // يمكنك إضافة تنقل إلى صفحة تفاصيل المشروع هنا
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.grey[200],
//     );
//   }
// }
