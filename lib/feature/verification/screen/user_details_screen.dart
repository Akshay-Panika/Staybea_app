import 'package:flutter/material.dart';

import '../../dashboard/screen/dashboard_screen.dart';
import '../../home/screen/home_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  int _currentStep = 0;

  List<Widget> get _steps => [
    _buildNameWidget(),
    _buildDOBWidget(),
    _buildGenderWidget(),
    _buildSexualWidget(),
    _buildInterestingWidget(),
    _buildLookingWidget(),
    _buildSearchingWidget(),
    _buildPersonWidget(),
    _buildLifestyleWidget(),
    _buildMattersWidget(),
    _buildPhotosWidget(),
    _buildYourselfWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            /// progress
            SizedBox(
              height: 40,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _steps.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isActive = index <= _currentStep;

                  return Row(
                    children: [
                      if (index != 0)
                        Container(
                          height: 2,
                          width: 40,
                          color: isActive
                              ? const Color(0xFFA54275)
                              : const Color(0xFFEEAECF),
                        ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: isActive
                            ? const Color(0xFFA54275)
                            : Colors.grey.shade300,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isActive ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// back
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (_currentStep == 0) {
                        Navigator.pop(context);
                      } else {
                        setState(() => _currentStep--);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 8),
                          Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// STEP CONTENT (scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: _steps[_currentStep],
              ),
            ),

            /// next button
            InkWell(
              onTap: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() => _currentStep++);
                } else {
                  print("DONE ✅");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LatestPhotos(),));
                }
              },
              child: Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFA54275),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  Widget _buildNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Icon(Icons.star, size: 32, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                "What's your name?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// TEXTFIELD
          TextField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: "Enter Your Name",
              isDense: true,                 // height kam
              contentPadding: EdgeInsets.zero, // padding remove
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// UNDERLINE
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 18),

          /// DESCRIPTION
          const Text(
            "Decide what your partner should call you",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDOBWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE ROW
          Row(
            children: const [
              Text("🎂", style: TextStyle(fontSize: 28)),
              SizedBox(width: 8),
              Text(
                "Your b-day?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// INPUT BOXES
          Row(
            children: [
              _dobBox("DD"),
              const SizedBox(width: 12),
              _dobBox("MM"),
              const SizedBox(width: 12),
              Expanded(child: _dobBox("YYYY")),
            ],
          ),

          const SizedBox(height: 16),

          /// DESCRIPTION
          const Text(
            "Give a chance to your partner she will wish you on your moment",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dobBox(String hint) {
    return Container(
      width: hint == "YYYY" ? double.infinity : 80,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  String _selectedGender = "Man";

  Widget _buildGenderWidget() {
    final genders = [
      "Man",
      "Women",
      "Non-Binary",
      "Prefer not to say",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Select Your Gender",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 10),

        ...genders.map((gender) {
          final isSelected = _selectedGender == gender;

          return InkWell(
            onTap: () {
              setState(() => _selectedGender = gender);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: isSelected
                  ? Colors.grey.shade200
                  : Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      gender,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check, color: Colors.blue)
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  String _selectedOrientation = "Straight";

  Widget _buildSexualWidget() {
    final options = [
      "Straight",
      "Gay",
      "Lesbian",
      "Bisexual",
      "Asexual",
      "Demisexual",
      "Pansexual",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Select your Sexual Orientation ?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 10),

        ...options.map((item) {
          final isSelected = _selectedOrientation == item;

          return InkWell(
            onTap: () {
              setState(() => _selectedOrientation = item);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: isSelected
                  ? Colors.grey.shade200
                  : Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check, color: Colors.blue),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  String _selectedInterest = "Women";
  Widget _buildInterestingWidget() {
    final items = [
      {
        "title": "Women",
        "image": "assets/women.png",
        "color": const Color(0xFFE7E1EC),
      },
      {
        "title": "Man",
        "image": "assets/man.png",
        "color": const Color(0xFFE7E3D7),
      },
      {
        "title": "Everyone",
        "image": "assets/everyone.png",
        "color": const Color(0xFFEBD9C8),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Who are you interesting in seeing for an Date ?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),

          ...items.map((item) {
            final isSelected = _selectedInterest == item["title"];

            return GestureDetector(
              onTap: () {
                setState(() => _selectedInterest = item["title"] as String);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 90,
                decoration: BoxDecoration(
                  color: item["color"] as Color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    // Image.asset(
                    //   item["image"] as String,
                    //   height: 70,
                    // ),
                    const Spacer(),
                    Text(
                      item["title"] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLookingWidget() {
    final items = [
      {"title": "Looking for marriage", "emoji": "❤️"},
      {"title": "Long terms but short term ok", "emoji": "😍"},
      {"title": "Short-term but long-term ok", "emoji": "🥂"},
      {"title": "Short term fun", "emoji": "🌟"},
      {"title": "New friends", "emoji": "🤝"},
      {"title": "Still figuring it", "emoji": "🙄"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What are you Looking for ?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true, // important
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['emoji']!,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double _distance = 13;
  Widget _buildSearchingWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "How far your searching for an partner ?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Distance preference",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${_distance.round()} km",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Slider with heart thumb
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: Slider(
              value: _distance,
              min: 1,
              max: 100,
              divisions: 99,
              onChanged: (value) {
                setState(() => _distance = value);
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildPersonWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Expanded(
                child: Text(
                  "If your are person who is studying  thing ...",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// TEXTFIELD
          TextField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: "Enter school name, past or current",
              isDense: true,   
              suffixIcon: Icon(Icons.close),// height kam
              contentPadding: EdgeInsets.zero, // padding remove
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// UNDERLINE
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade400,
          ),
          
        ],
      ),
    );
  }

  Widget _buildLifestyleWidget() {
    final drinkOptions = [
      "Not for me",
      "Newly teetotal",
      "Sober curious",
      "On special occasions",
      "Socially, at the weekend",
      "Most nights",
    ];

    final smokeOptions = [
      "Social Smoker",
      "Smoker with drinking",
      "Non-smoker",
      "Smoker",
      "Trying to quit",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Let’s Talk Lifestyle",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Habits meet harmony. You go first.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          /// DRINK CARD
          _lifestyleCard(
            icon: "🍾",
            title: "How often do you drink?",
            options: drinkOptions,
          ),

          const SizedBox(height: 16),

          /// SMOKE CARD
          _lifestyleCard(
            icon: "🚬",
            title: "How often do you smoke?",
            options: smokeOptions,
          ),
        ],
      ),
    );
  }

  /// reusable card
  Widget _lifestyleCard({
    required String icon,
    required String title,
    required List<String> options,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EDF7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options
                .map(
                  (e) => Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMattersWidget() {
    final communicationOptions = [
      "I stay WhatsApp all day",
      "Big time texter",
      "Phone caller",
      "Video chatter",
      "I’m slow to answer on whatsapp",
      "Bad texter",
      "Better in person",
    ];

    final loveOptions = [
      "Thoughtful gestures",
      "Presents",
      "Touch",
      "Compliments",
      "Time together",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "The real you matters.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Don’t hold back. The right person will appreciate you",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          /// COMMUNICATION CARD
          _mattersCard(
            icon: "💬",
            title: "What’s your communication style?",
            options: communicationOptions,
          ),

          const SizedBox(height: 16),

          /// LOVE LANGUAGE CARD
          _mattersCard(
            icon: "💗",
            title: "How do you receive love",
            options: loveOptions,
          ),
        ],
      ),
    );
  }

  Widget _mattersCard({
    required String icon,
    required String title,
    required List<String> options,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EDF7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options
                .map(
                  (e) => Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }


  Widget _buildPhotosWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Your Latest Photos.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Add 2 photos to begin. Add more to make your profile shine.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFA54275),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }


  Widget _buildYourselfWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Share more about yourself",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Write a bio and a prompt to help your profile stand out spark conversations.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          /// About me card
          _infoCard(
            title: "About me",
            subtitle: "Add more Information to stand out your profile",
            onTap: () {},
          ),

          const SizedBox(height: 20),

          /// Prompt card
          _infoCard(
            title: "Choose a Prompt to Answer",
            subtitle: "Add more Information to stand out your profile",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),

        /// plus button
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 34,
              width: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA54275),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        )
      ],
    );
  }
}

class LatestPhotos extends StatelessWidget {
  const LatestPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 80,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'Add Your Latest Photos.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                const Text(
                  'For more authentic connections, users in your region are required '
                      'to complete a biometric face check with a video selfie. This helps '
                      'prevent fraud, delete duplicate accounts, and enforce our team. '
                      'If your profile photos match your face check, you’ll get a photo '
                      'verified badge.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Learn More link
                GestureDetector(
                  onTap: () {
                    // handle Learn More tap
                  },
                  child: const Text(
                    'Learn More',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )),



            InkWell(
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => StayBeaScreen(),));
              },
              child: Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFFA54275),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    "Maybe Later",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class StayBeaScreen extends StatelessWidget {
  const StayBeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(

        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 16),
              // Subtitle
              const Text(
                'See more students at your university and nearby',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Primary button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA54275),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Let’s do it",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              // Secondary button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey,width: 0.3)
                  ),
                  child: const Center(
                    child: Text(
                      "No Thanks",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}