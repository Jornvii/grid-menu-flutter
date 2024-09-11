import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool _isPlaying = false;
  double _sliderValue = 0.5;
  int _currentIndex = 0;

  final List<Map<String, String>> _albums = [
    {"title": "Skull", "artist": "Vannda", "image": "https://cdn.kiripost.com/static/images/photo_2023-06-13_16-49-51.2e16d0ba.fill-960x540.jpg"},
    {"title": "Album 1", "artist": "Vannda", "image": "https://wheninphnompenh.com/wp-content/uploads/2023/05/DSC_0078-1024x1024.jpg"},
    {"title": "Album 2", "artist": "Vannda", "image": "https://viberate-upload.ams3.cdn.digitaloceanspaces.com/prod/entity/artist/vannda-D0gcS"},
    // Add more albums here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
        backgroundColor: Colors.green[800], 
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildMusicList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final currentAlbum = _albums[_currentIndex];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[800], 
        image: DecorationImage(
          image: NetworkImage(currentAlbum["image"]!), 
          fit: BoxFit.cover,
        ),
        boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Now Playing',
            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(currentAlbum["image"]!),
                radius: 50,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentAlbum["title"]!, style: const TextStyle(fontSize: 18, color: Colors.white)),
                  Text(currentAlbum["artist"]!, style: TextStyle(color: Colors.grey[300])),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    final String elapsed = '01:23';
    final String totalDuration = '03:45';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(elapsed, style: TextStyle(color: Colors.grey[300])),
            Text(totalDuration, style: TextStyle(color: Colors.grey[300])),
          ],
        ),
        Slider(
          value: _sliderValue,
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
          },
          activeColor: Colors.green, 
          inactiveColor: Colors.grey[800],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous, color: Colors.white),
              onPressed: () {
                setState(() {
                  _currentIndex = (_currentIndex - 1 + _albums.length) % _albums.length;
                });
              },
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next, color: Colors.white),
              onPressed: () {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % _albums.length;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Vannda - ${_albums[_currentIndex]["title"]}',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildMusicList() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _albums.length,
      itemBuilder: (context, index) {
        final album = _albums[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index;
              _isPlaying = true; 
            });
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(album["image"]!),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 8)],
            ),
            child: Center(
              child: Text(
                album["title"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.black45, 
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
