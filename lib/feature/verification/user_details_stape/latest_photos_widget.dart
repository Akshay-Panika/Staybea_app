import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class LatestPhotosWidget extends StatefulWidget {
  const LatestPhotosWidget({super.key});

  @override
  State<LatestPhotosWidget> createState() => _LatestPhotosWidgetState();
}

class _LatestPhotosWidgetState extends State<LatestPhotosWidget> {
  List<File?> images = List.generate(6, (_) => null);

  /// Pick multiple images
  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> selectedFiles =
      result.paths.map((path) => File(path!)).toList();

      setState(() {
        for (var file in selectedFiles) {
          // Find first empty slot
          int index = images.indexOf(null);
          if (index != -1) {
            images[index] = file;
          } else {
            break; // no more empty slots
          }
        }
      });
    }
  }

  /// Pick single image for replace
  Future<void> replaceImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        images[index] = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                children: [
                  /// Image container
                  GestureDetector(
                    onTap: () {
                      if (images[index] == null) {
                        pickImages();
                      } else {
                        replaceImage(index);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade300),
                        image: images[index] != null
                            ? DecorationImage(
                          image: FileImage(images[index]!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                    ),
                  ),

                  /// Add button (only if empty)
                  if (images[index] == null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: pickImages,
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFA54275),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),

                  /// Remove button (only if image exists)
                  if (images[index] != null)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            images[index] = null;
                          });
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}