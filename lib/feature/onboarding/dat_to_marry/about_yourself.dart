import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class AboutYourself extends StatefulWidget {
  const AboutYourself({super.key});

  @override
  State<AboutYourself> createState() => _AboutYourselfState();
}

class _AboutYourselfState extends State<AboutYourself> {
  final TextEditingController _bioController = TextEditingController();
  final int _maxChars = 300;

  bool _addBio = false;

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share more about yourself",
            style: TextStyle(
                fontSize: appSize.largeText, fontWeight: FontWeight.w700),
          ),
          6.height,
          Text(
            "Write a bio and a prompt to help your profile stand out spark conversations.",
            style: TextStyle(fontSize: appSize.mediumText, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          /// About me card
          _infoCard(
            title: "About me",
            subtitle: "Add more Information to stand out your profile",
            onTap: () {
             setState(() {
               _addBio = !_addBio;
             });
            },
          ),

          20.height,

          AnimatedSize(
            alignment: Alignment.topCenter,
            duration: const Duration(milliseconds: 300),
            child: _addBio ? _bioInputSection() : const SizedBox(),
          )
        ],
      ),
    );
  }

  Widget _bioInputSection() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
                child: TextField(
                  controller: _bioController,
                  maxLines: 4,
                  maxLength: _maxChars,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Enter your short information.",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    counterText: '', // hide default counter
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 14, bottom: 12),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${_bioController.text.length}/$_maxChars",
                    style: TextStyle(
                      fontSize: 12,
                      color: _bioController.text.length >= _maxChars
                          ? Colors.red
                          : const Color(0xFFA54275),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.all(16),
              child: Padding(
                padding:  EdgeInsets.only(top: 20.0),
                child: const Text(
                  '"I am a highly motivated and results-oriented professional with a passion for creative problem-solving. I am currently seeking new opportunities to apply my skills in [Your Field] to drive meaningful results',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            Container(
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
              ),
              child: Center(child: Text('Bio top', style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),)),
            )
          ],
        ),
      ],
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
          margin: const EdgeInsets.only(bottom: 16),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(subtitle,
                  style:
                  const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),

        /// Plus button
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
        ),
      ],
    );
  }
}