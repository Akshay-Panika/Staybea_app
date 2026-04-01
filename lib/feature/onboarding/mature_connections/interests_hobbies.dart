import 'package:flutter/material.dart';

class InterestsAndHobbies extends StatefulWidget {
  const InterestsAndHobbies({super.key});

  @override
  State<InterestsAndHobbies> createState() => _InterestsAndHobbiesState();
}

class _InterestsAndHobbiesState extends State<InterestsAndHobbies> {
  final int _minSelection = 3;
  final int _maxSelection = 5;
  final Set<String> _selected = {};

  final List<Map<String, dynamic>> _interests = [
    {'label': 'Gardening', 'icon': Icons.grass},
    {'label': 'Travel', 'icon': Icons.flight},
    {'label': 'Reading', 'icon': Icons.menu_book},
    {'label': 'Cooking', 'icon': Icons.restaurant},
    {'label': 'Walking', 'icon': Icons.directions_walk},
    {'label': 'Music', 'icon': Icons.music_note},
    {'label': 'Art & Craft', 'icon': Icons.palette},
    {'label': 'Dancing', 'icon': Icons.nightlife},
    {'label': 'Photography', 'icon': Icons.camera_alt},
    {'label': 'Fitness', 'icon': Icons.fitness_center},
    // {'label': 'Gaming', 'icon': Icons.sports_esports},
    // {'label': 'Movies', 'icon': Icons.movie},
    // {'label': 'Yoga', 'icon': Icons.self_improvement},
    // {'label': 'Cycling', 'icon': Icons.directions_bike},
    // {'label': 'Swimming', 'icon': Icons.pool},
    // {'label': 'Hiking', 'icon': Icons.terrain},
    // {'label': 'Writing', 'icon': Icons.edit},
    // {'label': 'Meditation', 'icon': Icons.spa},
  ];

  void _toggleSelection(String label) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else if (_selected.length < _maxSelection) {
        _selected.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Title
          const Text(
            "Interests & Hobbies",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            "Select $_minSelection to $_maxSelection interests to get better matches.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 20),

          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _interests.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final item = _interests[index];
              final label = item['label'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = _selected.contains(label);

              return GestureDetector(
                onTap: () => _toggleSelection(label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? Colors.pink.shade300
                          : Colors.grey.shade200,
                      width: isSelected ? 1 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 32,
                        color: isSelected
                            ? Colors.pink.shade400
                            : Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? Colors.pink.shade400
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Selection counter
          Center(
            child: Text(
              "${_selected.length} / $_maxSelection selected",
              style: TextStyle(
                fontSize: 13,
                color: _selected.length >= _minSelection
                    ? Colors.green.shade600
                    : Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}