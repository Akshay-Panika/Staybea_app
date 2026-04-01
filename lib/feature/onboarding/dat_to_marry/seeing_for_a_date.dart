import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class SeeingForADate extends StatefulWidget {
  const SeeingForADate({super.key});

  @override
  State<SeeingForADate> createState() => _SeeingForADateState();
}

class _SeeingForADateState extends State<SeeingForADate> {
  int selectedIndex = 0;

  final List<Map<String, String>> _orientations = [
    {
      'title': 'Straight',
      'description': 'A person who is exclusively attracted to members of the opposite gender',
    },
    {
      'title': 'Gay',
      'description': 'An umbrella term used to describe someone who is attracted to members of their gender',
    },
    {
      'title': 'Lesbian',
      'description': 'A person who is exclusively attracted to members of the opposite gender',
    },
    {
      'title': 'Aromatic',
      'description': 'A person who does not experience romantic attraction, although they may still experience sexual',
    },
    {
      'title': 'Asexual',
      'description': 'A person who may not experience sexual attraction or may experience a limited amount of sexual desire, may still experience romantic or desire',
    },
  ];

  String? _selectedOrientation;

  void _showOrientationBottomSheet(BuildContext context) {
    String? tempSelected = _selectedOrientation;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.4,
              maxChildSize: 0.92,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // Handle bar
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Back button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const Icon(Icons.chevron_left, size: 20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // List
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _orientations.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = _orientations[index];
                            final isSelected = tempSelected == item['title'];

                            return GestureDetector(
                              onTap: () {
                                setSheetState(() => tempSelected = item['title']);
                                setState(() => _selectedOrientation = item['title']);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFA54275)
                                        : Colors.grey.shade200,
                                    width: isSelected ? 1.5 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? const Color(0xFFA54275)
                                            : Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item['description']!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text(
            "Who are you interested in seeing\nfor a Date ?",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: appSize.height * 0.03),

          _buildCard(
            index: 0,
            title: "Women",
            image: "assets/auth/women.png",
            color: const Color(0xFFF1ECF7),
          ),

          SizedBox(height: appSize.height * 0.02),

          _buildCard(
            index: 1,
            title: "Man",
            image: "assets/auth/man.png",
            color: const Color(0xFFF5F1E6),
          ),

          SizedBox(height: appSize.height * 0.02),

          _buildCard(
            index: 2,
            title: "Everyone",
            image: "assets/auth/everyone.png",
            color: const Color(0xFFF2E2D6),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required String title,
    required String image,
    required Color color,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        _showOrientationBottomSheet(context); // ✅ opens on card tap
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 70,
            ),

            const Spacer(),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.pink : Colors.black,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      _selectedOrientation != null && isSelected
                          ? _selectedOrientation!
                          : "Identify",
                      style: const TextStyle(
                        color: Color(0xFFA54275),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFFA54275),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}