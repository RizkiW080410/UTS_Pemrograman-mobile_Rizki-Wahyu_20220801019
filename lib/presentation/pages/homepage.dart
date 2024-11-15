import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uts_pemmob/data/wisata_data.dart';
import 'package:uts_pemmob/models/wisata_model.dart';
import '../../core/navigation_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Wisata> filteredWisata = wisataList;
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> welcomeImages = [
    'assets/images/wonderfull.jpg',
    'assets/images/nusa_pendia.jpg',
    'assets/images/Borobudur.jpg',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < welcomeImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void filterSearch(String query) {
    setState(() {
      filteredWisata = wisataList.where((wisata) {
        return wisata.name.toLowerCase().contains(query.toLowerCase()) ||
            wisata.region.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wisata Indonesia")),
      body: Column(
        children: [
          Container(
            height: 200.0,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: welcomeImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      welcomeImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterSearch,
              decoration: InputDecoration(
                labelText: 'Cari Wisata',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: filteredWisata.length,
              itemBuilder: (context, index) {
                final wisata = filteredWisata[index];
                return GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo('/detail', arguments: wisata);
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          wisata.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8.0,
                        left: 8.0,
                        right: 8.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wisata.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              wisata.region,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
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
    );
  }
}
