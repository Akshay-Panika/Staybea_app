// /// onboarding_screen.dart
// import 'package:flutter/material.dart';
// import 'package:staybea_app/core/utils/app_size.dart';
// import '../../google/translation_service.dart';
//
// import '../../../core/constant/App_color.dart';
// import '../../../core/widget/app_button.dart';
// import '../dat_to_marry/date_to_marry.dart';
// import '../mature_connections/mature_connections.dart';
// import '../dating/dating.dart';
//
// /// Selected interest from OnboardingScreen
// String selectedInterest = "Date to Marry"; // Default selection
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   String datingLookingFor = "Looking For";
//   String matureLookingFor = "Looking For";
//   String _selectedInterest = "Date to Marry"; // Default selection
//
//   final items = [
//     {"title": "Date to Marry", "image": "assets/image/d2m.png", "color": const Color(0xFFF9F3FE)},
//     {"title": "Dating", "image": "assets/image/dating.png", "color": const Color(0xFFFFFBED)},
//     {"title": "Mature connections", "image": "assets/image/mconnection.png", "color": const Color(0xFFFFEDDC)},
//   ];
//
//   Future<Map<String, dynamic>> getTranslations() async {
//     final t = TranslationService();
//     return {
//       "title": await t.translate("What type of connection are you looking for?"),
//       "continue": await t.translate("Continue"),
//       "dateToMarry": await t.translate("Date to Marry"),
//       "dating": await t.translate("Dating"),
//       "mature": await t.translate("Mature connections"),
//       "lookingFor": await t.translate("Looking For"),
//       "longTerm": await t.translate("Long term"),
//       "shortTerm": await t.translate("Short term"),
//       "friends": await t.translate("New friends"),
//       "casual": await t.translate("Casual"),
//       "companion": await t.translate("Companionship"),
//       "travel": await t.translate("Travel partner"),
//       "support": await t.translate("Emotional support"),
//       "friendship": await t.translate("Friendship first"),
//     };
//   }
//
//   Future<void> _handleSelection(String title, Map<String, dynamic> t) async {
//     setState(() => _selectedInterest = title);
//     selectedInterest = title; // Sync global variable
//
//     String? result;
//
//     if (title == "Dating") {
//       result = await _showLookingForDialog(t);
//       if (result != null) datingLookingFor = result;
//     }
//
//     if (title == "Mature connections") {
//       result = await _showLookingForConnections(t);
//       if (result != null) matureLookingFor = result;
//     }
//
//     if (result != null) setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     AppSize appSize = AppSize(context);
//
//     return FutureBuilder<Map<String, dynamic>>(
//       future: getTranslations(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Scaffold(body: Center(child: CircularProgressIndicator()));
//         }
//
//         final t = snapshot.data!;
//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: appSize.height * 0.1),
//                 Text(t["title"], style: TextStyle(fontSize: appSize.largeText, fontWeight: FontWeight.w700)),
//                 SizedBox(height: appSize.height * 0.05),
//
//                 /// Cards
//                 ...items.map((item) {
//                   final isSelected = _selectedInterest == item["title"];
//                   String translatedTitle = item["title"] == "Date to Marry"
//                       ? t["dateToMarry"]
//                       : item["title"] == "Dating"
//                       ? t["dating"]
//                       : t["mature"];
//
//                   return GestureDetector(
//                     onTap: () => _handleSelection(item["title"] as String, t),
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       height: appSize.height * 0.11,
//                       decoration: BoxDecoration(
//                         color: item["color"] as Color,
//                         borderRadius: BorderRadius.circular(18),
//                         border: Border.all(color: isSelected ? AppColors.secondary : Colors.transparent),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(item["image"] as String, height: 90),
//                           const Spacer(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 translatedTitle,
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: isSelected ? AppColors.primary : Colors.black,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               if (item["title"] == 'Dating')
//                                 Row(
//                                   children: [
//                                     Text(
//                                       datingLookingFor == "Looking For" ? t["lookingFor"] : datingLookingFor,
//                                       style: TextStyle(color: AppColors.secondary),
//                                     ),
//                                     Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 14),
//                                   ],
//                                 ),
//                               if (item["title"] == 'Mature connections')
//                                 Row(
//                                   children: [
//                                     Text(
//                                       matureLookingFor == "Looking For" ? t["lookingFor"] : matureLookingFor,
//                                       style: TextStyle(color: AppColors.secondary),
//                                     ),
//                                     Icon(Icons.arrow_forward_ios, color: AppColors.secondary, size: 14),
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),
//
//                 const Spacer(),
//
//                 /// Continue Button
//                 AppButton(
//                   isLoading: false,
//                   onTap: () {
//                     selectedInterest = _selectedInterest; // Ensure global sync
//                     if (_selectedInterest == "Date to Marry") {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => const DateToMarry()));
//                     } else if (_selectedInterest == "Dating") {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => Dating()));
//                     } else {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) => MatureConnections()));
//                     }
//                   },
//                   text: t["continue"],
//                   bColor: AppColors.secondary,
//                   tColor: Colors.white,
//                 ),
//                 SizedBox(height: appSize.height * 0.05),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Future<String?> _showLookingForDialog(Map<String, dynamic> t) {
//     return _showCustomSelectionDialog(
//       options: [t["longTerm"], t["shortTerm"], t["friends"], t["casual"]],
//       selectedValue: datingLookingFor,
//     );
//   }
//
//   Future<String?> _showLookingForConnections(Map<String, dynamic> t) {
//     return _showCustomSelectionDialog(
//       options: [t["companion"], t["travel"], t["support"], t["friendship"]],
//       selectedValue: matureLookingFor,
//     );
//   }
//
//   Future<String?> _showCustomSelectionDialog({
//     required List<String> options,
//     required String selectedValue,
//   }) {
//     return showDialog<String>(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         String selected = selectedValue;
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Dialog(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: InkWell(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
//                           child: const Icon(Icons.arrow_back),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ...options.map((title) {
//                       final isSelected = selected == title;
//                       return InkWell(
//                         onTap: () {
//                           setState(() => selected = title);
//                           Navigator.pop(context, title);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(title,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: isSelected ? Colors.black : Colors.black54,
//                                       fontWeight: FontWeight.w500,
//                                     )),
//                               ),
//                               Container(
//                                 height: 22,
//                                 width: 22,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: isSelected ? Colors.pink : Colors.grey, width: 2),
//                                 ),
//                                 child: isSelected
//                                     ? const Center(
//                                   child: SizedBox(
//                                     height: 10,
//                                     width: 10,
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
//                                     ),
//                                   ),
//                                 )
//                                     : null,
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

/// Better UI Layout Version (Only Dating Card)

import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../../google/translation_service.dart';

import '../../../core/constant/App_color.dart';
import '../../../core/widget/app_button.dart';
import '../dating/dating.dart';

String selectedInterest = "Dating";

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String datingLookingFor = "Looking For";

  Future<Map<String, dynamic>> getTranslations() async {
    final t = TranslationService();

    return {
      "title":
      await t.translate("What type of connection are you looking for?"),
      "subtitle":
      await t.translate("Find someone special and start your journey"),
      "continue": await t.translate("Continue"),
      "dating": await t.translate("Dating"),
      "lookingFor": await t.translate("Looking For"),
      "longTerm": await t.translate("Long term"),
      "shortTerm": await t.translate("Short term"),
      "friends": await t.translate("New friends"),
      "casual": await t.translate("Casual"),
    };
  }

  Future<void> _handleSelection(Map<String, dynamic> t) async {
    final result = await _showLookingForDialog(t);

    if (result != null) {
      setState(() {
        datingLookingFor = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appSize = AppSize(context);

    return FutureBuilder<Map<String, dynamic>>(
      future: getTranslations(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final t = snapshot.data!;

        return Scaffold(
          backgroundColor: const Color(0xffFFF8FB),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// TOP HEADER
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t["title"],
                          style: TextStyle(
                            fontSize: appSize.largeText + 4,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          t["subtitle"],
                          style: TextStyle(
                            fontSize: appSize.mediumText,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// MAIN DATING CARD
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          /// IMAGE
                          Expanded(
                            flex: 5,
                            child: Center(
                              child: Image.asset(
                                "assets/image/dating.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          /// TITLE
                          Text(
                            t["dating"],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Find meaningful connections and build something beautiful.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// LOOKING FOR BUTTON
                          InkWell(
                            onTap: () => _handleSelection(t),
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFF4F8),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: AppColors.secondary.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: AppColors.secondary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      datingLookingFor == "Looking For"
                                          ? t["lookingFor"]
                                          : datingLookingFor,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: AppColors.secondary,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// CONTINUE BUTTON
                  AppButton(
                    isLoading: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Dating(),
                        ),
                      );
                    },
                    text: t["continue"],
                    bColor: AppColors.secondary,
                    tColor: Colors.white,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showLookingForDialog(Map<String, dynamic> t) {
    return _showCustomSelectionDialog(
      options: [
        t["longTerm"],
        t["shortTerm"],
        t["friends"],
        t["casual"],
      ],
      selectedValue: datingLookingFor,
    );
  }

  Future<String?> _showCustomSelectionDialog({
    required List<String> options,
    required String selectedValue,
  }) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String selected = selectedValue;

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Back Button
                    Row(
                      spacing: 14,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Looking For",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 18),

                    /// Options
                    ...options.map((title) {
                      final isSelected = selected == title;

                      return InkWell(
                        onTap: () {
                          setState(() => selected = title);
                          Navigator.pop(context, title);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: isSelected
                                ? const Color(0xffFFF4F8)
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.secondary
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.black54,
                                  ),
                                ),
                              ),

                              /// Radio UI
                              Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: isSelected
                                        ? AppColors.secondary
                                        : Colors.grey,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.secondary,
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
  }}