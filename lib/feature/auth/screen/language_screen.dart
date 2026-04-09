// import 'package:flutter/material.dart';
// import 'package:staybea_app/core/constant/App_color.dart';
// import 'package:staybea_app/core/utils/app_size.dart';
// import '../../../core/widget/app_button.dart';
// import '../../google/translation_service.dart';
// import 'auth_screen.dart';
//
// class LanguageScreen extends StatefulWidget {
//   const LanguageScreen({super.key});
//
//   @override
//   State<LanguageScreen> createState() =>
//       _LanguageScreenState();
// }
//
// class _LanguageScreenState extends State<LanguageScreen> {
//
//   int selectedIndex = 0;
//   String searchText = "";
//
//   final List<Map<String, String>> languages = [
//     {"title": "English", "code": "en"},
//     {"title": "Hindi", "code": "hi"},
//     {"title": "Gujarati", "code": "gu"},
//     {"title": "Marathi", "code": "mr"},
//     {"title": "Bengali", "code": "bn"},
//     {"title": "Punjabi", "code": "pa"},
//     {"title": "Tamil", "code": "ta"},
//     {"title": "Telugu", "code": "te"},
//     {"title": "Kannada", "code": "kn"},
//     {"title": "Malayalam", "code": "ml"},
//     {"title": "Kashmiri", "code": "ks"},
//     {"title": "Urdu", "code": "ur"},
//   ];
//
//   List<Map<String, String>> get filteredLanguages {
//     if (searchText.isEmpty) return languages;
//     return languages
//         .where((lang) => lang["title"]!
//         .toLowerCase()
//         .contains(searchText.toLowerCase()))
//         .toList();
//   }
//
//   Widget languageCard(int index, List list) {
//     final lang = list[index];
//     final originalIndex = languages.indexOf(lang);
//     final isSelected = selectedIndex == originalIndex;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedIndex = originalIndex;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             color: isSelected ? AppColors.secondary : Colors.grey.shade300,
//             width: 1.2,
//           ),
//         ),
//         child: Row(
//           children: [
//             /// Radio
//             Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected ? AppColors.secondary : Colors.grey,
//                   width: 2,
//                 ),
//               ),
//               child: isSelected
//                   ? Center(
//                 child: Container(
//                   width: 10,
//                   height: 10,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.secondary,
//                   ),
//                 ),
//               )
//                   : null,
//             ),
//
//             const SizedBox(width: 10),
//
//             Expanded(
//               child: Text(
//                 lang["title"]!,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void onNext() {
//     final langCode = languages[selectedIndex]["code"]!;
//
//     /// 🌍 Global set
//     TranslationService().currentLang = langCode;
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const AuthScreen(),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     AppSize appSize = AppSize(context);
//     final list = filteredLanguages;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Title
//               Text(
//                 "Help us know you",
//                 style: TextStyle(
//                     fontSize: appSize.mediumText,
//                     color: Colors.grey.shade700,
//                     fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 6),
//                Text(
//                 "Your preferred language is?",
//                 style: TextStyle(
//                     fontSize: appSize.largeText, fontWeight: FontWeight.bold),
//               ),
//
//               const SizedBox(height: 16),
//
//               /// 🔍 Search
//               TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     searchText = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: "Search language...",
//                   prefixIcon: const Icon(Icons.search),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               /// Grid
//               Expanded(
//                 child: list.isEmpty
//                     ? Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.language_outlined, size: 48, color: Colors.grey.shade300),
//                       const SizedBox(height: 12),
//                       Text(
//                         'No language found',
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.grey.shade400,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//                     : GridView.builder(
//                   itemCount: list.length,
//                   gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 12,
//                     crossAxisSpacing: 12,
//                     childAspectRatio: 3.5,
//                   ),
//                   itemBuilder: (context, index) {
//                     return languageCard(index, list);
//                   },
//                 ),
//               ),
//
//               /// Button
//               CustomButton(
//                 text:"NEXT",
//                 onTap: onNext,
//                 bColor: AppColors.secondary,
//                 tColor: Colors.white,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../../../core/widget/app_button.dart';
import '../../google/translation_service.dart';
import 'auth_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> languages = [
    {"title": "English", "native": "English", "code": "en"},
    {"title": "Hindi", "native": "हिंदी", "code": "hi"},
    {"title": "Marathi", "native": "मराठी", "code": "mr"},
    {"title": "Gujarati", "native": "ગુજરાતી", "code": "gu"},
    {"title": "Tamil", "native": "தமிழ்", "code": "ta"},
    {"title": "Urdu", "native": "اردو", "code": "ur"},
    {"title": "Malayalam", "native": "മലയാളം", "code": "ml"},
  ];

  Widget languageCard(int index) {
    final lang = languages[index];
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.secondary : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            /// Left Text
            Expanded(
              child: Text(
                lang["title"]!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            /// Right Native Text
            Text(
              lang["native"]!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onNext() {
    final langCode = languages[selectedIndex]["code"]!;
    TranslationService().currentLang = langCode;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appSize.height*0.04),
              /// Title
               Text(
                "Please select a language to\nproceed.",
                style: TextStyle(
                  fontSize: appSize.largeText,
                  fontWeight: FontWeight.w600,
                ),
              ),

               SizedBox(height: appSize.height*0.04),

              /// List
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return languageCard(index);
                  },
                ),
              ),

              /// Button
              CustomButton(
                text: "NEXT",
                onTap: onNext,
                bColor: AppColors.secondary,
                tColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}