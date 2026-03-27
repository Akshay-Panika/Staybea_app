import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class VerifyYourProfile extends StatefulWidget {
  const VerifyYourProfile({super.key});

  @override
  State<VerifyYourProfile> createState() => _VerifyYourProfileState();
}

class _VerifyYourProfileState extends State<VerifyYourProfile> {
  File? _image;
  bool _biometricConsent = false;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    final tips = [
      (Icons.sentiment_satisfied_alt_outlined, 'Show your face clearly'),
      (Icons.wb_sunny_outlined, 'Use good lighting'),
      (Icons.camera_alt_outlined, 'Look straight at the camera'),
      (Icons.face_retouching_off_outlined, 'Remove sunglasses & hats'),
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: appSize.height * 0.02),

              // Camera icon placeholder
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: appSize.height*0.15,
                    height: appSize.height*0.15,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _image != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Center(
                      child: Icon(
                        Icons.crop_free_rounded,
                        size: 48,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: appSize.height * 0.03),

              // Title
              Text(
                "Take a selfie",
                style: TextStyle(
                  fontSize: appSize.largeText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Take a selfie to verify your identity.",
                style: TextStyle(
                  fontSize: appSize.mediumText,
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(height: appSize.height * 0.03),

              // Tips card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: tips.map((tip) {
                    final isLast = tip == tips.last;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(tip.$1, size: 22, color: Colors.black87),
                            const SizedBox(width: 14),
                            Text(
                              tip.$2,
                              style: TextStyle(
                                fontSize: appSize.mediumText,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        if (!isLast)
                          Divider(
                            height: 24,
                            color: Colors.grey.shade200,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: appSize.height * 0.03),
            ],
          ),

          SizedBox(height: appSize.height*0.07,),


          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    activeColor: Colors.green,
                    value: _biometricConsent,
                    onChanged: (val) {
                      setState(() {
                        _biometricConsent = val ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "I concert to Bureau to process and store my biometrics data to verify my identity and prevent fraud.",
                    style: TextStyle(
                      fontSize: appSize.mediumText,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}