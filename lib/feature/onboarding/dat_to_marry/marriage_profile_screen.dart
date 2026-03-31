import 'package:flutter/material.dart';

class MarriageProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profile;
  final String heroTag;

  const MarriageProfileScreen({
    super.key,
    required this.profile,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final List images = profile['images'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: heroTag,
                  child: Image.network(
                    images[0],
                    height: 650,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  height: 650,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 16,
                  child: _circleIcon(Icons.arrow_back, () {
                    Navigator.pop(context);
                  }),
                ),

                Positioned(
                  top: 40,
                  right: 16,
                  child: _circleIcon(Icons.more_vert, () {}),
                ),

                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: Colors.red, size: 28),
                  ),
                ),

                Positioned(
                  left: 16,
                  right: 80,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: profile['isOnline'] ? Colors.green : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            "${profile['name']} ${profile['age']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.verified, color: Colors.blue, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  "${profile['matchPercent']}%",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${profile['height']} • ${profile['community']}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${profile['location']} • ${profile['rangeKM']} away",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.work_outline, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            profile['profession'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 🔥 ABOUT ME
            _sectionCard(
              title: "About me",
              child: Column(
                children: [
                  const Text(
                    "Calm, positive person who enjoys gardening, music, and good conversations. Looking for someone to share simple happy moments with.",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "View more",
                    style: TextStyle(color: Colors.pink),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 HOBBIES
            _sectionCard(
              title: "Hobbies & Interests",
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _chip(Icons.flight, "Travelling"),
                  _chip(Icons.movie, "Movies"),
                  _chip(Icons.camera_alt, "Photography"),
                  _chip(Icons.hiking, "Trekking"),
                  _chip(Icons.restaurant, "Cooking"),
                  _chip(Icons.brush, "Doodling"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 BASIC DETAILS
            _sectionCard(
              title: "Basic details",
              child: Column(
                children: [
                  // Tag chips row 1
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _outlineTag("Managed by myself"),
                      _outlineTag(
                        "ID ${profile['id'] ?? 'SB67584945'}",
                        icon: Icons.copy,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Tag chips row 2
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _outlineTag("${profile['age']} yrs old"),
                      _outlineTag("Height - ${profile['height']}"),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // 2-column detail grid
                  _detailGrid([
                    {
                      "icon": Icons.cake_outlined,
                      "label": "Birth date",
                      "value": "** ** ****",
                      "verified": true,
                    },
                    {
                      "icon": Icons.person_outline,
                      "label": "Gender",
                      "value": profile['gender'] ?? "Women",
                    },
                    {
                      "icon": Icons.menu_book_outlined,
                      "label": "Religion",
                      "value": profile['religion'] ?? "Hindu",
                    },
                    {
                      "icon": Icons.groups_outlined,
                      "label": "Community",
                      "value": profile['community'] ?? "Deshast Brahmin",
                    },
                    {
                      "icon": Icons.restaurant_outlined,
                      "label": "Diet Preferences",
                      "value": profile['diet'] ?? "Vegetarian",
                    },
                    {
                      "icon": Icons.wb_sunny_outlined,
                      "label": "Sunsign",
                      "value": profile['sunsign'] ?? "Scorpio",
                    },
                    {
                      "icon": Icons.location_on_outlined,
                      "label": "Live in",
                      "value": profile['location'] ?? "Pune, Maharashtra, India.",
                    },
                    {
                      "icon": Icons.favorite_border,
                      "label": "Marital Status",
                      "value": profile['maritalStatus'] ?? "Widowed",
                    },
                    {
                      "icon": Icons.chat_bubble_outline,
                      "label": "Communication",
                      "value": profile['communication'] ?? "Phone caller",
                    },
                    {
                      "icon": Icons.volunteer_activism_outlined,
                      "label": "Love Style",
                      "value": profile['loveStyle'] ?? "Compliments",
                    },
                  ]),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // Premium unlock
                  const Text(
                    "To unlock birth date",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC2185B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Get Premium Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── Outline tag chip ──────────────────────────────────────────────────────
  Widget _outlineTag(String text, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFC2185B), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)),
          if (icon != null) ...[
            const SizedBox(width: 6),
            Icon(icon, size: 14, color: Colors.black54),
          ],
        ],
      ),
    );
  }

  // ── 2-column detail grid ──────────────────────────────────────────────────
  Widget _detailGrid(List<Map<String, dynamic>> items) {
    final List<Widget> rows = [];
    for (int i = 0; i < items.length; i += 2) {
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _detailItem(items[i])),
            const SizedBox(width: 12),
            Expanded(
              child: i + 1 < items.length
                  ? _detailItem(items[i + 1])
                  : const SizedBox(),
            ),
          ],
        ),
      );
      if (i + 2 < items.length) rows.add(const SizedBox(height: 16));
    }
    return Column(children: rows);
  }

  Widget _detailItem(Map<String, dynamic> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(item['icon'] as IconData, size: 18, color: const Color(0xFFC2185B)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item['label'] as String,
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                  if (item['verified'] == true) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, size: 13, color: Colors.blue),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                item['value'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Existing helpers ──────────────────────────────────────────────────────
  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String text) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pink, width: 0.6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.pink),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}
