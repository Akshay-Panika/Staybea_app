import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class LatestPhotos extends StatefulWidget {
  const LatestPhotos({super.key});

  @override
  State<LatestPhotos> createState() => _LatestPhotosState();
}

class _LatestPhotosState extends State<LatestPhotos> {
  List<File?> photos = List.generate(5, (index) => null);

  Future<void> pickImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        photos[index] = File(result.files.single.path!);
      });
    }
  }

  Widget _photoBox({
    required int index,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: () => pickImage(index),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
          image: photos[index] != null
              ? DecorationImage(
            image: FileImage(photos[index]!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: photos[index] == null
            ? Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 00),
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFAD3B6E), // mauve/berry accent
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    AppSize appSize = AppSize(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        const gap = 10.0;

        final colWidth = (totalWidth - gap) / 2;

        const topRowHeight = 130.0;
        const tallHeight = topRowHeight * 2 + gap;
        const bottomRowHeight = 130.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Add Your Latest Photos.",
              style: TextStyle(
                fontSize: appSize.largeText,
                fontWeight: FontWeight.bold,
              ),
            ),
            6.height,
             Text(
              "Add 2 photos to begin. Add more to make your profile shine.",
              style: TextStyle(color: Colors.grey, fontSize: appSize.mediumText),
            ),
             SizedBox(height: appSize.height*0.02),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _photoBox(
                  index: 0,
                  width: colWidth,
                  height: tallHeight,
                ),
                const SizedBox(width: gap),
                // Right: two stacked photos (index 1 & 2)
                Column(
                  children: [
                    _photoBox(
                      index: 1,
                      width: colWidth,
                      height: topRowHeight,
                    ),
                    const SizedBox(height: gap),
                    _photoBox(
                      index: 2,
                      width: colWidth,
                      height: topRowHeight,
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: gap),

            Row(
              children: [
                _photoBox(
                  index: 3,
                  width: colWidth,
                  height: bottomRowHeight,
                ),
                const SizedBox(width: gap),
                _photoBox(
                  index: 4,
                  width: colWidth,
                  height: bottomRowHeight,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}