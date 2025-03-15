import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  // تحميل عمليات البحث الأخيرة من التخزين المحلي
  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  // حفظ عمليات البحث الأخيرة
  Future<void> _saveSearchQuery(String query) async {
    if (query.isEmpty) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentSearches.remove(query);
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 5) {
        _recentSearches = _recentSearches.sublist(0, 5); // الاحتفاظ بآخر 5 عمليات بحث
      }
      prefs.setStringList('recent_searches', _recentSearches);
    });
  }

  // البحث في Firestore مع فلترة داخل التطبيق لدعم البحث الجزئي
  Future<void> _searchProjects(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('projects').get();

    List<Map<String, dynamic>> filteredResults = snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .where((project) =>
        project['description'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchResults = filteredResults;
    });

    _saveSearchQuery(query);
  }

  // مسح عمليات البحث الأخيرة
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
        title: Text("بحث عن المشاريع", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF003366),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // حقل البحث المحسن بتصميم أنيق
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

            // عرض عمليات البحث الأخيرة
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

            // عرض نتائج البحث
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
                        project['description'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        project['status'] ?? "بدون حالة",
                        style: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        // يمكنك إضافة تنقل إلى صفحة تفاصيل المشروع هنا
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
