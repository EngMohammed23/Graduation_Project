import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  final List<String> _projectImages = [
    'assets/images/three.jpg',
    'assets/images/three.jpg',
    'assets/images/three.jpg',
    'assets/images/three.jpg',
  ];
  final List<String> _projectNames = [
    'Sound of Sky',
    'Girl on Fire',
    'Sound of Sky',
    'Girl on Fire',
  ];
  final List<String> _projectDescriptions = [
    'Dilon Bruce',
    'Alecia Keys',
    'Dilon Bruce',
    'Alecia Keys',
  ];
  final List<String> _projectPrices = [
    '\$39',
    '\$50',
    '\$90',
    '\$80',
  ];

  final List<String> _contractorImages = [
    'assets/images/three.jpg',
    'assets/images/three.jpg',
    'assets/images/three.jpg',
  ];
  final List<String> _contractorNames = [
    'Sound of Sky',
    'Girl on Fire',
    'Sound of Sky',
  ];
  final List<String> _contractorDescriptions = [
    'Dilon Bruce',
    'Alecia Keys',
    'Dilon Bruce',
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6C89A4),
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/setting_screen');
                },
                icon: Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/favorites_screen');
                },
                icon: Icon(Icons.favorite),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/three.jpg',
                width: double.infinity,
                height: 182,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Projects',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF979797),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _projectImages.length,
                separatorBuilder: (context, index) => const SizedBox(width: 13),
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFCDD4D9),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            _projectImages[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _projectNames[index],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _projectDescriptions[index],
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF979797),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _projectPrices[index],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contractors',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF979797),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _contractorImages.length,
                separatorBuilder: (context, index) => const SizedBox(width: 13),
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFFCDD4D9),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              _contractorImages[index],
                              width: 120,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _contractorNames[index],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _contractorDescriptions[index],
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF636363),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
