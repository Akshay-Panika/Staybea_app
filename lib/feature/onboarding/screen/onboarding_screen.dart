import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

import '../../../core/constant/App_color.dart';
import '../../../core/widget/custom_button.dart';
import '../dat_to_marry/date_to_marry.dart';
import '../mature_connections/mature_connections.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String datingLookingFor = "Looking For >";
  String matureLookingFor = "Looking For >";
  String _selectedInterest = "Date to Marry";

  final items = [
    {
      "title": "Date to Marry",
      "image": "assets/image/d2m.png",
      "color": const Color(0xFFF9F3FE),
    },
    {
      "title": "Dating",
      "image": "assets/image/dating.png",
      "color": const Color(0xFFFFFBED),
    },
    {
      "title": "Mature connections",
      "image": "assets/image/mconnection.png",
      "color": const Color(0xFFFFEDDC),
    },
  ];

  Future<void> _handleSelection(String title) async {
    setState(() => _selectedInterest = title);

    String? result;

    if (title == "Dating") {
      result = await _showLookingForDialog();
      if (result != null) datingLookingFor = result;
    }

    if (title == "Mature connections") {
      result = await _showLookingForConnections();
      if (result != null) matureLookingFor = result;
    }

    if (result != null) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appSize.height * 0.1),

            Text(
              "What type of connection are you looking for?",
              style: TextStyle(
                fontSize: appSize.largeText,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: appSize.height * 0.05),

            ...items.map((item) {
              final isSelected = _selectedInterest == item["title"];

              return GestureDetector(
                onTap: () =>
                    _handleSelection(item["title"] as String),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: appSize.height * 0.11,
                  decoration: BoxDecoration(
                    color: item["color"] as Color,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.secondary
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        item["image"] as String,
                        height: 90,
                      ),
                      const Spacer(),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item["title"] as String,
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          if (item["title"] == 'Dating')
                            Text(
                              datingLookingFor,
                              style:
                              TextStyle(color: AppColors.secondary),
                            ),

                          if (item["title"] == 'Mature connections')
                            Text(
                              matureLookingFor,
                              style:
                              TextStyle(color: AppColors.secondary),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const Spacer(),

            CustomButton(
              isLoading: false,
              onTap: () {
                if (_selectedInterest == "Date to Marry") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DateToMarry()),
                  );
                } else if (_selectedInterest == "Dating") {
                  // agar dating ka alag screen hai to yaha bhejo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DateToMarry()), // temporary
                  );
                } else if (_selectedInterest == "Mature connections") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MatureConnections()),
                  );
                }
              },
              text: "Continue",
              bColor: AppColors.secondary,
              tColor: Colors.white,
            ),

            SizedBox(height: appSize.height * 0.05),
          ],
        ),
      ),
    );
  }

  Future<String?> _showLookingForDialog() {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String selected = "Long term";

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...["Long term", "Short term", "New friends", "Casual"]
                        .map((title) {
                      return InkWell(
                        onTap: () {
                          setStateDialog(() => selected = title);
                          Navigator.pop(context, selected);
                        },
                        child: _buildOption(title, selected),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<String?> _showLookingForConnections() {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String selected = "Companionship";

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...[
                      "Companionship",
                      "Travel partner",
                      "Emotional support",
                      "Friendship first"
                    ].map((title) {
                      return InkWell(
                        onTap: () {
                          setStateDialog(() => selected = title);
                          Navigator.pop(context, selected);
                        },
                        child: _buildOption(title, selected),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOption(String title, String selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),

          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: selected == title
                ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFA54275),
                  shape: BoxShape.circle,
                ),
              ),
            )
                : null,
          ),
        ],
      ),
    );
  }
}