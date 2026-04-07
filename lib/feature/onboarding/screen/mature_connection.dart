import 'package:flutter/material.dart';

class MatureConnection extends StatelessWidget {
  const MatureConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.tune, color: Colors.grey),
          onPressed: () {},
        ),
        title: const Text(
          'Golden Years',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.deepOrangeAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Main Profile Card
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: NetworkImage('https://picsum.photos/500/900?random=11'), // Replace with actual asset
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Margaret, 68',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'A warm smile and a love for the fine things in life. Looking for...',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 40), // Space for action buttons
                      ],
                    ),
                  ),
                ),
                // Action Buttons (X, Heart, Star)
                Positioned(
                  bottom: -30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(Icons.close, Colors.black, Colors.white),
                      const SizedBox(width: 20),
                      _buildActionButton(Icons.favorite, Colors.white, Colors.deepOrangeAccent, isLarge: true),
                      const SizedBox(width: 20),
                      _buildActionButton(Icons.star, Colors.teal, Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Interest Chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildInterestChip('Gardening', Icons.local_florist, const Color(0xFFFFEBE6), Colors.deepOrangeAccent),
                _buildInterestChip('Opera', Icons.music_note, const Color(0xFFE6F9F6), Colors.teal),
                _buildInterestChip('Fine Dining', Icons.restaurant, const Color(0xFFF2F2F2), Colors.black54),
              ],
            ),
            const SizedBox(height: 25),
            // Bio Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Margaret is looking for a genuine connection with someone who appreciates the arts and quiet mornings in the garden. She enjoys traveling to historic cities and has a passion for classical music.',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Read full story',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Colors.deepOrangeAccent, size: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color iconColor, Color bgColor, {bool isLarge = false}) {
    return Container(
      width: isLarge ? 75 : 60,
      height: isLarge ? 75 : 60,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(icon, color: iconColor, size: isLarge ? 35 : 28),
    );
  }

  Widget _buildInterestChip(String label, IconData icon, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: textColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}