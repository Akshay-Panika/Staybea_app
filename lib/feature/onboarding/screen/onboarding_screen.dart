import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../../google/translation_service.dart';

import '../../../core/constant/App_color.dart';
import '../../../core/widget/custom_button.dart';
import '../dat_to_marry/date_to_marry.dart';
import '../mature_connections/mature_connections.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
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

  /// 🔥 Translation Future
  Future<Map<String, dynamic>> getTranslations() async {
    final t = TranslationService();

    return {
      "title": await t.translate(
          "What type of connection are you looking for?"),
      "continue": await t.translate("Continue"),

      "dateToMarry": await t.translate("Date to Marry"),
      "dating": await t.translate("Dating"),
      "mature": await t.translate("Mature connections"),

      "lookingFor": await t.translate("Looking For >"),

      "longTerm": await t.translate("Long term"),
      "shortTerm": await t.translate("Short term"),
      "friends": await t.translate("New friends"),
      "casual": await t.translate("Casual"),

      "companion": await t.translate("Companionship"),
      "travel": await t.translate("Travel partner"),
      "support": await t.translate("Emotional support"),
      "friendship": await t.translate("Friendship first"),
    };
  }

  Future<void> _handleSelection(
      String title, Map<String, dynamic> t) async {
    setState(() => _selectedInterest = title);

    String? result;

    if (title == "Dating") {
      result = await _showLookingForDialog(t);
      if (result != null) datingLookingFor = result;
    }

    if (title == "Mature connections") {
      result = await _showLookingForConnections(t);
      if (result != null) matureLookingFor = result;
    }

    if (result != null) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return FutureBuilder<Map<String, dynamic>>(
      future: getTranslations(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final t = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                SizedBox(height: appSize.height * 0.1),

                /// Title
                Text(
                  t["title"],
                  style: TextStyle(
                    fontSize: appSize.largeText,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: appSize.height * 0.05),

                ...items.map((item) {
                  final isSelected =
                      _selectedInterest == item["title"];

                  String translatedTitle =
                  item["title"] == "Date to Marry"
                      ? t["dateToMarry"]
                      : item["title"] == "Dating"
                      ? t["dating"]
                      : t["mature"];

                  return GestureDetector(
                    onTap: () => _handleSelection(
                        item["title"] as String, t),
                    child: Container(
                      margin:
                      const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16),
                      height: appSize.height * 0.11,
                      decoration: BoxDecoration(
                        color: item["color"] as Color,
                        borderRadius:
                        BorderRadius.circular(18),
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
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                translatedTitle,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.black,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),

                              if (item["title"] ==
                                  'Dating')
                                Text(
                                  datingLookingFor ==
                                      "Looking For >"
                                      ? t["lookingFor"]
                                      : datingLookingFor,
                                  style: TextStyle(
                                      color: AppColors
                                          .secondary),
                                ),

                              if (item["title"] ==
                                  'Mature connections')
                                Text(
                                  matureLookingFor ==
                                      "Looking For >"
                                      ? t["lookingFor"]
                                      : matureLookingFor,
                                  style: TextStyle(
                                      color: AppColors
                                          .secondary),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),

                const Spacer(),

                /// Button
                CustomButton(
                  isLoading: false,
                  onTap: () {
                    if (_selectedInterest ==
                        "Date to Marry") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                DateToMarry()),
                      );
                    } else if (_selectedInterest ==
                        "Dating") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                DateToMarry()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                MatureConnections()),
                      );
                    }
                  },
                  text: t["continue"],
                  bColor: AppColors.secondary,
                  tColor: Colors.white,
                ),

                SizedBox(height: appSize.height * 0.05),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Dialogs also translated
  Future<String?> _showLookingForDialog(
      Map<String, dynamic> t) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String selected = t["longTerm"];

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...[
                t["longTerm"],
                t["shortTerm"],
                t["friends"],
                t["casual"]
              ].map((title) {
                return ListTile(
                  title: Text(title),
                  onTap: () => Navigator.pop(context, title),
                );
              })
            ],
          ),
        );
      },
    );
  }

  Future<String?> _showLookingForConnections(
      Map<String, dynamic> t) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String selected = t["companion"];

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...[
                t["companion"],
                t["travel"],
                t["support"],
                t["friendship"]
              ].map((title) {
                return ListTile(
                  title: Text(title),
                  onTap: () => Navigator.pop(context, title),
                );
              })
            ],
          ),
        );
      },
    );
  }
}