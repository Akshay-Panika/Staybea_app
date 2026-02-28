import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// ================= CARD 1 =================
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _smallTitle(CupertinoIcons.search, "Looking for"),
              const SizedBox(height: 6),
              const Text("😍  New friends",
                  style:
                  TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              const Divider(height: 22),

              _pill("Open to exploring"),
              const SizedBox(height: 16),

              _quoteTitle("“  About Me"),
              const SizedBox(height: 6),

              const Text(
                "I am a highly motivated and results-oriented professional with a passion for creative problem-solving. "
                    "I am currently seeking new opportunities to apply my skills in [Your Field] to drive meaningful results]",
                style: TextStyle(fontSize: 13.5, height: 1.45),
              ),
            ],
          ),
        ),

        /// ================= ESSENTIALS =================
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(Icons.person, "Essentials"),

              _dividerItem(Icons.location_on_outlined, "7 km"),
              _dividerItem(Icons.wc_outlined, "Woman"),
              _dividerItem(Icons.favorite_outline, "Straight"),
              _dividerItem(Icons.height, "5ft 9in"),
              _dividerItem(Icons.school_outlined,
                  "Bharti Vidyapeeth University"),
              _dividerItem(Icons.home_outlined, "Pune"),
              _dividerItem(Icons.person_outline, "She/Her"),
              _dividerItem(Icons.language, "English/Marathi", isLast: true),
            ],
          ),
        ),

        /// ================= WANT =================
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("“  I Want someone who",
                  style: TextStyle(fontSize: 13, color: Colors.black54)),
              SizedBox(height: 6),
              Text("Understand my feelings",
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        ),

        /// ================= MORE ABOUT =================
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(Icons.folder_open, "More about me"),
              _infoRow("Family Plans", "I don’t want children"),
              _infoRow("Love Style", "Thoughtful gestures"),
              _infoRow("Education", "Bachelor degree"),
              _infoRow("Communication style", "I stay on Whatsapp all day"),
              _viewAll(),
            ],
          ),
        ),

        /// ================= LIFESTYLE =================
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(Icons.folder_open, "Lifestyle"),
              _infoRow("Workout", "Often"),
              _infoRow("Drinking", "Socially, at the weekend"),
              _infoRow("How do you smoke?", "Non-smoker"),
              _infoRow("Pets", "Cat"),
              _viewAll(),
            ],
          ),
        ),

        /// ================= INTERESTS =================
        _card(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(Icons.auto_awesome, "Interests"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _pill("90s kid"),
                  _pill("Biryani"),
                  _pill("Dancing"),
                ],
              ),
            ],
          ),
        ),

        /// ================= WEEKENDS =================
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
      ],
    );
  }

  /// ---------- CARD ----------
  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  /// ---------- SMALL TITLE ----------
  Widget _smallTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 6),
        Text(text,
            style: const TextStyle(fontSize: 13, color: Colors.black54)),
      ],
    );
  }

  Widget _quoteTitle(String text) {
    return const Text(
      "“  About Me",
      style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }

  /// ---------- SECTION HEADER ----------
  Widget _sectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(title,
              style:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  /// ---------- LIST ITEM ----------
  Widget _dividerItem(IconData icon, String text, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.black54),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 14)),
          ],
        ),
        if (!isLast)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1),
          )
      ],
    );
  }

  /// ---------- INFO ROW ----------
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value,
              style:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const Divider(height: 18),
        ],
      ),
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
              style:
              const TextStyle(fontSize: 13, color: Colors.black54)),
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

  /// ---------- CHIP ----------
  Widget _pill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }

  Widget _viewAll() {
    return const Padding(
      padding: EdgeInsets.only(top: 6),
      child: Center(
        child: Text("View all ⌄",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ),
    );
  }
}