import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(CupertinoIcons.search, size: 18, color: Color(0xFF777777)),
                    SizedBox(width: 6),
                    Text('Looking for',
                        style: TextStyle(fontSize: 16, color: Color(0xFF777777))),
                  ],
                ),
                SizedBox(height: 6),
                Text("😍  New friends",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                Divider(height: 22),

                Text("Open to exploring", style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),

                Text("“  About Me",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF777777))),
                Text("simple trustable",
                    style: TextStyle(
                        fontSize: 16, height: 1.45, color: Color(0xFF777777))),
              ],
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(Icons.person, "Essentials"),
                _dividerItem(Icons.location_on_outlined, "7 km"),
                _dividerItem(Icons.woman, "Woman"),
                _dividerItem(Icons.favorite_outline, "Straight"),
                _dividerItem(Icons.height, "5ft 9in"),
                _dividerItem(Icons.school_outlined, "Bharti Vidyapeeth University"),
                _dividerItem(Icons.home_outlined, "Pune"),
                _dividerItem(Icons.person_outline, "She/Her"),
                _dividerItem(Icons.language, "English/Marathi", isLast: true),
              ],
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("“  I Want someone who",
                    style: TextStyle(fontSize: 18, color: Color(0xFF777777))),
                SizedBox(height: 6),
                Text("Understand my feelings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(Icons.folder_open, "More about me"),
                _infoRow(Icons.sentiment_neutral_outlined,
                    "Family Plans", "I don’t want children"),
                _infoRow(Icons.favorite_border,
                    "Love Style", "Thoughtful gestures"),
                _infoRow(Icons.school_outlined,
                    "Education", "Bachelor degree"),
                _infoRow(Icons.chat_bubble_outline,
                    "Communication style", "I stay on Whatsapp all day",
                    isLast: true),
                SizedBox(height: 10),
                _viewAll(),
              ],
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(Icons.folder_open, "Lifestyle"),
                _infoRow(Icons.fitness_center_outlined, "Workout", "Often"),
                _infoRow(Icons.local_bar_outlined,
                    "Drinking", "Socially, at the weekend"),
                _infoRow(Icons.smoke_free_outlined,
                    "How do you smoke?", "Non-smoker"),
                _infoRow(Icons.pets_outlined, "Pets", "Cat", isLast: true),
                SizedBox(height: 10),
                _viewAll(),
              ],
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(Icons.auto_awesome, "Interests"),
                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _chip("90s kid"),
                    _chip("Biryani"),
                    _chip("Dancing"),
                  ],
                ),
              ],
            ),
          ),

          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(Icons.weekend_outlined, "My Weekends"),
                _weekendRow("Weekends are for", "Recharging"),
                _weekendRow("Saturday night looks like", "Cosy nights in"),
                _weekendRow("Sunday looks like", "Sunday funday"),
              ],
            ),
          ),

          _card(
            Center(child: Text('Share Shraddhaa',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
          ),


          _card(
            Center(child: Text('Block Shraddhaa',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)),
          ),

          _card(
            Center(child: Text('Report Shraddhaa',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.red),)),
          ),

          SizedBox(height: 120),
        ],
      ),
    );
  }

  /// ---------- CARD ----------
  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0xFF777777), width: 0.3),
      ),
      child: child,
    );
  }

  /// ---------- HEADER ----------
  Widget _sectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(title,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  /// ---------- DIVIDER ITEM ----------
  Widget _dividerItem(IconData icon, String text, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Color(0xFF777777)),
            const SizedBox(width: 12),
            Text(text,
                style: const TextStyle(fontSize: 16, color: Color(0xFF777777))),
          ],
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: Colors.grey.withOpacity(0.20)),
          )
      ],
    );
  }

  /// ---------- INFO ROW WITH ICON ----------
  Widget _infoRow(IconData icon, String title, String value,
      {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: Color(0xFF777777)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(value,
                        style: const TextStyle(
                            fontSize: 15, color: Color(0xFF777777))),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: Colors.grey.withOpacity(0.20))
      ],
    );
  }

  /// ---------- CHIP ----------
  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }

  /// ---------- WEEKEND ROW ----------
  Widget _weekendRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, size: 18, color: Colors.green),
              const SizedBox(width: 8),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }

  /// ---------- VIEW ALL ----------
  Widget _viewAll() {
    return const Center(
      child: Text("View all ⌄",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }
}