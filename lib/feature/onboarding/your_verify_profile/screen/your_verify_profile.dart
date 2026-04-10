import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import for camera access
import 'package:staybea_app/core/utils/app_size.dart';

class YourVerifyProfile extends StatefulWidget {
  const YourVerifyProfile({super.key});

  @override
  State<YourVerifyProfile> createState() => _YourVerifyProfileState();
}

class _YourVerifyProfileState extends State<YourVerifyProfile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _clickImage() async {
    try {
      if (!mounted) return;

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80, // Lowering quality slightly can prevent memory crashes on older devices
      );

      if (photo != null) {
        setState(() {
          _image = File(photo.path);
        });
      } else {
        debugPrint("Camera closed by user");
      }
    } catch (e) {
      // This is the most important part - check your console for this output!
      debugPrint("Error capturing image: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open camera: $e")),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verify your profile",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Verify profiles get better matches.",
            style: TextStyle(
              fontSize: appSize.mediumText,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 60),

          // Camera Click Area
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: _clickImage, // Tap to click image
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey.shade300),
                      image: _image != null
                          ? DecorationImage(
                        image: FileImage(_image!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: _image == null
                        ? Icon(Icons.camera_enhance_rounded,
                        size: 50, color: Colors.grey.shade400)
                        : null,
                  ),
                ),

                // Blue Verification Badge
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 60),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified_user_outlined,
                      color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "Verification selfies are not shown to others",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}