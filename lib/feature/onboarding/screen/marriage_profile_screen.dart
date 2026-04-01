import 'package:flutter/material.dart';

import '../../../core/utils/app_size.dart';

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
                  child: _circleIcon(Icons.more_vert, () {
                    _showMoreOptionsSheet(context);
                  }),
                ),

                Positioned(
                  right: 20,
                  bottom: 20,
                  child: InkWell(
                    onTap: () => _showConversationSheet(context),
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

            const SizedBox(height: 10),
            _sectionCard(
              title: "Explore photos",
              child: Column(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade200,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            profile['images'][0],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withOpacity(0.4),
                            colorBlendMode: BlendMode.darken,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.lock, size: 40, color: Colors.white),
                            SizedBox(height: 8),
                            Text(
                              "Locked Photos",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            _sectionCard(
              title: "Long term compatibility",
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC2185B)),
                  color: const Color(0xFFFCE4EC),
                ),
                child: const Text(
                  "\" I want someone who\nUnderstand my feelings\"",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            _sectionCard(
              title: "Lifestyle",
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _lifestyleItem(Icons.local_bar_outlined, "Drinking", "** ** ****"),
                      _lifestyleItem(Icons.pets_outlined, "Pets", "Dog"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _lifestyleItem(Icons.smoking_rooms_outlined, "Smoking", "Women"),
                      _lifestyleItem(Icons.fitness_center_outlined, "Workout", "Hindu"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

// 🔥 CAREER & EDUCATION
            _sectionCard(
              title: "Career & Education",
              child: Column(
                children: [
                  _detailGrid([
                    {
                      "icon": Icons.work_outline,
                      "label": "Profession",
                      "value": profile['profession'] ?? "Finance professional with a private company",
                      "verified": true,
                    },
                    {
                      "icon": Icons.business_outlined,
                      "label": "Company Name",
                      "value": "**************",
                      "verified": true,
                    },
                    {
                      "icon": Icons.account_balance_wallet_outlined,
                      "label": "Annual income",
                      "value": profile['income'] ?? "Doesn't wish to specify his income.",
                      "verified": true,
                    },
                    {
                      "icon": Icons.school_outlined,
                      "label": "Highest Qualification",
                      "value": profile['qualification'] ?? "M. com",
                      "verified": false,
                    },
                    {
                      "icon": Icons.menu_book_outlined,
                      "label": "Education field",
                      "value": profile['educationField'] ?? "Commerce",
                      "verified": false,
                    },
                    {
                      "icon": Icons.account_balance_outlined,
                      "label": "Collage Name",
                      "value": "**********",
                      "verified": false,
                    },
                  ]),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // Premium unlock
                  const Text(
                    "To unlock Company & Collage name",
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
            const SizedBox(height: 10),

// 🔥 FAMILY DETAILS
            _sectionCard(
              title: "Family Details",
              child: Column(
                children: [
                  _detailGrid([
                    {
                      "icon": Icons.people_outline,
                      "label": "Parent's Details",
                      "value": "Father runs a business\nMother is homemaker",
                    },
                    {
                      "icon": Icons.child_care_outlined,
                      "label": "No. of Children's",
                      "value": profile['children'] ?? "2",
                    },
                    {
                      "icon": Icons.home_outlined,
                      "label": "Children's living with me",
                      "value": profile['childrenLiving'] ?? "Yes",
                    },
                    {
                      "icon": Icons.group_outlined,
                      "label": "No of Siblings",
                      "value": profile['siblings'] ?? "1 Brother\n1 Sister (Married)",
                    },
                    {
                      "icon": Icons.location_on_outlined,
                      "label": "Family Location",
                      "value": profile['familyLocation'] ?? "Pune, Maharashtra, India.",
                    },
                  ]),
                ],
              ),
            ),

            const SizedBox(height: 10),

// 🔥 CONTACT DETAILS
            _sectionCard(
              title: "Contact Details",
              child: Column(
                children: [
                  _detailGrid([
                    {
                      "icon": Icons.phone_outlined,
                      "label": "Contact No.",
                      "value": "+91 8984******",
                      "verified": true,
                    },
                    {
                      "icon": Icons.email_outlined,
                      "label": "Email ID",
                      "value": "*******@gmail.com",
                      "verified": true,
                    },
                  ]),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  const Text(
                    "To unlock Contact & Email ID",
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
            const SizedBox(height: 10),

// 🔥 YOU & HIM
            _sectionCard(
              title: "You & Him",
              child: Column(
                children: [
                  // Profile photos with heart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profile['images'][0]),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(Icons.favorite, color: Colors.grey, size: 22),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profile['images'][0]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Match count
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: "You match ",
                        ),
                        TextSpan(
                          text: "5/7",
                          style: TextStyle(
                            color: Color(0xFFC2185B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: " of his Preferences"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // Preference match list
                  _preferenceRow("Age", "24 to 28", true),
                  _preferenceRow("Height", "5'' to 6'0\"", true),
                  _preferenceRow("Marital status", "Never Married", true),
                  _preferenceRow("Country Living in", "India", true),
                  _preferenceRow("State Living in", "India", true),
                  _preferenceRow("Annual Income", "Upto INR 7 Lakh", false),
                  _preferenceRow("Religion / Community", "Hindu : 96 kuli Maratha, Hindu : Mahar", false),

                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),

                  // Common between both
                  const Text(
                    "Common between the both of you",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _commonRow("You both have a Bachelor's degree"),
                  const SizedBox(height: 12),
                  _commonRow("He too is from the Marathi community"),
                  const SizedBox(height: 12),
                  _commonRow("He is a Capricorn - you both share the \"Earth\" zodiac element"),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background image (left side silhouette feel)
                    Image.network(
                      profile['images'][0], // replace with your astro bg image
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.45),
                      colorBlendMode: BlendMode.darken,
                    ),

                    // Gradient overlay (dark left, lighter right)
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.transparent,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),

                    // Content on right side
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "Astro Match",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  "Discover your star-aliened Compatibility and see how well your horoscope match!!!",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFC2185B),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 8,
                                    ),
                                  ),
                                  child: const Text(
                                    "Check Match",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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

  Widget _lifestyleItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFC2185B)),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.black45),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _preferenceRow(String label, String value, bool matched) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: matched ? const Color(0xFFC2185B) : Colors.grey.shade400,
                width: 1.5,
              ),
            ),
            child: Icon(
              matched ? Icons.check : Icons.close,
              size: 16,
              color: matched ? const Color(0xFFC2185B) : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _commonRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline,
            color: Color(0xFFC2185B), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

}

void _showConversationSheet(BuildContext context) {
  final TextEditingController messageController = TextEditingController();
  bool _superConnect = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: _superConnect
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  50.height,
                  const Text(
                    "You're one step closer.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Your connection sent.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  50.height,
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  50.height,
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Text(
                    "Start a conversation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Send a message to express your interest.",
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: messageController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write a short message...",
                      hintStyle: const TextStyle(color: Colors.black38),
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Color(0xFFC2185B)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // TODO: open message picker
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Choose Message",
                          style: TextStyle(
                            color: Color(0xFFC2185B),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.chevron_right,
                            color: Color(0xFFC2185B), size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _superConnect = true; // ✅ update state
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC2185B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                icon: const Icon(Icons.favorite_border,
                                    color: Colors.white, size: 18),
                                label: const Text(
                                  "Super Connect",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC2185B),
                                  shape: BoxShape.circle,
                                  border: Border.fromBorderSide(
                                    BorderSide(color: Colors.white, width: 1.5),
                                  ),
                                ),
                                child: const Text(
                                  "20",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _superConnect = true; // ✅ update state
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color(0xFFC2185B), width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.favorite_border,
                              color: Color(0xFFC2185B), size: 18),
                          label: const Text(
                            "Connect",
                            style: TextStyle(
                              color: Color(0xFFC2185B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

void _showMoreOptionsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            _moreOptionTile(
              context,
              icon: Icons.share_outlined,
              label: "Share Profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: share logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.star_border_outlined,
              label: "Add to shortlist",
              onTap: () {
                Navigator.pop(context);
                // TODO: shortlist logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.visibility_off_outlined,
              label: "Hide this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: hide logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.block_outlined,
              label: "Block this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: block logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.warning_amber_outlined,
              label: "Report this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: report logic
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

Widget _moreOptionTile(
    BuildContext context, {
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.black54),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}