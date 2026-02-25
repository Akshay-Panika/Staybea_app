import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../screen/user_details_screen.dart';

class ProfileStepWidget extends StatefulWidget {
  const ProfileStepWidget({super.key});

  @override
  State<ProfileStepWidget> createState() => _ProfileStepWidgetState();
}

class _ProfileStepWidgetState extends State<ProfileStepWidget> {
  File? profileImage;

  /// Pick profile image using file picker
  Future<void> pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        profileImage = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Profile container
                  GestureDetector(
                    onTap: pickProfileImage,
                    child: Container(
                      width: 200,height: 200,
                      padding: const EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: profileImage != null
                            ? DecorationImage(
                          image: FileImage(profileImage!),
                          fit: BoxFit.cover,
                        )
                            : const DecorationImage(
                          image: AssetImage('assets/image/add_profile_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: profileImage == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 80,
                        color: Colors.grey.shade200,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Add Your Profile Photo',
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
                ],
              ),
            ),

            // Maybe Later button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StayBeaScreen()),
                );
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