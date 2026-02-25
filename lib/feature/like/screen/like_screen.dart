import 'package:flutter/material.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  final List<Map<String, dynamic>> users = const [
    {
      "name": "Sohan",
      "age": 22,
      "image": "https://randomuser.me/api/portraits/men/21.jpg",
      "verified": false,
    },
    {
      "name": "Krish",
      "age": 23,
      "image": "https://randomuser.me/api/portraits/men/22.jpg",
      "verified": true,
    },
    {
      "name": "Aryan",
      "age": 21,
      "image": "https://randomuser.me/api/portraits/men/23.jpg",
      "verified": true,
    },
    {
      "name": "Sagar",
      "age": 24,
      "image": "https://randomuser.me/api/portraits/men/24.jpg",
      "verified": false,
    },
    {
      "name": "Rohit",
      "age": 25,
      "image": "https://randomuser.me/api/portraits/men/25.jpg",
      "verified": false,
    },
    {
      "name": "Karan",
      "age": 26,
      "image": "https://randomuser.me/api/portraits/men/26.jpg",
      "verified": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Likes'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pink,
            tabs: [
              Tab(text: '0 Likes'),
              Tab(text: 'Likes Sent'),
              Tab(text: 'Top Picks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGrid(),
            _buildGrid(),
            _buildGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: users.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          final user = users[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  user['image'],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Row(
                    children: [
                      Text(
                        "${user['name']}, ${user['age']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (user['verified'])
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 16,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}