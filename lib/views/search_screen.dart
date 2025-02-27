import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  List<String> allResults = [
    "Adobe XD",
    "Adobe Photoshop",
    "Adobe Illustrator",
    "Adobe InDesign",
  ];

  List<String> filteredResults = [];
  List<String> recentSearches = [
    "Excepteur sint occaecat",
    "Cupidatat non",
    "Sunt in culpa qui officia",
    "Another Item",
  ];
  String query = "";

  @override
  void initState() {
    super.initState();
    filteredResults = allResults;
    searchController.addListener(() {
      setState(() {
        query = searchController.text;
        _filterResults(query);
      });
    });
  }

  void _filterResults(String query) {
    if (query.isEmpty) {
      filteredResults = allResults;
    } else {
      filteredResults = allResults
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'search'.tr(),
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
          ),
        ),
        backgroundColor: const Color(0xFF6C89A4),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  break;
                case 'help':
                  break;
                case 'logout':
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'settings',
                  child: Text('settings'.tr()),
                ),
                PopupMenuItem(
                  value: 'help',
                  child: Text('help'.tr()),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text('logout'.tr()),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.filter_list),
                  hintText: 'searchHint'.tr(),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  if (query.isEmpty) ...[
                    Text(
                      'topResults'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildListSection(allResults),
                    const SizedBox(height: 20),
                    Text(
                      'recentSearches'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildListSection(recentSearches),
                  ] else ...[
                    Text(
                      'searchResults'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildListSection(filteredResults),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF6C89A4),
    );
  }

  Widget _buildListSection(List<String> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: items.map((item) {
          return ListTile(
            leading: const Icon(Icons.search, color: Color(0xFF6C89A4)),
            title: Text(item),
            onTap: () {
              // Do something when an item is tapped
            },
          );
        }).toList(),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController searchController = TextEditingController();
//
//   List<String> allResults = [
//     "Adobe XD",
//     "Adobe Photoshop",
//     "Adobe Illustrator",
//     "Adobe InDesign",
//   ];
//
//   List<String> filteredResults = [];
//   List<String> recentSearches = [
//     "Excepteur sint occaecat",
//     "Cupidatat non",
//     "Sunt in culpa qui officia",
//     "Another Item",
//   ];
//   String query = "";
//
//   @override
//   void initState() {
//     super.initState();
//     filteredResults = allResults; // Initialize with all results
//     searchController.addListener(() {
//       setState(() {
//         query = searchController.text;
//         _filterResults(query);
//       });
//     });
//   }
//
//   void _filterResults(String query) {
//     if (query.isEmpty) {
//       filteredResults = allResults;
//     } else {
//       filteredResults = allResults
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'SEARCH',
//             style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
//           ),
//         ),
//         backgroundColor: const Color(0xFF6C89A4),
//         actions: [
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert),
//             onSelected: (value) {
//               switch (value) {
//                 case 'Settings':
//                   break;
//                 case 'Help':
//                   break;
//                 case 'Logout':
//                   break;
//               }
//             },
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem(
//                   value: 'Settings',
//                   child: Text('Settings'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'Help',
//                   child: Text('Help'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'Logout',
//                   child: Text('Logout'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xFF6C89A4),
//               ),
//               child: Center(
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.search),
//               title: const Text('Search'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.black, width: 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.search),
//                   suffixIcon: Icon(Icons.filter_list),
//                   hintText: 'Search',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   if (query.isEmpty) ...[
//                     Text(
//                       'Top Results',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     _buildListSection(allResults),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Recent Searches',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     _buildListSection(recentSearches),
//                   ] else ...[
//                     Text(
//                       'Search Results',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     _buildListSection(filteredResults),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: const Color(0xFF6C89A4),
//     );
//   }
//
//   Widget _buildListSection(List<String> items) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: items.map((item) {
//           return ListTile(
//             leading: const Icon(Icons.search, color: Color(0xFF6C89A4)),
//             title: Text(item),
//             onTap: () {
//               // Do something when an item is tapped
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
