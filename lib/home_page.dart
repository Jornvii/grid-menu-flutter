import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> menuItems = [
    {"title": "Home", "icon": Icons.home, "color": Colors.blue},
    {"title": "Search", "icon": Icons.search, "color": Colors.green},
    {"title": "Notifications", "icon": Icons.notifications, "color": Colors.red},
    {"title": "Settings", "icon": Icons.settings, "color": Colors.orange},
    {"title": "Favorites", "icon": Icons.favorite, "color": Colors.pink},
    {"title": "Profile", "icon": Icons.person, "color": Colors.purple},
    {"title": "Messages", "icon": Icons.message, "color": Colors.teal},
    {"title": "Calendar", "icon": Icons.calendar_today, "color": Colors.indigo},
    {"title": "Maps", "icon": Icons.map, "color": Colors.cyan},
    {"title": "Weather", "icon": Icons.cloud, "color": Colors.grey},
    {"title": "Contacts", "icon": Icons.contacts, "color": Colors.amber},
    {"title": "Camera", "icon": Icons.camera, "color": Colors.deepOrange},
    {"title": "Music", "icon": Icons.music_note, "color": Colors.purpleAccent},
    {"title": "Videos", "icon": Icons.video_library, "color": Colors.tealAccent},
    {"title": "Gallery", "icon": Icons.photo, "color": Colors.lightBlue},
  ];

  final PageController _pageController = PageController();
  final int itemsPerPage = 12;
  final double gridSpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Launcher'),
        actions: [
          IconButton(
            icon: const Icon(Icons.apps),
            onPressed: () {
              // Handle app drawer
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: (menuItems.length / itemsPerPage).ceil(),
              itemBuilder: (context, pageIndex) {
                final startIndex = pageIndex * itemsPerPage;
                final endIndex = (startIndex + itemsPerPage < menuItems.length)
                    ? startIndex + itemsPerPage
                    : menuItems.length;

                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GridView.builder(
                    padding: EdgeInsets.all(gridSpacing),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: gridSpacing,
                      mainAxisSpacing: gridSpacing,
                    ),
                    itemCount: endIndex - startIndex,
                    itemBuilder: (context, index) {
                      final item = menuItems[startIndex + index];
                      return Container(
                        decoration: BoxDecoration(
                          color: item["color"],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            if (item["title"] == "Music") {
                              Navigator.pushNamed(context, '/music');
                            } else {
                              print('${item["title"]} tapped');
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                item["icon"],
                                size: 40,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item["title"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildPageIndicators(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle action
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            (menuItems.length / itemsPerPage).ceil(),
            (index) => AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                final currentPage = _pageController.hasClients ? _pageController.page ?? 0 : 0;
                final isActive = (currentPage.round() == index);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
