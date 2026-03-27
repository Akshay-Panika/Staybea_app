import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';

class InterestingStepWidget extends StatefulWidget {
  const InterestingStepWidget({super.key});

  @override
  State<InterestingStepWidget> createState() => _InterestingStepWidgetState();
}

class _InterestingStepWidgetState extends State<InterestingStepWidget> {

  String lookingFor = "Looking For >";
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


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What type of connection are you looking for?",
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
                  border: Border.all(color: isSelected ? AppColors.secondary:Colors.transparent,)
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
                          style:  TextStyle(
                            fontSize: 18,
                            color: isSelected? AppColors.primary:Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        if(item["title"] == 'Dating')
                          GestureDetector(
                            onTap: () async {
                              final result = await _showLookingForDialog();

                              if (result != null) {
                                setState(() {
                                  lookingFor = result; // 🔥 update UI
                                });
                              }
                            },
                            child: Text(
                              lookingFor,
                              style: TextStyle(color: AppColors.secondary),
                            ),
                          ),

                        if(item["title"] == 'Mature connections')
                          Text('Looking For >', style: TextStyle(color: AppColors.secondary),),
                      ],
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
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// BACK BUTTON
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
                          setStateDialog(() {
                            selected = title;
                          });

                          // 🔥 return value
                          Navigator.pop(context, selected);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title,
                                  style: const TextStyle(fontSize: 18)),

                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                  Border.all(color: Colors.grey),
                                ),
                                child: selected == title
                                    ? Center(
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration:
                                    const BoxDecoration(
                                      color: Color(0xFFA54275),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                                    : null,
                              ),
                            ],
                          ),
                        ),
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

}

